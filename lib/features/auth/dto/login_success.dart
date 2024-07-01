class LoginSuccessDto {
  final String accessToken;

  const LoginSuccessDto({required this.accessToken});

  factory LoginSuccessDto.fromJson(Map<String, dynamic> json) {
    return LoginSuccessDto(
        accessToken: json['result']['accessToken'] as String);
  }
}
