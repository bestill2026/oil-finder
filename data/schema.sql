-- ============================================================
-- 마이카핏 DB 스키마 (v2 — parts 통합 + body_type + manual 캐시)
-- 주의: 이 파일은 현재 DB에서 덤프한 최신본. 구버전 schema.sql 교체용.
-- ============================================================

PRAGMA foreign_keys = ON;

CREATE TABLE manufacturers (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL UNIQUE          -- 예: 현대, 기아, 벤츠
);

CREATE TABLE vehicles (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    manufacturer_id  INTEGER NOT NULL REFERENCES manufacturers(id),
    model_name       TEXT NOT NULL,           -- 예: 아반떼
    generation       TEXT,                    -- 예: CN7
    year_start       INTEGER NOT NULL,        -- 적용 연식 시작
    year_end         INTEGER,                 -- NULL이면 현재까지 생산중
    engine_code      TEXT NOT NULL,           -- 예: 스마트스트림 G1.6
    fuel_type        TEXT NOT NULL,           -- 가솔린 / 디젤 / LPG / 하이브리드 / 전기
    displacement_cc  INTEGER,                 -- 배기량(cc), 전기차는 NULL
    trim_note        TEXT, body_type TEXT,                    -- 예: N라인, 하이브리드 등 세부 구분
    UNIQUE(manufacturer_id, model_name, generation, engine_code, fuel_type)
);

CREATE TABLE engine_oil_specs (
    id                    INTEGER PRIMARY KEY AUTOINCREMENT,
    vehicle_id            INTEGER NOT NULL REFERENCES vehicles(id),
    viscosity             TEXT NOT NULL,      -- SAE 점도, 예: 0W-20
    api_grade             TEXT,               -- 예: SN PLUS, SP
    ilsac_grade           TEXT,               -- 예: GF-6
    oil_type              TEXT,               -- 합성유 / 부분합성유 / 광유
    capacity_liters       REAL NOT NULL,      -- 오일+필터 교환 시 주입량
    change_interval_km    INTEGER,            -- 표준 교환주기(km)
    change_interval_month INTEGER,            -- 표준 교환주기(개월)
    severe_interval_km    INTEGER,            -- 가혹조건 교환주기(km)
    source                TEXT,               -- 데이터 출처 (예: 취급설명서 2023년판)
    notes                 TEXT
);

CREATE INDEX idx_vehicles_lookup ON vehicles(model_name, generation, engine_code);

CREATE INDEX idx_oil_specs_vehicle ON engine_oil_specs(vehicle_id);

CREATE TABLE vehicle_aliases (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    vehicle_id  INTEGER NOT NULL REFERENCES vehicles(id),
    alias_type  TEXT NOT NULL,     -- 'reg_name'(등록차명) / 'detail_model'(상세모델명) / 'engine_form'(원동기형식)
    alias_value TEXT NOT NULL,
    UNIQUE(alias_type, alias_value, vehicle_id)
);

CREATE TABLE product_cache (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    keyword      TEXT NOT NULL,          -- 검색 키워드 (예: '0W-20 합성 엔진오일', '26300-35505 오일필터')
    product_name TEXT NOT NULL,
    price        INTEGER,
    image_url    TEXT,
    product_url  TEXT NOT NULL,          -- 파트너스 트래킹 링크
    is_rocket    INTEGER DEFAULT 0,
    rank         INTEGER,
    fetched_at   TEXT NOT NULL           -- 갱신 시각 (ISO)
, manual INTEGER DEFAULT 0);

CREATE INDEX idx_cache_keyword ON product_cache(keyword);

CREATE TABLE parts (
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

CREATE INDEX idx_parts_vehicle ON parts(vehicle_id, part_type);
