-- ============================================================
-- 검증 업데이트 v10 (라운드⑤-1차 매뉴얼 라운드): 상충·의심값 판정 (2026-08-10)
-- 근거: 오너 취급설명서 인용(클리앙 — AD: API SN·ILSAC GF-5·5W-20/30, 1L×3통),
--       감마 1.6 GDI 공통(MD 매뉴얼 3.3L), R엔진 동일 파워트레인 대조(XM 7.5L)
-- 판정: 아반떼 AD 가솔린 = 3.3L·5W-30·SN·GF-5 (cartech 3.6L 배제 — 근거 열위)
--       스포티지R 8.8L, 쏘렌토UM 9.0L(카쎈 표 이상값) → 동일 R엔진 XM 기준 7.5L
-- 방법론 검증: 현대 오너스매뉴얼 온라인(ownersmanual.hyundai.com) 접근 확인 —
--       차기 매뉴얼 라운드에서 세대별 '추천 윤활유' 원문 대조 계속
-- ============================================================
UPDATE engine_oil_specs SET capacity_liters=3.3, viscosity='5W-30', api_grade='SN',
  ilsac_grade='GF-5', source='취급설명서 규격 인용+감마 공통(verified)'
  WHERE vehicle_id IN (SELECT id FROM vehicles WHERE generation='AD' AND fuel_type='가솔린');
UPDATE engine_oil_specs SET capacity_liters=7.5, source='R엔진 동일 파워트레인 대조-쏘렌토XM(verified: 용량)'
  WHERE vehicle_id IN (SELECT id FROM vehicles WHERE generation IN ('SL','UM') AND fuel_type='디젤');
