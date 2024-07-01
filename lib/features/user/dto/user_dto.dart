class UserDto {
  final String id;
  final String username;
  final String email;
  final String phone;
  final String address;
  final String image;

  const UserDto(
      this.id, this.username, this.email, this.phone, this.address, this.image);

  Map<String, dynamic> toJson() => {
        'userID': id,
        'username': username,
        'email': email,
        'phone': phone,
        'address': address,
        'image': image
      };
}
