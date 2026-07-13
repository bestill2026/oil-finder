#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
시드 v3 생성: 10개 제조사, 최근 15년(2011~) 주요 모델
- verified: 이전 웹 검증 데이터/품번 패턴 유지
- estimate: 지식 기반 입력 → 실서비스 전 취급설명서·MANN 카탈로그 재검증 필요
"""
import sqlite3, os

DB = os.path.join(os.path.dirname(__file__), "car_oil.db")

# 공통 필터 상수 (현대·기아·제네시스 패턴)
F35505 = [("현대모비스(OE)", "26300-35505", 1)]          # 감마/누우/세타2 가솔린 공통 (verified 패턴)
F2M    = [("현대모비스(OE)", "26350-2M000", 1)]          # 1.6 T-GDI/HEV 에코 (verified 패턴)
F2S    = [("현대모비스(OE)", "26350-2S000", 1),
          ("Bosch",         "O 0367",      1)]           # 2.5/3.5 스마트스트림 (verified 패턴)
F2R    = [("현대모비스(OE)", "26320-2R000", 1)]          # 스마트스트림 D2.0/2.2 (verified 패턴)
F2A5   = [("현대모비스(OE)", "26320-2A500", 0)]          # 구형 R엔진 디젤 (estimate)
FKAPPA = [("현대모비스(OE)", "26300-02503", 0)]          # 카파 1.0/1.2 (estimate)

# 오일 프리셋: (visc, api, ilsac, type, interval, severe)
G_OLD  = ("5W-30", "SN",           "GF-5", "합성유",                    15000, 7500)   # 2011~19 가솔린
G_SS   = ("0W-20", "SN PLUS/SP",   "GF-6", "합성유(Full Synthetic)",    15000, 7500)   # 스마트스트림
D_OLD  = ("5W-30", None,           None,   "합성유 (ACEA C3)",          20000, 10000)  # 구형 디젤(DPF)
D_SS   = ("0W-30", None,           None,   "합성유 (ACEA C5/C2/C3)",    20000, 10000)  # 스마트스트림 디젤
MB_G   = ("0W-30", None, None, "합성유 · MB 229.5 인증",   20000, 10000)
MB_G20 = ("0W-20", None, None, "합성유 · MB 229.71 인증",  20000, 10000)
MB_D   = ("5W-30", None, None, "합성유 · MB 229.52 인증",  20000, 10000)
BMW_G  = ("0W-30", None, None, "합성유 · BMW LL-01 인증",  20000, 10000)
BMW_G2 = ("0W-20", None, None, "합성유 · BMW LL-17FE+ 인증", 20000, 10000)
BMW_D  = ("5W-30", None, None, "합성유 · BMW LL-04 인증",  20000, 10000)
VW_G   = ("5W-30", None, None, "합성유 · VW 502.00/504.00 인증", 15000, 10000)
VW_D   = ("5W-30", None, None, "합성유 · VW 507.00 인증",  15000, 10000)
LEX_H  = ("0W-20", "SN 이상", "GF-5 이상", "합성유", 15000, 7500)
LEX_G  = ("0W-20", "SN 이상", "GF-5 이상", "합성유", 15000, 7500)
KGM_G  = ("5W-30", "SN 이상", None, "합성유", 15000, 7500)
KGM_D  = ("5W-30", None, None, "합성유 (ACEA C3)", 15000, 10000)
RSM_G  = ("5W-30", None, None, "합성유 (RN0700/0710)", 15000, 7500)
GM_G   = ("5W-30", None, None, "합성유 (dexos1 Gen3)", 12000, 6000)

EST = "knowledge(estimate)"
VER = "취급설명서/부품몰(verified)"

def row(model, gen, ys, ye, eng, fuel, cc, trim, oil, cap, src, note, filters):
    v, api, il, ot, itv, sev = oil
    return (model, gen, ys, ye, eng, fuel, cc, trim, v, api, il, ot, cap, itv, sev, src, note, filters)

# ══════════════ 현대 ══════════════
HY = [
 # 아반떼 (기존 verified 유지)
 row("아반떼","MD",2010,2015,"감마 1.6 GDI","가솔린",1591,"기본",("5W-20","SM 이상","GF-4","합성유 권장",15000,7500),3.6,EST,None,F35505),
 row("아반떼","AD",2015,2018,"감마 1.6 GDI","가솔린",1591,"기본",("5W-30","SM 이상","GF-4 이상","합성유 권장",15000,7500),3.6,VER,"5W-20도 사용 가능",F35505),
 row("아반떼","AD",2018,2020,"스마트스트림 G1.6","가솔린",1598,"더 뉴 아반떼",G_SS,4.0,VER,None,F35505),
 row("아반떼","CN7",2020,None,"스마트스트림 G1.6","가솔린",1598,"기본",("0W-20","SN PLUS 이상 (SP)","GF-6","합성유(Full Synthetic)",15000,7500),3.8,VER,None,F35505),
 row("아반떼","CN7",2021,None,"스마트스트림 G1.6 T-GDI","가솔린",1598,"N라인",G_SS,3.8,VER,None,F35505),
 row("아반떼","CN7",2020,None,"스마트스트림 LPI","LPG",1598,"기본",("5W-20","SN PLUS 이상",None,"합성유",15000,7500),3.6,VER,None,F35505),
 row("아반떼","CN7",2021,None,"스마트스트림 하이브리드","하이브리드",1580,"기본",("0W-20","SN PLUS 이상",None,"저점도 합성유(C2)",15000,7500),3.6,VER,None,F2M),
 # 쏘나타
 row("쏘나타","YF",2009,2014,"세타2 2.0 MPI","가솔린",1998,"기본",G_OLD,4.1,EST,None,F35505),
 row("쏘나타","LF",2014,2019,"누우 2.0 CVVL","가솔린",1999,"기본",G_OLD,4.1,EST,None,F35505),
 row("쏘나타","LF",2015,2019,"감마 1.6 T-GDI","가솔린",1591,"에코",G_OLD,4.0,EST,None,F2M),
 row("쏘나타","DN8",2019,None,"스마트스트림 G2.0","가솔린",1999,"기본",G_SS,4.0,EST,None,F35505),
 row("쏘나타","DN8",2019,None,"스마트스트림 G1.6 T-GDI","가솔린",1598,"센슈어스",G_SS,4.5,EST,None,F2M),
 row("쏘나타","DN8",2019,None,"스마트스트림 G2.5 T-GDI","가솔린",2497,"N라인",("0W-30","SN PLUS/SP","GF-6","합성유",15000,7500),5.8,EST,None,F2S),
 row("쏘나타","DN8",2019,None,"스마트스트림 G2.0 HEV","하이브리드",1999,"기본",G_SS,4.2,EST,None,F35505),
 # 그랜저
 row("그랜저","HG",2011,2016,"세타2 2.4 GDI","가솔린",2359,"기본",G_OLD,5.1,EST,None,F35505),
 row("그랜저","HG",2011,2016,"람다2 3.0 GDI","가솔린",2999,"기본",G_OLD,6.0,EST,None,[("현대모비스(OE)","26320-3C30A",0)]),
 row("그랜저","IG",2016,2022,"세타2 2.4 GDI","가솔린",2359,"기본",G_OLD,5.1,EST,None,F35505),
 row("그랜저","IG",2016,2022,"람다2 3.0 GDI","가솔린",2999,"기본",G_OLD,6.0,EST,None,[("현대모비스(OE)","26320-3C30A",0)]),
 row("그랜저","IG FL",2019,2022,"스마트스트림 G2.5 GDI","가솔린",2497,"기본",("0W-20","SN PLUS 이상 (SP)","GF-6","합성유",15000,7500),5.8,VER,None,F2S),
 row("그랜저","GN7",2022,None,"스마트스트림 G2.5 GDI","가솔린",2497,"기본",("0W-20","SN PLUS 이상 (SP)","GF-6","합성유(Full Synthetic)",15000,7500),5.8,VER,"0W-30도 사용 가능",F2S),
 row("그랜저","GN7",2022,None,"스마트스트림 G3.5 LPI","LPG",3470,"기본",("0W-20","SN PLUS 이상 (SP)",None,"합성유",15000,7500),6.0,EST,None,F2S),
 row("그랜저","GN7",2022,None,"스마트스트림 G1.6 T-GDI HEV","하이브리드",1598,"기본",("0W-20","SN PLUS 이상",None,"합성유",15000,7500),5.0,VER,"ACEA A5/B5 대체 가능",F2M),
 # 투싼
 row("투싼","ix(LM)",2010,2015,"R 2.0 디젤","디젤",1995,"기본",D_OLD,6.4,EST,None,F2A5),
 row("투싼","TL",2015,2020,"감마 1.6 T-GDI","가솔린",1591,"기본",G_OLD,4.0,EST,None,F2M),
 row("투싼","TL",2015,2020,"R 2.0 디젤","디젤",1995,"기본",D_OLD,6.4,EST,None,F2A5),
 row("투싼","NX4",2020,None,"스마트스트림 D2.0","디젤",1998,"기본",D_SS,6.0,EST,None,F2R),
 row("투싼","NX4",2020,None,"스마트스트림 G1.6 T-GDI","가솔린",1598,"기본",G_SS,4.5,EST,None,F2M),
 row("투싼","NX4",2021,None,"스마트스트림 G1.6 T-GDI HEV","하이브리드",1598,"기본",G_SS,4.8,EST,None,F2M),
 # 싼타페
 row("싼타페","DM",2012,2018,"R 2.0 디젤","디젤",1995,"기본",D_OLD,6.4,EST,None,F2A5),
 row("싼타페","DM",2012,2018,"R 2.2 디젤","디젤",2199,"기본",D_OLD,6.6,EST,None,F2A5),
 row("싼타페","TM",2018,2023,"R 2.0 디젤","디젤",1995,"기본",D_OLD,6.4,EST,None,F2A5),
 row("싼타페","TM",2020,2023,"스마트스트림 G2.5 T-GDI","가솔린",2497,"기본",("0W-30","SN PLUS/SP","GF-6","합성유",15000,7500),5.8,EST,None,F2S),
 row("싼타페","TM",2021,2023,"스마트스트림 G1.6 T-GDI HEV","하이브리드",1598,"기본",G_SS,4.8,EST,None,F2M),
 row("싼타페","MX5",2023,None,"스마트스트림 G2.5 T-GDI","가솔린",2497,"기본",("0W-30","SN PLUS/SP","GF-6","합성유",15000,7500),5.8,EST,None,F2S),
 row("싼타페","MX5",2023,None,"스마트스트림 G1.6 T-GDI HEV","하이브리드",1598,"기본",G_SS,4.8,EST,None,F2M),
 # 팰리세이드 / 코나 / 베뉴 / 캐스퍼 / 벨로스터 / 스타리아
 row("팰리세이드","LX2",2018,2025,"람다2 3.8 GDI","가솔린",3778,"기본",G_OLD,6.9,EST,None,[("현대모비스(OE)","26320-3C30A",0)]),
 row("팰리세이드","LX2",2018,2025,"R 2.2 디젤","디젤",2199,"기본",D_SS,5.6,EST,"스마트스트림 D2.2",F2R),
 row("팰리세이드","LX3",2025,None,"스마트스트림 G2.5 T-GDI","가솔린",2497,"기본",("0W-30","SP","GF-6","합성유",15000,7500),5.8,EST,None,F2S),
 row("코나","OS",2017,2023,"감마 1.6 T-GDI","가솔린",1591,"기본",G_OLD,4.0,EST,None,F2M),
 row("코나","OS",2017,2023,"누우 2.0 MPI","가솔린",1999,"기본",G_OLD,4.1,EST,None,F35505),
 row("코나","OS",2017,2023,"감마 1.6 GDI HEV","하이브리드",1580,"기본",("0W-20","SN 이상",None,"저점도 합성유",15000,7500),3.8,EST,None,F2M),
 row("코나","SX2",2023,None,"스마트스트림 G1.6 T-GDI","가솔린",1598,"기본",G_SS,4.5,EST,None,F2M),
 row("코나","SX2",2023,None,"스마트스트림 G1.6 HEV","하이브리드",1580,"기본",G_SS,3.8,EST,None,F2M),
 row("베뉴","QX",2019,None,"스마일스트림 G1.6","가솔린",1598,"기본",G_SS,3.8,EST,None,F35505),
 row("캐스퍼","AX1",2021,None,"카파 1.0 MPI","가솔린",998,"기본",("0W-20","SN PLUS 이상","GF-6","합성유",15000,7500),3.5,EST,None,FKAPPA),
 row("캐스퍼","AX1",2021,None,"카파 1.0 T-GDI","가솔린",998,"터보",("0W-20","SN PLUS 이상","GF-6","합성유",15000,7500),3.6,EST,None,FKAPPA),
 row("벨로스터","JS",2018,2022,"감마 1.6 T-GDI","가솔린",1591,"기본",G_OLD,4.0,EST,None,F2M),
 row("스타리아","US4",2021,None,"스마트스트림 D2.2","디젤",2199,"기본",D_SS,5.6,EST,None,F2R),
 row("스타리아","US4",2021,None,"스마트스트림 G3.5 LPI","LPG",3470,"기본",("0W-20","SP",None,"합성유",15000,7500),6.0,EST,None,F2S),
]

# ══════════════ 기아 ══════════════
KIA = [
 row("모닝","TA",2011,2017,"카파 1.0 MPI","가솔린",998,"기본",("5W-30","SM 이상","GF-4","합성유 권장",15000,7500),3.4,EST,None,FKAPPA),
 row("모닝","JA",2017,None,"카파 1.0 MPI","가솔린",998,"기본",("0W-20","SN 이상","GF-5 이상","합성유",15000,7500),3.5,EST,None,FKAPPA),
 row("레이","TAM",2011,None,"카파 1.0 MPI","가솔린",998,"기본",("0W-20","SN 이상",None,"합성유",15000,7500),3.5,EST,None,FKAPPA),
 row("K3","YD",2012,2018,"감마 1.6 GDI","가솔린",1591,"기본",("5W-20","SM 이상","GF-4","합성유 권장",15000,7500),3.6,EST,None,F35505),
 row("K3","BD",2018,2024,"스마트스트림 G1.6","가솔린",1598,"기본",G_SS,4.0,EST,None,F35505),
 row("K5","TF",2010,2015,"세타2 2.0 MPI","가솔린",1998,"기본",G_OLD,4.1,EST,None,F35505),
 row("K5","JF",2015,2019,"누우 2.0 CVVL","가솔린",1999,"기본",G_OLD,4.1,EST,None,F35505),
 row("K5","JF",2015,2019,"감마 1.6 T-GDI","가솔린",1591,"기본",G_OLD,4.0,EST,None,F2M),
 row("K5","DL3",2019,None,"스마트스트림 G1.6 T-GDI","가솔린",1598,"기본",G_SS,4.0,VER,None,F2M),
 row("K5","DL3",2019,None,"스마트스트림 G2.0","가솔린",1999,"기본",G_SS,4.0,EST,None,F35505),
 row("K5","DL3",2019,None,"스마트스트림 G2.0 HEV","하이브리드",1999,"기본",G_SS,4.2,EST,None,F35505),
 row("K7","VG",2012,2016,"세타2 2.4 GDI","가솔린",2359,"기본",G_OLD,5.1,EST,None,F35505),
 row("K7","YG",2016,2021,"세타2 2.4 GDI","가솔린",2359,"기본",G_OLD,5.1,EST,None,F35505),
 row("K7","YG",2016,2021,"람다2 3.0 GDI","가솔린",2999,"기본",G_OLD,6.0,EST,None,[("현대모비스(OE)","26320-3C30A",0)]),
 row("K8","GL3",2021,None,"스마트스트림 G2.5 GDI","가솔린",2497,"기본",("0W-20","SP","GF-6","합성유",15000,7500),5.8,VER,None,F2S),
 row("K8","GL3",2021,None,"스마트스트림 G3.5 GDI","가솔린",3470,"기본",("0W-20","SP","GF-6","합성유",15000,7500),6.5,EST,None,F2S),
 row("K8","GL3",2021,None,"스마트스트림 G1.6 T-GDI HEV","하이브리드",1598,"기본",G_SS,5.0,EST,None,F2M),
 row("K9","RJ",2018,None,"람다2 3.8 GDI","가솔린",3778,"기본",G_OLD,6.9,EST,None,[("현대모비스(OE)","26320-3C30A",0)]),
 row("스포티지","SL",2010,2015,"R 2.0 디젤","디젤",1995,"기본",D_OLD,6.4,EST,None,F2A5),
 row("스포티지","QL",2015,2021,"R 2.0 디젤","디젤",1995,"기본",D_OLD,6.4,EST,None,F2A5),
 row("스포티지","QL",2015,2021,"감마 1.6 T-GDI","가솔린",1591,"기본",G_OLD,4.0,EST,None,F2M),
 row("스포티지","NQ5",2021,None,"스마트스트림 G1.6 T-GDI","가솔린",1598,"기본",G_SS,4.5,EST,None,F2M),
 row("스포티지","NQ5",2021,None,"스마트스트림 D2.0","디젤",1998,"기본",D_SS,6.0,EST,None,F2R),
 row("스포티지","NQ5",2021,None,"스마트스트림 G1.6 T-GDI HEV","하이브리드",1598,"기본",("0W-20","SN PLUS 이상","GF-6","합성유(Full Synthetic)",15000,7500),4.8,VER,None,F2M),
 row("쏘렌토","XM",2009,2014,"R 2.2 디젤","디젤",2199,"기본",D_OLD,6.6,EST,None,F2A5),
 row("쏘렌토","UM",2014,2020,"R 2.0 디젤","디젤",1995,"기본",D_OLD,6.4,EST,None,F2A5),
 row("쏘렌토","UM",2014,2020,"R 2.2 디젤","디젤",2199,"기본",D_OLD,6.6,EST,None,F2A5),
 row("쏘렌토","MQ4",2020,None,"스마트스트림 G2.5 T-GDI","가솔린",2497,"기본",("0W-30","SN PLUS/SP","GF-6","합성유",15000,7500),5.8,VER,None,F2S),
 row("쏘렌토","MQ4",2020,None,"스마트스트림 D2.2","디젤",2151,"기본",D_SS,5.6,VER,"ACEA C5/C2/C3",F2R),
 row("쏘렌토","MQ4",2021,None,"스마트스트림 G1.6 T-GDI HEV","하이브리드",1598,"기본",("0W-20","SN PLUS/SP","GF-6","합성유",15000,7500),4.8,VER,None,F2M),
 row("셀토스","SP2",2019,None,"스마트스트림 G1.6 T-GDI","가솔린",1598,"기본",G_SS,4.5,EST,None,F2M),
 row("셀토스","SP2",2019,None,"스마트스트림 G2.0","가솔린",1999,"기본",G_SS,4.0,EST,None,F35505),
 row("니로","DE",2016,2022,"카파 1.6 GDI HEV","하이브리드",1580,"기본",("0W-20","SN 이상","GF-5","저점도 합성유",15000,7500),3.8,EST,None,F35505),
 row("니로","SG2",2022,None,"스마트스트림 G1.6 HEV","하이브리드",1580,"기본",G_SS,3.8,EST,None,F2M),
 row("카니발","YP",2014,2020,"R 2.2 디젤","디젤",2199,"기본",D_OLD,6.6,EST,None,F2A5),
 row("카니발","YP",2014,2020,"람다2 3.3 GDI","가솔린",3342,"기본",G_OLD,6.5,EST,None,[("현대모비스(OE)","26320-3C30A",0)]),
 row("카니발","KA4",2020,None,"스마트스트림 D2.2","디젤",2151,"기본",D_SS,6.5,EST,"용량 재검증 필요",F2R),
 row("카니발","KA4",2020,None,"스마트스트림 G3.5 GDI","가솔린",3470,"기본",("0W-20","SP","GF-6","합성유",15000,7500),6.5,EST,None,F2S),
 row("카니발","KA4",2023,None,"스마트스트림 G1.6 T-GDI HEV","하이브리드",1598,"기본",G_SS,5.0,EST,None,F2M),
 row("스팅어","CK",2017,2023,"세타2 2.0 T-GDI","가솔린",1998,"기본",G_OLD,5.7,EST,None,F35505),
 row("스팅어","CK",2017,2023,"람다2 3.3 T-GDI","가솔린",3342,"기본",G_OLD,6.8,EST,None,[("현대모비스(OE)","26320-3CKA0",0)]),
 row("모하비","HM2",2019,None,"S2 3.0 디젤","디젤",2959,"기본",D_OLD,7.0,EST,"필터 품번 확인 필요",[]),
]

# ══════════════ 제네시스 ══════════════
GEN = [
 row("G70","IK",2017,None,"세타2 2.0 T-GDI","가솔린",1998,"기본",G_OLD,5.7,EST,None,F35505),
 row("G70","IK",2017,None,"람다2 3.3 T-GDI","가솔린",3342,"기본",G_OLD,6.8,EST,None,[("현대모비스(OE)","26320-3CKA0",0)]),
 row("G70","IK FL",2021,None,"스마트스트림 G2.5 T-GDI","가솔린",2497,"기본",("0W-30","SP","GF-6","합성유",15000,7500),5.8,EST,None,F2S),
 row("G80","RG3",2020,None,"스마트스트림 G2.5 T-GDI","가솔린",2497,"기본",("0W-30","SP","GF-6","합성유",15000,7500),5.8,EST,None,F2S),
 row("G80","RG3",2020,None,"스마트스트림 G3.5 T-GDI","가솔린",3470,"기본",("0W-30","SP","GF-6","합성유",15000,7500),6.7,EST,None,F2S),
 row("G90","RS4",2021,None,"스마트스트림 G3.5 T-GDI","가솔린",3470,"기본",("0W-30","SP","GF-6","합성유",15000,7500),6.7,EST,None,F2S),
 row("GV70","JK",2020,None,"스마트스트림 G2.5 T-GDI","가솔린",2497,"기본",("0W-30","SP","GF-6","합성유",15000,7500),5.8,EST,None,F2S),
 row("GV70","JK",2020,None,"스마트스트림 D2.2","디젤",2151,"기본",D_SS,5.6,VER,None,F2R),
 row("GV80","JX",2020,None,"스마트스트림 G2.5 T-GDI","가솔린",2497,"기본",("0W-30","SP","GF-6","합성유",15000,7500),5.8,EST,None,F2S),
 row("GV80","JX",2020,None,"스마트스트림 G3.5 T-GDI","가솔린",3470,"기본",("0W-30","SP","GF-6","합성유",15000,7500),6.7,EST,None,F2S),
 row("GV80","JX",2020,2023,"D3.0 디젤","디젤",2996,"기본",D_SS,7.0,EST,"필터 품번 확인 필요",[]),
]

# ══════════════ 벤츠 ══════════════
MB = [
 row("C클래스","W205",2014,2021,"M274 2.0 터보 (C200)","가솔린",1991,"기본",MB_G,6.0,EST,None,[("MANN-FILTER","HU 6008 z",0)]),
 row("C클래스","W205",2014,2021,"OM651 2.2 디젤 (C220d)","디젤",2143,"기본",MB_D,6.5,EST,None,[("MANN-FILTER","HU 7010 z",0)]),
 row("C클래스","W206",2021,None,"M254 1.5 터보 MHEV (C200)","가솔린",1496,"기본",MB_G20,5.5,EST,None,[]),
 row("E클래스","W212",2009,2016,"M274 2.0 터보 (E200)","가솔린",1991,"기본",MB_G,6.0,EST,None,[("MANN-FILTER","HU 6008 z",0)]),
 row("E클래스","W212",2009,2016,"OM651 2.2 디젤 (E220 CDI)","디젤",2143,"기본",MB_D,6.5,EST,None,[("MANN-FILTER","HU 7010 z",0)]),
 row("E클래스","W213",2016,2023,"M264 2.0 터보 (E250/E300)","가솔린",1991,"기본",MB_G,6.0,EST,None,[]),
 row("E클래스","W213",2016,2023,"OM654 2.0 디젤 (E220d)","디젤",1950,"기본",MB_D,6.6,EST,None,[]),
 row("E클래스","W214",2023,None,"M254 2.0 터보 MHEV (E300)","가솔린",1999,"기본",MB_G20,6.0,EST,None,[]),
 row("S클래스","W222",2013,2020,"M276 3.0/3.5 (S350/S400)","가솔린",2996,"기본",MB_G,7.5,EST,None,[]),
 row("S클래스","W223",2020,None,"M256 3.0 터보 MHEV (S450/S500)","가솔린",2999,"기본",MB_G20,7.0,EST,None,[]),
 row("S클래스","W223",2020,None,"OM656 3.0 디젤 (S400d)","디젤",2925,"기본",MB_D,8.0,EST,None,[]),
 row("GLC","X253",2015,2022,"M264 2.0 터보 (GLC300)","가솔린",1991,"기본",MB_G,6.0,EST,None,[]),
 row("GLC","X253",2015,2022,"OM654 2.0 디젤 (GLC220d)","디젤",1950,"기본",MB_D,6.6,EST,None,[]),
 row("GLE","W167",2019,None,"OM656 3.0 디젤 (GLE400d)","디젤",2925,"기본",MB_D,8.0,EST,None,[]),
]

# ══════════════ BMW ══════════════
BMW = [
 row("3시리즈","F30",2012,2019,"N20 2.0 터보 (320i/328i)","가솔린",1997,"기본",BMW_G,5.0,EST,None,[("MANN-FILTER","HU 6014 z",0)]),
 row("3시리즈","F30",2012,2019,"N47/B47 2.0 디젤 (320d)","디젤",1995,"기본",BMW_D,5.2,EST,None,[("MANN-FILTER","HU 6004 x",0)]),
 row("3시리즈","G20",2019,None,"B48 2.0 터보 (330i)","가솔린",1998,"기본",BMW_G2,5.3,EST,None,[("MANN-FILTER","HU 6014/1 z",0)]),
 row("3시리즈","G20",2019,2024,"B47 2.0 디젤 (320d)","디젤",1995,"기본",BMW_D,5.2,EST,None,[("MANN-FILTER","HU 6004 x",0)]),
 row("5시리즈","F10",2010,2017,"N20 2.0 터보 (528i)","가솔린",1997,"기본",BMW_G,5.0,EST,None,[("MANN-FILTER","HU 6014 z",0)]),
 row("5시리즈","F10",2010,2017,"N47 2.0 디젤 (520d)","디젤",1995,"기본",BMW_D,5.2,EST,None,[("MANN-FILTER","HU 6004 x",0)]),
 row("5시리즈","G30",2017,2023,"B48 2.0 터보 (530i)","가솔린",1998,"기본",BMW_G2,5.3,EST,None,[("MANN-FILTER","HU 6014/1 z",0)]),
 row("5시리즈","G30",2017,2023,"B47 2.0 디젤 (520d)","디젤",1995,"기본",BMW_D,5.2,EST,None,[("MANN-FILTER","HU 6004 x",0)]),
 row("5시리즈","G60",2023,None,"B48 2.0 터보 MHEV (520i)","가솔린",1998,"기본",BMW_G2,5.3,EST,None,[("MANN-FILTER","HU 6014/1 z",0)]),
 row("7시리즈","G11",2015,2022,"B58 3.0 터보 (740i)","가솔린",2998,"기본",BMW_G,6.5,EST,"필터 품번 확인 필요",[]),
 row("X3","G01",2017,None,"B48 2.0 터보 (X3 20i/30i)","가솔린",1998,"기본",BMW_G2,5.3,EST,None,[("MANN-FILTER","HU 6014/1 z",0)]),
 row("X3","G01",2017,None,"B47 2.0 디젤 (X3 20d)","디젤",1995,"기본",BMW_D,5.2,EST,None,[("MANN-FILTER","HU 6004 x",0)]),
 row("X5","G05",2018,None,"B58 3.0 터보 (X5 40i)","가솔린",2998,"기본",BMW_G,6.5,EST,"필터 품번 확인 필요",[]),
]

# ══════════════ 아우디 ══════════════
AUDI = [
 row("A4","B8",2008,2016,"EA888 2.0 TFSI","가솔린",1984,"기본",VW_G,4.6,EST,None,[("MANN-FILTER","HU 6013 z",0)]),
 row("A4","B9",2016,None,"EA888 Gen3 2.0 TFSI (40 TFSI)","가솔린",1984,"기본",VW_G,5.0,EST,None,[("MANN-FILTER","HU 6013 z",0)]),
 row("A6","C7",2011,2018,"EA888 2.0 TFSI","가솔린",1984,"기본",VW_G,4.7,EST,None,[("MANN-FILTER","HU 6013 z",0)]),
 row("A6","C7",2011,2018,"EA897 3.0 TDI","디젤",2967,"기본",VW_D,7.0,EST,"필터 품번 확인 필요",[]),
 row("A6","C8",2018,None,"EA888 Gen3 2.0 TFSI (45 TFSI)","가솔린",1984,"기본",VW_G,5.0,EST,None,[("MANN-FILTER","HU 6013 z",0)]),
 row("Q5","FY",2017,None,"EA888 Gen3 2.0 TFSI (45 TFSI)","가솔린",1984,"기본",VW_G,5.0,EST,None,[("MANN-FILTER","HU 6013 z",0)]),
 row("Q7","4M",2015,None,"EA897 3.0 TDI (45 TDI)","디젤",2967,"기본",VW_D,7.5,EST,"필터 품번 확인 필요",[]),
 row("A3","8V",2013,2020,"EA211 1.4 TFSI","가솔린",1395,"기본",VW_G,4.0,EST,"필터 품번 확인 필요",[]),
]

# ══════════════ 렉서스 ══════════════
LEX = [
 row("ES","XV60",2012,2018,"2AR-FSE 2.5 HEV (ES300h)","하이브리드",2494,"기본",LEX_H,4.4,EST,None,[("토요타(OE)","04152-YZZA1",0)]),
 row("ES","XV70",2018,None,"A25A-FXS 2.5 HEV (ES300h)","하이브리드",2487,"기본",("0W-16","SN 이상","GF-5 이상","저점도 합성유 (0W-20 대체 가능)",15000,7500),4.5,EST,None,[("토요타(OE)","04152-YZZA1",0)]),
 row("NX","AZ20",2021,None,"A25A-FXS 2.5 HEV (NX350h)","하이브리드",2487,"기본",LEX_H,4.5,EST,None,[("토요타(OE)","04152-YZZA1",0)]),
 row("RX","AL20",2015,2022,"2GR-FKS 3.5 (RX350)","가솔린",3456,"기본",LEX_G,5.8,EST,None,[("토요타(OE)","04152-YZZA1",0)]),
 row("RX","AL30",2022,None,"A25A-FXS 2.5 HEV (RX350h)","하이브리드",2487,"기본",LEX_H,4.5,EST,None,[("토요타(OE)","04152-YZZA1",0)]),
 row("UX","MZAA10",2019,None,"M20A-FXS 2.0 HEV (UX250h)","하이브리드",1987,"기본",LEX_H,4.2,EST,"필터 품번 확인 필요",[]),
]

# ══════════════ KGM (구 쌍용) ══════════════
KGM = [
 row("티볼리","X100",2015,None,"e-XGi160 1.6 가솔린","가솔린",1597,"기본",KGM_G,4.0,EST,"필터 품번 확인 필요",[]),
 row("티볼리","X100",2019,None,"1.5 T-GDI","가솔린",1497,"기본",KGM_G,4.5,EST,"필터 품번 확인 필요",[]),
 row("코란도","C300",2019,None,"1.5 T-GDI","가솔린",1497,"기본",KGM_G,4.5,EST,"필터 품번 확인 필요",[]),
 row("코란도","C300",2019,None,"e-XDi160 1.6 디젤","디젤",1597,"기본",KGM_D,5.5,EST,"필터 품번 확인 필요",[]),
 row("렉스턴","G4/Y400",2017,None,"e-XDi220 2.2 디젤","디젤",2157,"기본",KGM_D,6.5,EST,"필터 품번 확인 필요",[]),
 row("토레스","J100",2022,None,"1.5 T-GDI","가솔린",1497,"기본",KGM_G,4.5,EST,"필터 품번 확인 필요",[]),
]

# ══════════════ 르노코리아 ══════════════
RSM = [
 row("SM6","LFD",2016,None,"2.0 GDe","가솔린",1998,"기본",RSM_G,4.5,EST,"필터 품번 확인 필요",[]),
 row("SM6","LFD",2016,None,"1.3 TCe","가솔린",1332,"기본",RSM_G,4.8,EST,"벤츠 공동개발 M282 엔진",[]),
 row("QM6","HZG",2016,None,"2.0 GDe","가솔린",1998,"기본",RSM_G,4.5,EST,"필터 품번 확인 필요",[]),
 row("QM6","HZG",2016,None,"2.0 LPe","LPG",1998,"기본",RSM_G,4.5,EST,None,[]),
 row("XM3(아르카나)","JL1",2020,None,"1.3 TCe","가솔린",1332,"기본",RSM_G,4.8,EST,"벤츠 공동개발 M282 엔진",[]),
 row("XM3(아르카나)","JL1",2020,None,"1.6 GTe","가솔린",1598,"기본",RSM_G,4.2,EST,None,[]),
 row("그랑 콜레오스","HC",2024,None,"1.5 터보 HEV","하이브리드",1499,"기본",RSM_G,4.5,EST,"필터 품번 확인 필요",[]),
]

# ══════════════ 한국GM (쉐보레) ══════════════
GMK = [
 row("스파크","M300/M400",2011,2022,"S-TEC 1.0","가솔린",995,"기본",GM_G,3.5,EST,"필터 품번 확인 필요",[]),
 row("크루즈","J300",2011,2018,"1.8 가솔린","가솔린",1796,"기본",GM_G,4.5,EST,"필터 품번 확인 필요",[]),
 row("말리부","9세대",2016,2022,"1.5 터보","가솔린",1490,"기본",GM_G,4.7,EST,None,[("ACDelco","PF66",0)]),
 row("말리부","9세대",2016,2022,"LTG 2.0 터보","가솔린",1998,"기본",GM_G,4.7,EST,None,[("ACDelco","PF64",0)]),
 row("트랙스","TU",2013,2022,"1.4 터보","가솔린",1362,"기본",GM_G,4.0,EST,"필터 품번 확인 필요",[]),
 row("트레일블레이저","9BUC",2020,None,"E3LB 1.35 터보","가솔린",1341,"기본",GM_G,4.2,EST,"필터 품번 확인 필요",[]),
 row("트랙스 크로스오버","9BYC",2023,None,"E3LB 1.2 터보","가솔린",1199,"기본",GM_G,4.2,EST,"필터 품번 확인 필요",[]),
]

BRANDS = [("현대",HY),("기아",KIA),("제네시스",GEN),("벤츠",MB),("BMW",BMW),
          ("아우디",AUDI),("렉서스",LEX),("KGM",KGM),("르노코리아",RSM),("한국GM",GMK)]

def main():
    conn = sqlite3.connect(DB)
    cur = conn.cursor()
    # 차량/스펙/필터 초기화 (스키마 유지, product_cache는 배치가 관리)
    cur.executescript("""
        DELETE FROM oil_filters; DELETE FROM engine_oil_specs;
        DELETE FROM vehicle_aliases; DELETE FROM vehicles; DELETE FROM manufacturers;
    """)
    try:
        cur.execute("ALTER TABLE oil_filters ADD COLUMN verified INTEGER DEFAULT 0")
    except sqlite3.OperationalError:
        pass  # 이미 존재

    for mfr, rows in BRANDS:
        cur.execute("INSERT INTO manufacturers (name) VALUES (?)", (mfr,))
        mid = cur.lastrowid
        for r in rows:
            (model, gen, ys, ye, eng, fuel, cc, trim,
             v, api, il, ot, cap, itv, sev, src, note, filters) = r
            cur.execute("""INSERT INTO vehicles
                (manufacturer_id, model_name, generation, year_start, year_end,
                 engine_code, fuel_type, displacement_cc, trim_note)
                VALUES (?,?,?,?,?,?,?,?,?)""",
                (mid, model, gen, ys, ye, eng, fuel, cc, trim))
            vid = cur.lastrowid
            cur.execute("""INSERT INTO engine_oil_specs
                (vehicle_id, viscosity, api_grade, ilsac_grade, oil_type, capacity_liters,
                 change_interval_km, change_interval_month, severe_interval_km, source, notes)
                VALUES (?,?,?,?,?,?,?,?,?,?,?)""",
                (vid, v, api, il, ot, cap, itv, 12, sev, src, note))
            for brand, pn, ver in filters:
                oe = pn if ("OE" in brand or "모비스" in brand or "토요타" in brand) else None
                if brand == "Bosch" and pn == "O 0367": oe = "26350-2S000"
                cur.execute("""INSERT INTO oil_filters
                    (vehicle_id, brand, part_number, oe_part_number, filter_type, verified)
                    VALUES (?,?,?,?,?,?)""", (vid, brand, pn, oe, "오일필터", ver))
    conn.commit()

    # 통계
    print(f"{'브랜드':<8} {'차량':>4} {'verified스펙':>10} {'필터':>4}")
    for mfr, _ in BRANDS:
        cur.execute("""SELECT count(DISTINCT v.id),
            sum(CASE WHEN s.source LIKE '%verified%' THEN 1 ELSE 0 END),
            count(f.id)
            FROM vehicles v JOIN manufacturers m ON m.id=v.manufacturer_id
            LEFT JOIN engine_oil_specs s ON s.vehicle_id=v.id
            LEFT JOIN oil_filters f ON f.vehicle_id=v.id
            WHERE m.name=?""", (mfr,))
        n, ver, nf = cur.fetchone()
        print(f"{mfr:<8} {n:>4} {ver or 0:>10} {nf:>4}")
    cur.execute("SELECT count(*) FROM vehicles"); print("총 차량:", cur.fetchone()[0])
    conn.close()

if __name__ == "__main__":
    main()
