-- ============================================================
-- 검증 업데이트 v4: 에어컨필터 품번 수집 라운드 (2026-08-10 웹 검증)
-- 근거: 현대모비스 공식몰(파츠로·헬로우카·현기스토어), 다나와 순정품 적용차종,
--       티스도리 정비 블로그(F2200 적용군), 블루본 규격 호환표
-- ============================================================

-- 코나 OS: D1000→F2100 교정 (티스도리: 2017.3+ 코나 F계열)
UPDATE parts SET part_number='97133-F2100', oe_part_number='97133-F2100', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='OS');
-- 코나 OS: 활성탄 옵션
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE) 활성탄', '97133-F2200', '97133-F2200', 1
        FROM vehicles WHERE generation='OS';
-- 벨로스터 JS: D1000→F2200 교정 (티스도리 명시)
UPDATE parts SET part_number='97133-F2200', oe_part_number='97133-F2200', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='JS');
-- K3 BD: 파츠로 F2200군 (올뉴K3 2018-2021, K3 21)
UPDATE parts SET part_number='97133-F2100', oe_part_number='97133-F2100', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='BD');
-- 아반떼 AD: 현기스토어 F2100 (일반형)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-F2100', '97133-F2100', 1
        FROM vehicles WHERE generation='AD';
-- 아반떼 AD: 활성탄 옵션
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE) 활성탄', '97133-F2200', '97133-F2200', 1
        FROM vehicles WHERE generation='AD';
-- K3 YD: 더뉴(15-18)만 F계열 확인, 초기형(12-15) 미확정
UPDATE parts SET part_number='97133-F2100', oe_part_number='97133-F2100', verified=0
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='YD');
-- LF쏘나타: 오토파트 C1000 (IG·LF·K5HEV·K7 공용)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-C1000', '97133-C1000', 1
        FROM vehicles WHERE generation='LF';
-- LF쏘나타: 활성탄
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE) 활성탄', '97133-G8000', '97133-G8000', 1
        FROM vehicles WHERE generation='LF';
-- K5 JF: C1000 공용군 (K5 HEV JFE 명시)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-C1000', '97133-C1000', 1
        FROM vehicles WHERE generation='JF';
-- 그랜저 IG: 오토파트 C1000
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-C1000', '97133-C1000', 1
        FROM vehicles WHERE generation='IG';
-- 더뉴 그랜저IG: 파츠로 G8AA0 (2019.11+)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-G8AA0', '97133-G8AA0', 1
        FROM vehicles WHERE generation='IG FL';
-- K7 YG: 다나와 G8000 적용차종 (K7)
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-G8000', '97133-G8000', 1
        FROM vehicles WHERE generation='YG';
-- 싼타페 TM 전기형(2018~): 다나와 G8000 적용차종
UPDATE parts SET part_number='97133-G8000', oe_part_number='97133-G8000', verified=1
    WHERE part_type='에어컨필터' AND vehicle_id IN
    (SELECT id FROM vehicles WHERE generation='TM' AND year_start < 2020);
-- 더뉴 싼타페 TM(2020~): 파츠로 L1000
UPDATE parts SET part_number='97133-L1000', oe_part_number='97133-L1000', verified=1
    WHERE part_type='에어컨필터' AND vehicle_id IN
    (SELECT id FROM vehicles WHERE generation='TM' AND year_start >= 2020);
-- 투싼 NX4: 파츠로 L1000 계열 확인 → 승격
UPDATE parts SET verified=1
    WHERE part_type='에어컨필터' AND part_number='97133-L1100'
    AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='NX4');
-- 카니발 KA4: 헬로우카 R0100/R0500
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-R0100', '97133-R0100', 1
        FROM vehicles WHERE generation='KA4';
-- 팰리세이드: 다나와 순정 S8100
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-S8100', '97133-S8100', 1
        FROM vehicles WHERE generation='LX2';
-- GN7: 헤파 11호 호환군(L계열) + 블루본 규격 일치 → 추정
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-L1100', '97133-L1100', 0
        FROM vehicles WHERE generation='GN7';
-- 스타리아: 헤파 11호 호환군 → 추정
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-L1100', '97133-L1100', 0
        FROM vehicles WHERE generation='US4';
-- YF쏘나타: 블루본 규격 HG와 동일군 → 추정
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-3SAA0', '97133-3SAA0', 0
        FROM vehicles WHERE generation='YF';
-- 아반떼 MD: i30 GD 공용 추정
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-2H001', '97133-2H001', 0
        FROM vehicles WHERE generation='MD';
-- G70: 스팅어 플랫폼 공유 + 헤파 12호 동일군 → 추정
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-J5000', '97133-J5000', 0
        FROM vehicles WHERE generation='IK';
-- G70 FL: 동일
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-J5000', '97133-J5000', 0
        FROM vehicles WHERE generation='IK FL';
-- K9: 헤파 12호 동일군 → 추정
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-J5000', '97133-J5000', 0
        FROM vehicles WHERE generation='RJ';
-- GV70: G80 RG3 플랫폼 공유 → T6500 추정
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-T6500', '97133-T6500', 0
        FROM vehicles WHERE generation='JK';
-- GV80: G80 RG3 플랫폼 공유 → T6500 추정
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-T6500', '97133-T6500', 0
        FROM vehicles WHERE generation='JX';
-- G90 RS4: G80 RG3 플랫폼 공유 → T6500 추정
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
        SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-T6500', '97133-T6500', 0
        FROM vehicles WHERE generation='RS4';
-- 베뉴·투싼TL: 해외 크로스 단독 근거 → 추정으로 하향 (QL·스토닉만 국내몰 확인 유지)
UPDATE parts SET verified=0 WHERE part_type='에어컨필터' AND part_number='97133-D1000'
    AND vehicle_id IN (SELECT id FROM vehicles WHERE generation IN ('QX','TL'));
