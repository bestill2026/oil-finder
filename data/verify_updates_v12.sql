-- 검증 업데이트 v12: 카쎈 조견표 매핑 누락 회수 (K3 1.6 가솔린 4.0L / YD 디젤 5.0L)
UPDATE engine_oil_specs SET capacity_liters=4.0, source='카쎈 정비 조견표(verified: 용량)'
 WHERE vehicle_id IN (SELECT id FROM vehicles WHERE generation IN ('YD','BD') AND fuel_type='가솔린');
UPDATE engine_oil_specs SET capacity_liters=5.0, source='카쎈 정비 조견표(verified: 용량)'
 WHERE vehicle_id IN (SELECT id FROM vehicles WHERE generation='YD' AND fuel_type='디젤');
