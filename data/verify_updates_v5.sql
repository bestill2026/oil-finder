-- ============================================================
-- 검증 업데이트 v5: 에어컨필터 잔여 세대 수집 완결 (2026-08-10 웹 검증)
-- 근거: 현대모비스 공식몰(헬로우카·현기스토어·파츠로·현기몰), 카다몰
-- ============================================================

-- 투싼ix: 헬로우카 2E210 (i40·스포티지SL·프라이드UB 공용)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-2E210', '97133-2E210', 1
        FROM vehicles WHERE generation='ix(LM)';
-- 스포티지SL: 동일
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-2E210', '97133-2E210', 1
        FROM vehicles WHERE generation='SL';
-- 쏘렌토UM(올뉴·더뉴): 카다몰 C5000
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-C5000', '97133-C5000', 1
        FROM vehicles WHERE generation='UM';
-- TL: 현기몰 D3000(일반) — 기존 D1000 교체
UPDATE parts SET part_number='97133-D3000', oe_part_number='97133-D3000', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='TL');
-- TL: D3100(활성탄) 추가
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE) 활성탄', '97133-D3100', '97133-D3100', 1
        FROM vehicles WHERE generation='TL';
-- QL: 현기몰 D3000(일반) — 기존 D1000 교체
UPDATE parts SET part_number='97133-D3000', oe_part_number='97133-D3000', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='QL');
-- QL: D3100(활성탄) 추가
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE) 활성탄', '97133-D3100', '97133-D3100', 1
        FROM vehicles WHERE generation='QL';
-- 스포티지NQ5: 파츠로 N9000 (NX4·NQ5·SX2·니로·EV6 공용)
UPDATE parts SET part_number='97133-N9000', oe_part_number='97133-N9000', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='NQ5');
-- 코나SX2: 파츠로 N9000 (NX4·NQ5·SX2·니로·EV6 공용)
UPDATE parts SET part_number='97133-N9000', oe_part_number='97133-N9000', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='SX2');
-- 니로SG2: 파츠로 N9000 (NX4·NQ5·SX2·니로·EV6 공용)
UPDATE parts SET part_number='97133-N9000', oe_part_number='97133-N9000', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='SG2');
-- 투싼NX4: N9000 활성탄 추가 (L1100 일반형과 병기)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE) 활성탄', '97133-N9000', '97133-N9000', 1
        FROM vehicles WHERE generation='NX4';
-- 캐스퍼: 헬로우카 [수동에어컨] O6000
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE) 수동에어컨', '97133-O6000', '97133-O6000', 1
        FROM vehicles WHERE generation='AX1';
-- 캐스퍼: [자동에어컨] O6200
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE) 자동에어컨', '97133-O6200', '97133-O6200', 1
        FROM vehicles WHERE generation='AX1';
-- 니로DE: 헬로우카 G2000 (아이오닉 공용)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-G2000', '97133-G2000', 1
        FROM vehicles WHERE generation='DE';
-- 모하비 더마스터(2019.8~): 헬로우카 S8100 — 2019.6 이전은 2F010
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-S8100', '97133-S8100', 1
        FROM vehicles WHERE generation='HM2';
-- 모닝JA: 레이·TA 공용 추정 (구체 확인 필요)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-07010', '97133-07010', 0
        FROM vehicles WHERE generation='JA';

-- ── 버그 수정: 싼타페 TM (v3 삭제 행에 v4 UPDATE가 no-op → INSERT로 보강) ──
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-G8000', '97133-G8000', 1
FROM vehicles WHERE generation='TM' AND year_start < 2020;
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-L1000', '97133-L1000', 1
FROM vehicles WHERE generation='TM' AND year_start >= 2020;
