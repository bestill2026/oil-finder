#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
export_ui.py — 빌드 파이프라인 (마스터 프롬프트 §5.4)
=====================================================
car_oil.db에서 차량 데이터와 상품 캐시를 추출해
템플릿(template.html)의 플레이스홀더에 주입, 최종 index.html을 생성합니다.

사용법:
  python3 export_ui.py [--template template.html] [--out index.html]

일일 배치 순서 (GitHub Actions 기준):
  1) python3 coupang_batch.py          # 상품 캐시 갱신 (승인 전엔 --dry-run)
  2) python3 export_ui.py              # HTML 재생성
  3) git commit & push                 # GitHub Pages 자동 재배포
"""
import sqlite3, json, os, sys

BASE = os.path.dirname(os.path.abspath(__file__))
DB   = os.path.join(BASE, "..", "data", "car_oil.db")

def arg(flag, default):
    return sys.argv[sys.argv.index(flag) + 1] if flag in sys.argv else default

TEMPLATE = os.path.join(BASE, arg("--template", "oil_finder_gds_template.html"))
OUT      = os.path.join(BASE, arg("--out", "oil_finder.html"))


def export_vehicles(conn):
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()
    cur.execute("""
        SELECT v.id, m.name AS mfr, v.model_name, v.generation, v.year_start, v.year_end,
               v.engine_code, v.fuel_type, v.displacement_cc, v.trim_note, v.body_type,
               s.viscosity, s.api_grade, s.ilsac_grade, s.oil_type, s.capacity_liters,
               s.change_interval_km, s.severe_interval_km, s.source
        FROM vehicles v
        JOIN manufacturers m ON m.id = v.manufacturer_id
        LEFT JOIN engine_oil_specs s ON s.vehicle_id = v.id
        ORDER BY m.id, v.model_name, v.year_start, v.id""")
    vehicles = []
    for r in cur.fetchall():
        c2 = conn.cursor()
        c2.execute("""SELECT part_type, label, brand, part_number, verified
                      FROM parts WHERE vehicle_id=? ORDER BY part_type, id""", (r["id"],))
        filters, extras = [], {}
        for pt, label, brand, pn, ver in c2.fetchall():
            if pt == "오일필터":
                filters.append({"brand": brand, "pn": pn})
            else:
                extras.setdefault(pt, []).append(
                    {"label": label, "brand": brand, "pn": pn, "v": bool(ver)})
        vehicles.append({
            "id": r["id"], "mfr": r["mfr"], "model": r["model_name"], "gen": r["generation"],
            "cat": r["body_type"],
            "ys": r["year_start"], "ye": r["year_end"], "engine": r["engine_code"],
            "fuel": r["fuel_type"], "cc": r["displacement_cc"], "trim": r["trim_note"],
            "oil": {"visc": r["viscosity"], "api": r["api_grade"], "ilsac": r["ilsac_grade"],
                    "type": r["oil_type"], "cap": r["capacity_liters"],
                    "interval": r["change_interval_km"], "severe": r["severe_interval_km"],
                    "verified": "verified" in (r["source"] or "")},
            "filters": filters, "extras": extras})
    return vehicles


def export_cache(conn):
    cur = conn.cursor()
    cur.execute("""SELECT keyword, product_name, price, product_url, is_rocket, fetched_at, manual
                   FROM product_cache ORDER BY keyword, manual DESC, rank""")
    cache, cdate = {}, ""
    for kw, name, price, url, rocket, fa, manual in cur.fetchall():
        cache.setdefault(kw, []).append({"name": name, "price": price, "url": url,
                                         "rocket": bool(rocket), "manual": bool(manual)})
        cdate = fa[:10]
    return cache, cdate


def main():
    conn = sqlite3.connect(DB)
    vehicles = export_vehicles(conn)
    cache, cdate = export_cache(conn)
    conn.close()

    tpl = open(TEMPLATE, encoding="utf-8").read()
    for ph in ("__DATA__", "__CACHE__", "__CACHE_DATE__"):
        if ph not in tpl:
            sys.exit(f"[중단] 템플릿에 {ph} 플레이스홀더가 없습니다: {TEMPLATE}")

    html = (tpl.replace("__DATA__", json.dumps(vehicles, ensure_ascii=False, separators=(",", ":")))
               .replace("__CACHE__", json.dumps(cache, ensure_ascii=False, separators=(",", ":")))
               .replace("__CACHE_DATE__", cdate))
    open(OUT, "w", encoding="utf-8").write(html)
    print(f"생성 완료: {OUT}")
    print(f"  차량 {len(vehicles)}건 / 캐시 키워드 {len(cache)}개 / 기준일 {cdate} / {len(html)//1024}KB")


if __name__ == "__main__":
    main()
