class UserDto {
  final int id;
  final String username;
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String image;

  const UserDto(this.id, this.username, this.fullName, this.email, this.phone,
      this.address, this.image);

  Map<String, dynamic> toJson() => {
        'userID': id,
        'username': username,
        'fullname': fullName,
        'email': email,
        'phone': phone,
        'address': address,
        'image': image
      };

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      json['customer']['id'],
      json['customer']['userName'] ?? "",
      json['customer']['fullName'] ?? "",
      json['customer']['email'],
      json['customer']['phone'] ?? "",
      json['customer']['address'] ?? "",
      json['customer']['image'] ?? "",
    );
  }
}
