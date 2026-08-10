-- ============================================================
-- 마이그레이션 v1: oil_filters → 범용 parts 테이블 통합
-- 설계 근거: 차종 중심으로 부품 종류를 계속 확장하는 단일 구조 (사용자 확정)
-- engine_oil_specs는 유체 '규격' 테이블로 존치 (품번 차원과 분리)
-- ============================================================
CREATE TABLE IF NOT EXISTS parts (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    vehicle_id     INTEGER NOT NULL REFERENCES vehicles(id),
    part_type      TEXT NOT NULL,          -- '오일필터'|'에어컨필터'|'와이퍼'|(향후 확장)
    label          TEXT,                   -- 와이퍼: 운전석/조수석/후방
    brand          TEXT,
    part_number    TEXT NOT NULL,          -- 품번 또는 사이즈('650mm')
    oe_part_number TEXT,
    verified       INTEGER DEFAULT 0,
    UNIQUE(vehicle_id, part_type, label, brand, part_number)
);
CREATE INDEX IF NOT EXISTS idx_parts_vehicle ON parts(vehicle_id, part_type);

INSERT OR IGNORE INTO parts (vehicle_id, part_type, label, brand, part_number, oe_part_number, verified)
SELECT vehicle_id, '오일필터', NULL, brand, part_number, oe_part_number, verified
FROM oil_filters;

DROP TABLE oil_filters;
