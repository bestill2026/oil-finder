#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
수동 상품 링크 등록 도구
========================
쿠팡에서 직접 찾은 상품 상세 페이지 URL을 캐시에 등록합니다.
파트너스 API 연동 전까지 상품 카드가 상세 페이지로 랜딩하게 하는 임시 수단이며,
배치(coupang_batch.py)가 돌아도 수동 등록분은 삭제되지 않습니다.

사용법:
  python3 add_manual_product.py "키워드" "상품URL" "상품명" 가격 [--rocket]

예시:
  python3 add_manual_product.py \\
    "26300-35505 오일필터" \\
    "https://www.coupang.com/vp/products/1234567?itemId=890&vendorItemId=777" \\
    "현대모비스 순정 오일필터 26300-35505" 4900 --rocket

키워드는 UI의 상품 스트립 단위와 일치해야 합니다:
  - 엔진오일: "{점도} 합성 엔진오일"  (예: "0W-20 합성 엔진오일")
  - 오일필터: "{OE품번} 오일필터"     (예: "26320-2R000 오일필터")
등록된 키워드 목록 확인: python3 add_manual_product.py --list
"""
import sqlite3, sys, os
from datetime import datetime
from urllib.parse import urlparse, parse_qs

DB = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "data", "car_oil.db")

def validate_url(url):
    """상품 상세 URL인지 검증 (검색 URL이면 경고)"""
    u = urlparse(url)
    if "coupang.com" not in u.netloc:
        return "쿠팡 URL이 아닙니다."
    if "/np/search" in u.path:
        return "검색결과 URL입니다. 상품 상세 페이지 URL(/vp/products/...)을 넣어주세요."
    if "/vp/products/" not in u.path:
        return "상품 상세 URL 형식(/vp/products/...)이 아닙니다."
    q = parse_qs(u.query)
    if "vendorItemId" not in q:
        return None if "itemId" in q else "옵션 파라미터(itemId/vendorItemId)가 없어 기본 옵션으로 열립니다. (등록은 가능)"
    return None

def main():
    conn = sqlite3.connect(DB)
    cur = conn.cursor()

    if "--list" in sys.argv:
        cur.execute("SELECT keyword, count(*), sum(manual) FROM product_cache GROUP BY keyword")
        print(f"{'키워드':<28} {'전체':>4} {'수동':>4}")
        for k, n, m in cur.fetchall():
            print(f"{k:<28} {n:>4} {m or 0:>4}")
        return

    args = [a for a in sys.argv[1:] if a != "--rocket"]
    if len(args) < 4:
        sys.exit(__doc__)
    keyword, url, name, price = args[0], args[1], args[2], int(args[3])
    rocket = 1 if "--rocket" in sys.argv else 0

    warn = validate_url(url)
    if warn:
        print(f"[주의] {warn}")
        if "검색결과" in warn or "쿠팡 URL이" in warn:
            sys.exit("등록 중단.")

    now = datetime.now().isoformat(timespec="seconds")
    cur.execute("""INSERT INTO product_cache
        (keyword, product_name, price, image_url, product_url, is_rocket, rank, fetched_at, manual)
        VALUES (?, ?, ?, '', ?, ?, 0, ?, 1)""",
        (keyword, name, price, url, rocket, now))
    conn.commit()
    print(f"등록 완료: [{keyword}] {name} ({price:,}원)")
    print("→ export_ui.py 실행(또는 배치 후 HTML 재생성) 시 상품 카드에 반영됩니다.")

if __name__ == "__main__":
    main()
