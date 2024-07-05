class RegisterDto {
  final String username;
  final String fullName;
  final String password;
  final String confirm;
  final String email;
  final String phone;
  final String address;
  final String image;

  const RegisterDto({
    required this.username,
    required this.password,
    required this.confirm,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        'UserName': username,
        'FullName': fullName,
        'Password': password,
        'ConfirmPassword': confirm,
        'Email': email,
        'Phone': phone,
        'Address': address,
        'ImageURL': image,
      };
}
