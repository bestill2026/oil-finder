-- ============================================================
-- 검증 업데이트 v7 (라운드②): 미수록 수입차 에어컨필터 (2026-08-10 웹 검증)
-- 근거: 오일비투비(국내몰), 이베이 BMW 정품, 만필터 공식몰, 나비엠알오, 해외 크로스레퍼런스
-- ============================================================

-- BMW G20: 오일비투비 CUK30007=OE 64119382886 (3·4시리즈·X3·X4·Z4 공용)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, 'BMW(OE)', '64119382886', '64119382886', 1 FROM vehicles WHERE generation='G20';
-- BMW G20: 만필터 호환 번호
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, 'MANN-FILTER', 'CUK 30007', NULL, 1 FROM vehicles WHERE generation='G20';
-- BMW G01: 오일비투비 CUK30007=OE 64119382886 (3·4시리즈·X3·X4·Z4 공용)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, 'BMW(OE)', '64119382886', '64119382886', 1 FROM vehicles WHERE generation='G01';
-- BMW G01: 만필터 호환 번호
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, 'MANN-FILTER', 'CUK 30007', NULL, 1 FROM vehicles WHERE generation='G01';
-- BMW G05: 정품 2매 세트 F90/G05/G07/G11/G12/G30 공용 확인
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, 'MANN-FILTER', 'CUK 23014-2', NULL, 1 FROM vehicles WHERE generation='G05';
-- BMW G11: 정품 2매 세트 F90/G05/G07/G11/G12/G30 공용 확인
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, 'MANN-FILTER', 'CUK 23014-2', NULL, 1 FROM vehicles WHERE generation='G11';
-- 벤츠 S W222: 나비엠알오 순정품번
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, '벤츠(OE)', 'A2228300318', 'A2228300318', 1 FROM vehicles WHERE generation='W222';
-- 벤츠 S W222(13~21): 만필터 공식
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, 'MANN-FILTER', 'CUK 27021-2', NULL, 1 FROM vehicles WHERE generation='W222';
-- 벤츠 S W223(21~): 만필터 공식 — 실외용 별도 존재하나 품번 미확보로 내부만 수록
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, 'MANN (내부)', 'CUK 25034-2', NULL, 1 FROM vehicles WHERE generation='W223';
-- 아우디 B9: MLB Evo 공용 8W0819439/4M0819439B (해외 크로스 다수 일치, 국내몰 미확인 → 추정)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, '아우디(OE)', '8W0819439', '8W0819439', 0 FROM vehicles WHERE generation='B9';
-- 아우디 FY: MLB Evo 공용 8W0819439/4M0819439B (해외 크로스 다수 일치, 국내몰 미확인 → 추정)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, '아우디(OE)', '8W0819439', '8W0819439', 0 FROM vehicles WHERE generation='FY';
-- 아우디 C8: MLB Evo 공용 8W0819439/4M0819439B (해외 크로스 다수 일치, 국내몰 미확인 → 추정)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, '아우디(OE)', '8W0819439', '8W0819439', 0 FROM vehicles WHERE generation='C8';
-- 아우디 4M: MLB Evo 공용 8W0819439/4M0819439B (해외 크로스 다수 일치, 국내몰 미확인 → 추정)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified) SELECT id, '에어컨필터', NULL, '아우디(OE)', '8W0819439', '8W0819439', 0 FROM vehicles WHERE generation='4M';
-- 미수록 유지: 벤츠 W214·GLE W167(실내외 품번 미확보), 아우디 A6 C7·A4 B8·A3 8V(구형 MLB 별도 품번), BMW G60
