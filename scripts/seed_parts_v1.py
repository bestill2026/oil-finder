#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
seed_parts_v1.py — 부품 확장 시드 원장 v1 (에어컨필터 + 와이퍼)
================================================================
범위: 현대·기아 (제네시스는 현대에 병합됨). 수입차는 2차.
신뢰도: 전량 knowledge(estimate). 검증 라운드(v3+)에서 verified 승격 예정.

규칙:
- 에어컨필터: 2015년 이후 현대기아 플랫폼 공용 품번 97133-D1000 (추정),
  2010~2014 구형은 97133-2H000 (추정). 경차(모닝/레이/캐스퍼)는 품번 상이 → 미수록(칩 숨김).
- 와이퍼: 모델별 운전석/조수석 사이즈(mm). SUV·미니밴은 후방 300mm 일괄 추정.
- 실행: python3 seed_parts_v1.py  (재실행 안전 — INSERT OR IGNORE)
"""
import sqlite3, os

DB = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "data", "car_oil.db")

# 모델별 와이퍼 사이즈 (운전석, 조수석) — 전량 추정
WIPER = {
    "아반떼": (650, 400), "쏘나타": (650, 450), "그랜저": (650, 450),
    "투싼": (650, 400), "싼타페": (650, 450), "팰리세이드": (650, 450),
    "코나": (650, 400), "베뉴": (550, 400), "벨로스터": (650, 400),
    "스타리아": (650, 450),
    "모닝": (550, 400), "레이": (500, 400), "캐스퍼": (550, 400),
    "K3": (650, 400), "K5": (650, 450), "K7": (650, 450), "K8": (650, 450), "K9": (650, 450),
    "쏘렌토": (650, 450), "스포티지": (650, 400), "셀토스": (650, 400),
    "니로": (650, 400), "카니발": (650, 450), "스팅어": (600, 450), "모하비": (600, 500),
    "G70": (650, 400), "G80": (650, 450), "G90": (650, 450),
    "GV70": (650, 450), "GV80": (650, 450),
}
REAR_MM = 300  # SUV·미니밴 후방 (일괄 추정)
CABIN_SKIP = {"모닝", "레이", "캐스퍼"}  # 경차 품번 상이 — 수집 전까지 미수록


def cabin_pn(year_start):
    return "97133-D1000" if year_start >= 2015 else "97133-2H000"


def main():
    conn = sqlite3.connect(DB)
    cur = conn.cursor()
    cur.execute("""
        SELECT v.id, v.model_name, v.year_start, v.body_type
        FROM vehicles v JOIN manufacturers m ON m.id = v.manufacturer_id
        WHERE m.name IN ('현대', '기아')""")
    rows = cur.fetchall()

    n_cabin = n_wiper = 0
    for vid, model, ys, body in rows:
        # 에어컨필터
        if model not in CABIN_SKIP:
            cur.execute("""INSERT OR IGNORE INTO parts
                (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
                VALUES (?, '에어컨필터', NULL, '현대모비스(OE)', ?, ?, 0)""",
                (vid, cabin_pn(ys), cabin_pn(ys)))
            n_cabin += cur.rowcount
        # 와이퍼
        if model in WIPER:
            d, p = WIPER[model]
            wipers = [("운전석", d), ("조수석", p)]
            if body in ("SUV", "미니밴"):
                wipers.append(("후방", REAR_MM))
            for label, mm in wipers:
                cur.execute("""INSERT OR IGNORE INTO parts
                    (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
                    VALUES (?, '와이퍼', ?, '규격', ?, NULL, 0)""",
                    (vid, label, f"{mm}mm"))
                n_wiper += cur.rowcount

    conn.commit()
    print(f"에어컨필터 {n_cabin}건 / 와이퍼 {n_wiper}건 시드 완료")
    cur.execute("SELECT part_type, count(*), sum(verified) FROM parts GROUP BY part_type")
    for r in cur.fetchall():
        print(f"  {r[0]}: {r[1]}건 (verified {r[2]})")
    conn.close()


if __name__ == "__main__":
    main()
