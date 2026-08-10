#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
쿠팡 파트너스 상품 검색 → product_cache 갱신 배치
=====================================================
사용법:
  1. 쿠팡 파트너스 최종승인 후 발급받은 키를 아래 ACCESS_KEY / SECRET_KEY에 입력
     (또는 환경변수 COUPANG_ACCESS_KEY / COUPANG_SECRET_KEY 로 주입)
  2. python3 coupang_batch.py            → 실제 API 호출 & 캐시 갱신
     python3 coupang_batch.py --dry-run  → API 호출 없이 목업 데이터로 캐시 채우기 (개발용)

설계 원칙:
  - Search API 호출 제한(시간당 10회)을 지키기 위해 호출 간 410초 대기 (~8.7회/시간)
  - 키워드는 DB에서 자동 생성: 오일필터 품번 + 엔진오일 점도 조합 (유한하므로 캐시 가능)
  - 사용자 트래픽과 API 호출이 완전히 분리됨 → 서비스는 캐시만 읽음
  - cron 등록 예: 0 3 * * * python3 /path/coupang_batch.py  (매일 새벽 3시)
"""
import hmac, hashlib, json, os, sqlite3, sys, time, urllib.parse, urllib.request
from datetime import datetime, timezone

# ── 설정 ──────────────────────────────────────────────
ACCESS_KEY = os.environ.get("COUPANG_ACCESS_KEY", "")   # TODO: 파트너스 최종승인 후 입력
SECRET_KEY = os.environ.get("COUPANG_SECRET_KEY", "")   # TODO
DB_PATH    = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "data", "car_oil.db")
DOMAIN     = "https://api-gateway.coupang.com"
SEARCH_PATH = "/v2/providers/affiliate_open_api/apis/openapi/v1/products/search"
LIMIT      = 6          # 키워드당 캐시할 상품 수 (API 최대 10)
CALL_GAP_S = 410        # 호출 간격(초) — 시간당 10회 제한 준수
DRY_RUN    = "--dry-run" in sys.argv


def build_keywords(conn):
    """DB에서 캐시 대상 키워드 자동 생성: 점도 + 필터 품번"""
    cur = conn.cursor()
    kws = set()
    for (v,) in cur.execute("SELECT DISTINCT viscosity FROM engine_oil_specs WHERE viscosity IS NOT NULL"):
        kws.add(f"{v} 합성 엔진오일")
    for pt, pn in cur.execute("SELECT DISTINCT part_type, part_number FROM parts"):
        kws.add(f"{pn} {pt}")   # "26300-35505 오일필터" / "97133-D1000 에어컨필터" / "650mm 와이퍼"
    return sorted(kws)


def generate_hmac(method, full_path):
    """쿠팡 CEA(HmacSHA256) 인증 헤더 생성"""
    path, *query = full_path.split("?")
    dt = datetime.now(timezone.utc).strftime("%y%m%dT%H%M%SZ")
    message = dt + method + path + (query[0] if query else "")
    signature = hmac.new(SECRET_KEY.encode(), message.encode(), hashlib.sha256).hexdigest()
    return (f"CEA algorithm=HmacSHA256, access-key={ACCESS_KEY}, "
            f"signed-date={dt}, signature={signature}")


def search_products(keyword):
    """파트너스 상품 검색 API 호출 → 상품 dict 리스트"""
    q = urllib.parse.urlencode({"keyword": keyword, "limit": LIMIT})
    full_path = f"{SEARCH_PATH}?{q}"
    req = urllib.request.Request(
        DOMAIN + full_path,
        headers={"Authorization": generate_hmac("GET", full_path),
                 "Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=15) as resp:
        data = json.loads(resp.read().decode())
    products = data.get("data", {}).get("productData", [])
    return [{
        "name":   p.get("productName", ""),
        "price":  p.get("productPrice"),
        "image":  p.get("productImage", ""),
        "url":    p.get("productUrl", ""),     # 트래킹 코드 포함된 제휴 링크
        "rocket": 1 if p.get("isRocket") else 0,
        "rank":   p.get("rank", 0),
    } for p in products]


def mock_products(keyword):
    """--dry-run: 개발/데모용 목업 데이터"""
    base = [
        ("킥스 PAO1 {v} 합성엔진오일 4L", 32900, 1),
        ("모빌1 {v} 어드밴스드 합성유 4L", 47500, 1),
        ("지크 X9 {v} 100% 합성 4L", 29800, 0),
        ("캐스트롤 엣지 {v} 티타늄 4L", 41200, 1),
    ] if "엔진오일" in keyword else [
        ("보쉬 에어로트윈 와이퍼 {p}", 12900, 1),
        ("현대모비스 순정 와이퍼 {p}", 9800, 0),
        ("불스원 레인OK 하이브리드 {p}", 8900, 1),
    ] if "와이퍼" in keyword else [
        ("현대모비스 순정 에어컨필터 {p}", 8900, 1),
        ("{p} 호환 활성탄 에어컨필터 2개입", 13900, 1),
        ("3M 초미세먼지 에어컨필터 {p} 호환", 11500, 0),
    ] if "에어컨필터" in keyword else [
        ("현대모비스 순정 오일필터 {p}", 4900, 1),
        ("{p} 호환 오일필터 3개 세트", 12800, 0),
        ("불스원 프리미엄 오일필터 {p} 호환", 6300, 1),
    ]
    v = keyword.split(" ")[0]
    return [{"name": n.format(v=v, p=v), "price": pr,
             "image": "", "url": f"https://www.coupang.com/np/search?q={urllib.parse.quote(keyword)}",
             "rocket": r, "rank": i + 1}
            for i, (n, pr, r) in enumerate(base)]


def refresh_cache(conn, keyword, products):
    cur = conn.cursor()
    cur.execute("DELETE FROM product_cache WHERE keyword = ? AND manual = 0", (keyword,))  # 수동 등록분 보존
    now = datetime.now().isoformat(timespec="seconds")
    cur.executemany("""
        INSERT INTO product_cache (keyword, product_name, price, image_url, product_url, is_rocket, rank, fetched_at, manual)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0)""",
        [(keyword, p["name"], p["price"], p["image"], p["url"], p["rocket"], p["rank"], now)
         for p in products])
    conn.commit()


def main():
    if not DRY_RUN and (not ACCESS_KEY or not SECRET_KEY):
        sys.exit("[중단] API 키가 없습니다. 파트너스 최종승인 후 키를 설정하거나 --dry-run으로 실행하세요.")

    conn = sqlite3.connect(DB_PATH)
    keywords = build_keywords(conn)
    print(f"캐시 대상 키워드 {len(keywords)}개: {keywords}")

    for i, kw in enumerate(keywords):
        try:
            products = mock_products(kw) if DRY_RUN else search_products(kw)
            refresh_cache(conn, kw, products)
            print(f"[{i+1}/{len(keywords)}] '{kw}' → {len(products)}개 캐시 완료")
        except Exception as e:
            print(f"[{i+1}/{len(keywords)}] '{kw}' 실패: {e} (기존 캐시 유지)")
        if not DRY_RUN and i < len(keywords) - 1:
            time.sleep(CALL_GAP_S)   # 호출 제한 준수

    conn.close()
    print("배치 완료")


if __name__ == "__main__":
    main()
