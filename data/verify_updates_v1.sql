-- ============================================================
-- 검증 업데이트 v1: 벤츠 · BMW (2026-07-12 웹 검증)
-- 근거: MANN 공식 카탈로그, 국내 수입부품몰, 해외 부품몰 크로스레퍼런스
-- ============================================================

-- ── BMW 디젤 (N47/B47) : MANN HU 6004 x = OE 11428507683 [확인됨] ──
UPDATE oil_filters SET verified=1, oe_part_number='11428507683'
WHERE part_number='HU 6004 x';

-- F10 520d N47: 용량 5.2L 확인 (국내 부품몰 정비 안내)
UPDATE engine_oil_specs SET source='부품몰 정비안내(verified)'
WHERE vehicle_id IN (SELECT id FROM vehicles WHERE generation='F10' AND engine_code LIKE '%N47%');

-- G바디 B47은 용량이 N47과 다름 → 주의 노트
UPDATE engine_oil_specs SET capacity_liters=5.5,
    notes='B47 용량은 N47(5.2L)과 다름, 재검증 권장'
WHERE vehicle_id IN (SELECT id FROM vehicles WHERE engine_code LIKE 'B47%');

-- ── BMW 가솔린 4기통 (B46/B48) : MANN HU 6014/1 z = OE 11428575211 [확인됨] ──
-- 적용: 330i/530i/X3 30i/740e 등 G바디 전반
UPDATE oil_filters SET verified=1, oe_part_number='11428575211'
WHERE part_number='HU 6014/1 z';

-- ── BMW 가솔린 6기통 (B58) : OE 11428583898 (2018년 이후) [부품몰 확인] ──
-- 740i G11, X5 G05 40i — 기존 '필터 없음' 행 보강
INSERT INTO oil_filters (vehicle_id, brand, part_number, oe_part_number, filter_type, verified)
SELECT id, 'BMW(OE)', '11428583898', '11428583898', '오일필터', 0
FROM vehicles WHERE engine_code LIKE 'B58%';
UPDATE engine_oil_specs SET notes='2016~18년식 초기 B58은 OE 11427826799 사용'
WHERE vehicle_id IN (SELECT id FROM vehicles WHERE engine_code LIKE 'B58%');

-- ── 벤츠 디젤 OM651 : MANN HU 7010 z [국내 필터몰 적용 확인] ──
UPDATE oil_filters SET verified=1
WHERE part_number='HU 7010 z';

-- ── 벤츠 가솔린 M270/M274 : OE A2701800109 [크로스레퍼런스 확인] ──
-- (기존 추정치 MANN HU 6008 z → 확인된 순정 품번으로 교체)
UPDATE oil_filters SET brand='벤츠(OE)', part_number='A2701800109',
    oe_part_number='A2701800109', verified=1
WHERE part_number='HU 6008 z';

-- W213 E클래스 가솔린: E200은 M274(274.920) 사용 확인 → 엔진 표기 보정 + 필터 추가
UPDATE vehicles SET engine_code='M274/M264 2.0 터보 (E200/E300)'
WHERE generation='W213' AND fuel_type='가솔린';
INSERT INTO oil_filters (vehicle_id, brand, part_number, oe_part_number, filter_type, verified)
SELECT id, '벤츠(OE)', 'A2701800109', 'A2701800109', '오일필터', 1
FROM vehicles WHERE generation='W213' AND fuel_type='가솔린';

-- M264 단독 차량(GLC300)도 동일 계열 필터 (추정 유지)
INSERT INTO oil_filters (vehicle_id, brand, part_number, oe_part_number, filter_type, verified)
SELECT id, '벤츠(OE)', 'A2701800109', 'A2701800109', '오일필터', 0
FROM vehicles WHERE generation='X253' AND fuel_type='가솔린';
