# 해담 (Haedam)

분재 경매 플랫폼 - Flutter Web + Firebase 기반

## 프로젝트 개요

해담은 분재를 대상으로 한 온라인 경매 플랫폼입니다. 사용자들은 실시간으로 분재에 입찰할 수 있고, 즉시구매 옵션도 제공됩니다.

## 기술 스택

- **Frontend**: Flutter Web
- **Backend**: Firebase (Auth + Firestore + Cloud Functions + Storage + Hosting)
- **상태 관리**: Riverpod
- **라우팅**: go_router
- **데이터 모델링**: Freezed + json_serializable
- **UI**: Material Design 3

## 주요 기능

### 사용자 기능

- 회원가입/로그인 (이메일/비밀번호)
- 분재 경매 조회 및 입찰
- 즉시구매
- 주문 관리 및 입금 안내
- 프로필 관리

### 관리자 기능

- 분재 승인/관리
- 경매 상태 제어
- 주문 관리 및 입금 확인
- CSV 업로드를 통한 입금 대조
- 감사 로그 관리

## 프로젝트 구조

```
lib/
├── core/                    # 핵심 설정
│   ├── constants/          # 상수 정의
│   ├── routing/            # 라우팅 설정
│   └── theme/              # 테마 설정
├── features/               # 기능별 모듈
│   ├── auth/              # 인증 관련
│   ├── items/             # 분재 관리
│   ├── orders/            # 주문 관리
│   └── admin/             # 관리자 기능
└── shared/                # 공통 컴포넌트
    ├── services/          # 서비스 레이어
    └── widgets/           # 공통 위젯
```

## 개발 환경 설정

### 1. Flutter 환경 설정

```bash
flutter --version  # Flutter 3.9.0 이상 필요
```

### 2. Firebase 프로젝트 설정

1. [Firebase Console](https://console.firebase.google.com/)에서 새 프로젝트 생성
2. Web 앱 추가
3. `lib/firebase_options.dart` 파일에 실제 Firebase 설정 값 입력

### 3. 의존성 설치

```bash
flutter pub get
```

### 4. 코드 생성

```bash
flutter packages pub run build_runner build
```

### 5. 개발 서버 실행

```bash
flutter run -d chrome
```

## Firebase 설정

### Firestore 보안 규칙

- `firestore.rules` 파일에 보안 규칙 정의
- 입찰/주문 관련 쓰기는 Cloud Functions를 통해서만 허용

### Storage 규칙

- `storage.rules` 파일에 스토리지 보안 규칙 정의
- 분재 이미지는 공개 읽기, 민감 파일은 관리자만 접근

### Cloud Functions

- 입찰 처리
- 경매 종료 처리
- 주문 생성 및 관리
- 입금 확인 및 매칭

## 배포

### Firebase Hosting 배포

```bash
# Flutter Web 빌드
flutter build web --release

# Firebase 배포
firebase deploy --only hosting
```

### Cloud Functions 배포

```bash
firebase deploy --only functions
```

## 라이선스

이 프로젝트는 MIT 라이선스 하에 있습니다.
