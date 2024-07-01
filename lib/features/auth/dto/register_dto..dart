class RegisterDto {
  final String username;
  final String password;
  final String confirm;

  const RegisterDto(
      {required this.username, required this.password, required this.confirm});

  Map<String, dynamic> toJson() =>
      {'username': username, 'password': password, 'confirm': confirm};
}
