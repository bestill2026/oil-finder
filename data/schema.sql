-- ============================================================
-- 자동차 오일필터/엔진오일 매칭 서비스 - DB 스키마
-- ============================================================

PRAGMA foreign_keys = ON;

-- 1. 제조사
CREATE TABLE manufacturers (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL UNIQUE          -- 예: 현대, 기아, 벤츠
);

-- 2. 차량 (모델 + 세대 + 연식범위 + 엔진 조합 단위로 한 행)
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
    trim_note        TEXT,                    -- 예: N라인, 하이브리드 등 세부 구분
    UNIQUE(manufacturer_id, model_name, generation, engine_code, fuel_type)
);

-- 3. 엔진오일 스펙 (차량 1건당 보통 1개, 트림별로 다르면 여러 개)
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

-- 4. 오일필터 (브랜드별로 여러 개 매칭 가능하므로 1:N)
CREATE TABLE oil_filters (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    vehicle_id      INTEGER NOT NULL REFERENCES vehicles(id),
    brand           TEXT NOT NULL,        -- 예: 현대모비스(OE), MANN-FILTER, Bosch
    part_number     TEXT NOT NULL,        -- 해당 브랜드의 품번
    oe_part_number  TEXT,                 -- OE(순정) 품번 (브랜드가 OE가 아닐 때 상호참조용)
    filter_type     TEXT DEFAULT '오일필터',
    UNIQUE(vehicle_id, brand, part_number)
);

CREATE INDEX idx_vehicles_lookup ON vehicles(model_name, generation, engine_code);
CREATE INDEX idx_oil_specs_vehicle ON engine_oil_specs(vehicle_id);
CREATE INDEX idx_filters_vehicle ON oil_filters(vehicle_id);
