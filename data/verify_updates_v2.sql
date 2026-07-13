-- ============================================================
-- 검증 업데이트 v2: 아우디 · 렉서스 (2026-07-12 웹 검증)
-- ============================================================

-- ── 아우디 EA888 Gen3 (2016년 이후): OE 06L115562 [정품 필터 판매처 확인] ──
-- A4 B9 / A6 C8 / Q5 FY의 40/45 TFSI
UPDATE oil_filters SET brand='아우디(OE)', part_number='06L115562',
    oe_part_number='06L115562', verified=1
WHERE vehicle_id IN (SELECT id FROM vehicles WHERE generation IN ('B9','C8','FY'))
  AND part_number='HU 6013 z';

-- A6 C7 (2011~2018): 후기형 Gen3 기준 06L115562, 전기형 Gen2는 별도 품번 → 노트
UPDATE oil_filters SET brand='아우디(OE)', part_number='06L115562',
    oe_part_number='06L115562', verified=0
WHERE vehicle_id IN (SELECT id FROM vehicles WHERE generation='C7')
  AND part_number='HU 6013 z';
UPDATE engine_oil_specs SET notes='2015년 이전 Gen2 엔진은 필터 06J115403Q(MANN W 719/45) 사용'
WHERE vehicle_id IN (SELECT id FROM vehicles WHERE generation='C7'
  AND engine_code LIKE '%TFSI%');

-- A4 B8 (Gen1/2): 스핀온 타입 MANN W 719/45 = OE 06J115403Q (추정 유지, 품번만 교정)
UPDATE oil_filters SET brand='MANN-FILTER', part_number='W 719/45',
    oe_part_number='06J115403Q', verified=0
WHERE vehicle_id IN (SELECT id FROM vehicles WHERE generation='B8')
  AND part_number='HU 6013 z';

-- ── 렉서스: 토요타 04152-YZZA1 적용 범위 확인 ──
-- ES300h 2013~2024 / RX350 2007~2022 / IS350 등 [렉서스 정품몰 확인]
UPDATE oil_filters SET verified=1
WHERE part_number='04152-YZZA1'
  AND vehicle_id IN (SELECT id FROM vehicles WHERE generation IN ('XV60','XV70','AL20'));

-- ES 7세대(XV70) 0W-16 점도: 국내 부품몰 세트 구성으로 확인
UPDATE engine_oil_specs SET source='부품몰 세트구성(verified: 점도)'
WHERE vehicle_id IN (SELECT id FROM vehicles WHERE generation='XV70');

-- NX 0W-20 세트 판매 확인 (점도만 verified 수준)
UPDATE engine_oil_specs SET source='부품몰 세트구성(verified: 점도)'
WHERE vehicle_id IN (SELECT id FROM vehicles WHERE generation='AZ20');
