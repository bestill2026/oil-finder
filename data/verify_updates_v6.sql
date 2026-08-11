-- ============================================================
-- 검증 업데이트 v6 (라운드①): 수입차 와이퍼 사이즈 (2026-08-10 웹 검증)
-- 근거: 필터테크(W213), 블레이드신(G20), 미쉐린와이퍼 장착후기(G30), 11번가 GOS(렉서스 ES)
-- ============================================================

-- 벤츠 E W213: 600/550 확인 (기존 추정 650/500 교정)
UPDATE parts SET part_number='600mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='W213');
UPDATE parts SET part_number='550mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='W213');
-- BMW 3 G20: 600/450 확인 (기존 650/450 교정)
UPDATE parts SET part_number='600mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='G20');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='G20');
-- BMW 5 G30: 650/450 확인 (기존 650/500 교정)
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='G30');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='G30');
-- 렉서스 ES XV60: 650/450 확인 (추정 일치 → 승격)
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='XV60');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='XV60');
-- 렉서스 ES XV70: 650/450 확인 (13~20년형 공용)
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='XV70');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='XV70');
-- F30(600/450)은 E90·G20 앞뒤 세대 동일 사이즈로 간접 뒷받침되나 직접 근거 없어 추정 유지
