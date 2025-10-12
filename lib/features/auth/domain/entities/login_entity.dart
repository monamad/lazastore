class LoginEntity {
  final String accessToken;
  final String expiresAtUtc;
  final String refreshToken;

  const LoginEntity({
    required this.accessToken,
    required this.expiresAtUtc,
    required this.refreshToken,
  });
}
