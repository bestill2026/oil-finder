-- ============================================================
-- 검증 업데이트 v11 (라운드⑥): MANN 공식 카탈로그 대조 — 아우디·벤츠 GLE (2026-08-10)
-- 근거: 만필터 공식몰(mfilter.kr), 카자몰 CUK 31003 적용차종, 다나와 CUK 26009
-- ============================================================

-- 아우디 B9: 만필터 공식 CUK 31003 (A4~Q8 MLB Evo 공용)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, 'MANN-FILTER', 'CUK 31003', NULL, 1 FROM vehicles WHERE generation='B9';
-- 아우디 B9: OE 8W0819439 승격 (만필터 호환 확인으로 뒷받침)
UPDATE parts SET verified=1 WHERE part_type='에어컨필터' AND part_number='8W0819439' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='B9');
-- 아우디 FY: 만필터 공식 CUK 31003 (A4~Q8 MLB Evo 공용)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, 'MANN-FILTER', 'CUK 31003', NULL, 1 FROM vehicles WHERE generation='FY';
-- 아우디 FY: OE 8W0819439 승격 (만필터 호환 확인으로 뒷받침)
UPDATE parts SET verified=1 WHERE part_type='에어컨필터' AND part_number='8W0819439' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='FY');
-- 아우디 C8: 만필터 공식 CUK 31003 (A4~Q8 MLB Evo 공용)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, 'MANN-FILTER', 'CUK 31003', NULL, 1 FROM vehicles WHERE generation='C8';
-- 아우디 C8: OE 8W0819439 승격 (만필터 호환 확인으로 뒷받침)
UPDATE parts SET verified=1 WHERE part_type='에어컨필터' AND part_number='8W0819439' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='C8');
-- 아우디 4M: 만필터 공식 CUK 31003 (A4~Q8 MLB Evo 공용)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, 'MANN-FILTER', 'CUK 31003', NULL, 1 FROM vehicles WHERE generation='4M';
-- 아우디 4M: OE 8W0819439 승격 (만필터 호환 확인으로 뒷받침)
UPDATE parts SET verified=1 WHERE part_type='에어컨필터' AND part_number='8W0819439' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='4M');
-- 아우디 A4 B8(07~15): 만필터 공식 CUK 2450 (A5·Q5 8R 공용)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
    SELECT id, '에어컨필터', NULL, 'MANN-FILTER', 'CUK 2450', NULL, 1
    FROM vehicles WHERE generation='B8';
-- 아우디 A3 8V: 다나와 CUK 26009 (골프7 공용)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
    SELECT id, '에어컨필터', NULL, 'MANN-FILTER', 'CUK 26009', NULL, 1
    FROM vehicles WHERE generation='8V';
-- 벤츠 GLE W167: 만필터 공식 CUK 26032 (GLS X167 공용)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
    SELECT id, '에어컨필터', NULL, 'MANN (내부)', 'CUK 26032', NULL, 1
    FROM vehicles WHERE generation='W167';
-- 벤츠 GLE W167: 만필터 공식 CU 19014 (외기)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
    SELECT id, '에어컨필터', NULL, 'MANN (외부)', 'CU 19014', NULL, 1
    FROM vehicles WHERE generation='W167';
-- 미확보 유지: 아우디 A6 C7(구형 MLB 별도 품번), 벤츠 W214, BMW G60
