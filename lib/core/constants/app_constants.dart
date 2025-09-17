class AppConstants {
  // 앱 정보
  static const String appName = '해담';
  static const String appVersion = '1.0.0';

  // 경매 설정
  static const int defaultBidStep = 1000;
  static const int defaultAutoExtendMinutes = 2;
  static const int depositDeadlineHours = 48;

  // 이미지 설정
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'webp'];

  // 페이지네이션
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // 수수료 설정
  static const double buyerPremiumRate = 0.07; // 7%
  static const double sellerFeeRate = 0.10; // 10%

  // 은행 계좌 정보
  static const String bankName = 'KB국민은행';
  static const String accountNumber = '123456-01-000000';
  static const String accountOwner = '고에카';
}
