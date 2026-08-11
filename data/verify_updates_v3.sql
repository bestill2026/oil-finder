-- ============================================================
-- 검증 업데이트 v3: 에어컨필터 · 와이퍼 (2026-08-10 웹 검증)
-- 근거: 다나와 국산 차종별 와이퍼 사이즈표(2021.03, DPG), 다나와 부품 가격비교,
--       현대모비스 부품몰(헬로우카·파츠로), 해외 크로스레퍼런스
-- ============================================================

-- CN7: 다나와 97133-L1100 적용차종 확인
UPDATE parts SET part_number='97133-L1100', oe_part_number='97133-L1100', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='CN7');
-- DN8: 다나와 97133-L1100 적용차종 확인
UPDATE parts SET part_number='97133-L1100', oe_part_number='97133-L1100', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='DN8');
-- DL3: 다나와 97133-L1100 적용차종 확인
UPDATE parts SET part_number='97133-L1100', oe_part_number='97133-L1100', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='DL3');
-- MQ4: 다나와 97133-L1100 적용차종 확인
UPDATE parts SET part_number='97133-L1100', oe_part_number='97133-L1100', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='MQ4');
-- NX4: 3세대 플랫폼 공용 추정(L1100)
UPDATE parts SET part_number='97133-L1100', oe_part_number='97133-L1100', verified=0
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='NX4');
-- NQ5: 3세대 플랫폼 공용 추정(L1100)
UPDATE parts SET part_number='97133-L1100', oe_part_number='97133-L1100', verified=0
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='NQ5');
-- GL3: 3세대 플랫폼 공용 추정(L1100)
UPDATE parts SET part_number='97133-L1100', oe_part_number='97133-L1100', verified=0
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='GL3');
-- SX2: 3세대 플랫폼 공용 추정(L1100)
UPDATE parts SET part_number='97133-L1100', oe_part_number='97133-L1100', verified=0
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='SX2');
-- MX5: 3세대 플랫폼 공용 추정(L1100)
UPDATE parts SET part_number='97133-L1100', oe_part_number='97133-L1100', verified=0
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='MX5');
-- SG2: 3세대 플랫폼 공용 추정(L1100)
UPDATE parts SET part_number='97133-L1100', oe_part_number='97133-L1100', verified=0
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='SG2');
-- QL: D1000 적용 확인
UPDATE parts SET verified=1
        WHERE part_type='에어컨필터' AND part_number='97133-D1000'
        AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='QL');
-- TL: D1000 적용 확인
UPDATE parts SET verified=1
        WHERE part_type='에어컨필터' AND part_number='97133-D1000'
        AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='TL');
-- OS: D1000 적용 확인
UPDATE parts SET verified=1
        WHERE part_type='에어컨필터' AND part_number='97133-D1000'
        AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='OS');
-- QX: D1000 적용 확인
UPDATE parts SET verified=1
        WHERE part_type='에어컨필터' AND part_number='97133-D1000'
        AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='QX');
-- JS: D1000 적용 확인
UPDATE parts SET verified=1
        WHERE part_type='에어컨필터' AND part_number='97133-D1000'
        AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='JS');
-- 셀토스: 크레타 공용 추정 유지(D1000, est)
UPDATE parts SET verified=0 WHERE part_type='에어컨필터' AND part_number='97133-D1000'
    AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='SP2');
-- 그랜저HG: 다나와 3SAA0
UPDATE parts SET part_number='97133-3SAA0', oe_part_number='97133-3SAA0', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='HG');
-- 싼타페DM: 다나와 3SAA0
UPDATE parts SET part_number='97133-3SAA0', oe_part_number='97133-3SAA0', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='DM');
-- K5 TF: 다나와 3SAA0
UPDATE parts SET part_number='97133-3SAA0', oe_part_number='97133-3SAA0', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='TF');
-- K7 VG: 다나와 3SAA0
UPDATE parts SET part_number='97133-3SAA0', oe_part_number='97133-3SAA0', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='VG');
-- 카니발YP: 헬로우카 A9000
UPDATE parts SET part_number='97133-A9000', oe_part_number='97133-A9000', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='YP');
-- 쏘렌토XM: 헬로우카 2F010
UPDATE parts SET part_number='97133-2F010', oe_part_number='97133-2F010', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='XM');
-- 스팅어: 부품몰 J5000
UPDATE parts SET part_number='97133-J5000', oe_part_number='97133-J5000', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='CK');
-- G80 RG3: 헬로우카 T6500
UPDATE parts SET part_number='97133-T6500', oe_part_number='97133-T6500', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='RG3');
-- 팰리세이드LX3: 헬로우카 AR000
UPDATE parts SET part_number='97133-AR000', oe_part_number='97133-AR000', verified=1
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='LX3');
-- K3 YD: i30 GD 공용 추정 2H001
UPDATE parts SET part_number='97133-2H001', oe_part_number='97133-2H001', verified=0
        WHERE part_type='에어컨필터' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='YD');
-- 모닝TA·레이: 07010 확인
INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
    SELECT id, '에어컨필터', NULL, '현대모비스(OE)', '97133-07010', '97133-07010', 1
    FROM vehicles WHERE generation IN ('TA','TAM');
-- 미확인 차종의 블랭킷 추정 삭제 (품번 수집 후 재등록 예정)
DELETE FROM parts WHERE part_type='에어컨필터'
    AND part_number IN ('97133-D1000','97133-2H000')
    AND vehicle_id IN (SELECT id FROM vehicles WHERE generation IN ('MD','AD','YF','LF','IG','IG FL','GN7','ix(LM)','TM','LX2','US4','JF','YG','RJ','UM','SL','KA4','HM2','DE','IK','IK FL','RS4','JK','JX','JA','AX1'));

-- ── 와이퍼 사이즈 교정/검증 (다나와 표) ──
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='MD');
UPDATE parts SET part_number='350mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='MD');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='AD');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='AD');
UPDATE parts SET part_number='600mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='CN7');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='CN7');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='YF');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='YF');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='LF');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='LF');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='DN8');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='DN8');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='HG');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='HG');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='IG');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='IG');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='IG FL');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='IG FL');
UPDATE parts SET part_number='600mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='ix(LM)');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='ix(LM)');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='TL');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='TL');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='NX4');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='NX4');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='DM');
UPDATE parts SET part_number='350mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='DM');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='TM');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='TM');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='LX2');
UPDATE parts SET part_number='500mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='LX2');
UPDATE parts SET part_number='650mm', verified=0 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='LX3');
UPDATE parts SET part_number='500mm', verified=0 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='LX3');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='OS');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='OS');
UPDATE parts SET part_number='600mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='QX');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='QX');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='JS');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='JS');
UPDATE parts SET part_number='550mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='TA');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='TA');
UPDATE parts SET part_number='600mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='JA');
UPDATE parts SET part_number='350mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='JA');
UPDATE parts SET part_number='550mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='TAM');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='TAM');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='YD');
UPDATE parts SET part_number='350mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='YD');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='BD');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='BD');
UPDATE parts SET part_number='600mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='TF');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='TF');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='JF');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='JF');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='DL3');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='DL3');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='VG');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='VG');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='YG');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='YG');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='RJ');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='RJ');
UPDATE parts SET part_number='600mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='SL');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='SL');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='QL');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='QL');
UPDATE parts SET part_number='600mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='XM');
UPDATE parts SET part_number='500mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='XM');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='UM');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='UM');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='MQ4');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='MQ4');
UPDATE parts SET part_number='600mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='SP2');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='SP2');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='DE');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='DE');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='YP');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='YP');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='KA4');
UPDATE parts SET part_number='500mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='KA4');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='CK');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='CK');
UPDATE parts SET part_number='600mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='HM2');
UPDATE parts SET part_number='500mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='HM2');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='IK');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='IK');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='IK FL');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='IK FL');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='RG3');
UPDATE parts SET part_number='400mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='RG3');
UPDATE parts SET part_number='650mm', verified=0 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='RS4');
UPDATE parts SET part_number='400mm', verified=0 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='RS4');
UPDATE parts SET part_number='650mm', verified=1 WHERE part_type='와이퍼' AND label='운전석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='JX');
UPDATE parts SET part_number='450mm', verified=1 WHERE part_type='와이퍼' AND label='조수석' AND vehicle_id IN (SELECT id FROM vehicles WHERE generation='JX');
-- 후방 와이퍼는 표에 미기재 → 300mm 추정 유지 (미검증)
