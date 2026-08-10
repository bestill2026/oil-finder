# 마이카핏 🔧

> 내 차 엔진오일·오일필터 규격을 1분 안에 찾아주는 웹 서비스

**[→ 서비스 바로가기](https://bestill2026.github.io/oil-finder/)**

---

## 서비스 개요

차종(또는 차대번호)으로 차를 특정하면, 제조사 규격에 맞는 **엔진오일 점도·용량**과 **오일필터 품번**을 보여주고 쿠팡 구매로 연결합니다.

- 163개 차량-엔진 조합 (현대·기아·제네시스·벤츠·BMW·아우디·렉서스·KGM·르노코리아·한국GM)
- 차대번호(VIN) 17자리 자동 해석 지원
- 쿠팡 파트너스 연동 (제휴 수수료)

---

## 프로젝트 구조

```
oil-finder/
├── index.html                  # 프론트엔드 (빌드 산출물, 직접 수정 금지)
├── data/
│   ├── car_oil.db              # SQLite DB (차량 데이터 + 상품 캐시)
│   ├── schema.sql              # DB 스키마
│   ├── verify_updates_v1.sql   # 검증 라운드 1 (벤츠·BMW)
│   └── verify_updates_v2.sql   # 검증 라운드 2 (아우디·렉서스)
├── scripts/
│   ├── generate_seed_v3.py     # ★ 데이터 원장 — 차량 데이터 수정은 여기서
│   ├── export_ui.py            # DB → index.html 빌드 스크립트
│   ├── coupang_batch.py        # 쿠팡 상품 캐시 야간 배치
│   ├── add_manual_product.py   # 상품 URL 수동 등록 도구
│   ├── car_oil.db              # 스크립트 실행용 DB 사본 (data/와 동기화)
│   └── template.html           # HTML 템플릿 (__DATA__ 플레이스홀더)
└── .github/workflows/
    └── daily-build.yml         # 매일 KST 03:00 자동 빌드
```

---

## 로컬 개발

```bash
# 1. 의존성 없음 (표준 라이브러리만 사용)

# 2. 데이터 수정 후 DB 재생성
cd scripts
python3 generate_seed_v3.py
# 검증 SQL 적용 (선택)
sqlite3 car_oil.db < ../data/verify_updates_v1.sql
sqlite3 car_oil.db < ../data/verify_updates_v2.sql

# 3. HTML 빌드
python3 export_ui.py --out ../index.html

# 4. 브라우저에서 확인
open ../index.html
```

### 상품 캐시 갱신 (dry-run)
```bash
cd scripts
python3 coupang_batch.py --dry-run   # API 키 없이 목업 데이터로 테스트
```

### 쿠팡 상품 수동 등록
```bash
cd scripts
python3 add_manual_product.py \
  "26300-35505 오일필터" \
  "https://www.coupang.com/vp/products/XXXXX?itemId=YYY&vendorItemId=ZZZ" \
  "현대모비스 순정 오일필터 26300-35505" 4900 --rocket
```

---

## GitHub Actions 자동 배포

매일 KST 03:00에 자동으로:
1. 쿠팡 상품 캐시 갱신 (API 키 있으면 실 API, 없으면 dry-run)
2. index.html 재생성
3. 변경분 커밋 & 푸시 → GitHub Pages 자동 재배포

### Secrets 설정 (파트너스 API 연동 시)
저장소 → Settings → Secrets and variables → Actions:
- `COUPANG_ACCESS_KEY`: 파트너스 Access Key
- `COUPANG_SECRET_KEY`: 파트너스 Secret Key

---

## GitHub Pages 설정

1. 저장소 → **Settings → Pages**
2. Source: **Deploy from a branch**
3. Branch: `main` / Folder: `/ (root)`
4. Save → 몇 분 후 `https://bestill2026.github.io/oil-finder/` 접속 가능

---

## 데이터 신뢰도

| 배지 | 의미 |
|------|------|
| 🟢 검증됨 | 취급설명서 또는 순정부품몰에서 확인된 규격 |
| 🟠 추정치 | 동일 엔진 계열 기반 추정 — 정비 전 취급설명서 재확인 권장 |

---

## 면책

본 정보는 취급설명서·부품몰 공개 데이터를 정리한 참고용입니다. 실제 정비 전 차량 취급설명서 또는 정비소에서 규격을 최종 확인하세요.

이 서비스는 쿠팡 파트너스 활동의 일환으로, 이에 따른 일정액의 수수료를 제공받을 수 있습니다.
