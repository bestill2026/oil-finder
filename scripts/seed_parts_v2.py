#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
seed_parts_v2.py — 부품 시드 원장 v2: 수입차 + KGM·르노코리아·한국GM
=====================================================================
- 에어컨필터: 2026-08-10 웹 검증분만 verified=1 (만필터 공식몰·수입부품몰)
  · 벤츠 W205/W213/X253 = MANN CUK 26023(내부) + CU 25002(외부) [이중 필터 구조]
  · BMW F30 = 64119237555(=CUK 25 001) / F10 = 64119163329(=CUK 2533) / G30 = CUK 23014-2
  · 렉서스 = 토요타 공용 87139-30040 (지식 추정 v=0)
  · 아우디·기타 미확인 세대는 미수록 (칩 숨김)
- 와이퍼: 전량 지식 추정(v=0), 차기 라운드 검증 대상
"""
import sqlite3, os
DB = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "data", "car_oil.db")

# (세대, [(brand, pn, verified)])
CABIN = {
 "W205": [("MANN (내부)", "CUK 26023", 1), ("MANN (외부)", "CU 25002", 1)],
 "W213": [("MANN (내부)", "CUK 26023", 1), ("MANN (외부)", "CU 25002", 1)],
 "X253": [("MANN (내부)", "CUK 26023", 1), ("MANN (외부)", "CU 25002", 1)],
 "W206": [("MANN (내부)", "CUK 26023", 0)],
 "W212": [("벤츠(OE)", "A2128300318", 0)],
 "F30":  [("BMW(OE)", "64119237555", 1), ("MANN-FILTER", "CUK 25 001", 1)],
 "F10":  [("BMW(OE)", "64119163329", 1), ("MANN-FILTER", "CUK 2533", 1)],
 "G30":  [("MANN-FILTER", "CUK 23014-2", 1)],
 "XV60": [("토요타(OE)", "87139-30040", 0)],
 "XV70": [("토요타(OE)", "87139-30040", 0)],
 "AZ20": [("토요타(OE)", "87139-30040", 0)],
 "AL20": [("토요타(OE)", "87139-30040", 0)],
 "AL30": [("토요타(OE)", "87139-30040", 0)],
 "MZAA10": [("토요타(OE)", "87139-30040", 0)],
}

# (세대: (운전석mm, 조수석mm)) — 전량 추정
WIPER = {
 "W205": (550,550), "W206": (650,500), "W212": (600,600), "W213": (650,500),
 "W214": (650,500), "W222": (650,500), "W223": (650,500), "X253": (550,550), "W167": (650,500),
 "F30": (600,450), "G20": (650,450), "F10": (650,450), "G30": (650,500), "G60": (650,500),
 "G11": (650,500), "G01": (650,500), "G05": (650,500),
 "B8": (600,500), "B9": (600,500), "C7": (650,500), "C8": (650,500),
 "FY": (600,500), "4M": (650,500), "8V": (650,450),
 "XV60": (650,450), "XV70": (650,450), "AZ20": (650,400),
 "AL20": (650,500), "AL30": (650,450), "MZAA10": (650,400),
 "X100": (600,400), "C300": (600,400), "G4/Y400": (650,400), "J100": (650,400),
 "LFD": (600,500), "HZG": (600,500), "JL1": (600,450), "HC": (650,450),
 "M300/M400": (550,400), "J300": (600,450), "9세대": (600,450),
 "TU": (600,400), "9BUC": (650,400), "9BYC": (650,400),
}
REAR_MM = 300  # SUV·미니밴 후방 일괄 추정

def main():
    conn = sqlite3.connect(DB)
    cur = conn.cursor()
    cur.execute("""SELECT v.id, v.generation, v.body_type FROM vehicles v
        JOIN manufacturers m ON m.id=v.manufacturer_id
        WHERE m.name IN ('벤츠','BMW','아우디','렉서스','KGM','르노코리아','한국GM')""")
    n_c = n_w = 0
    for vid, gen, body in cur.fetchall():
        for brand, pn, v in CABIN.get(gen, []):
            cur.execute("""INSERT OR IGNORE INTO parts
                (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
                VALUES (?, '에어컨필터', NULL, ?, ?, ?, ?)""",
                (vid, brand, pn, pn if "OE" in brand else None, v))
            n_c += cur.rowcount
        if gen in WIPER:
            d, p = WIPER[gen]
            ws = [("운전석", d), ("조수석", p)]
            if body in ("SUV", "미니밴"):
                ws.append(("후방", REAR_MM))
            for label, mm in ws:
                cur.execute("""INSERT OR IGNORE INTO parts
                    (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
                    VALUES (?, '와이퍼', ?, '규격', ?, NULL, 0)""", (vid, label, f"{mm}mm"))
                n_w += cur.rowcount
    conn.commit()
    print(f"에어컨필터 {n_c}건 / 와이퍼 {n_w}건 시드")
    cur.execute("SELECT part_type, count(*), sum(verified) FROM parts GROUP BY part_type")
    for r in cur.fetchall(): print(f"  {r[0]}: {r[1]}건 (verified {r[2]})")
    conn.close()

if __name__ == "__main__":
    main()
