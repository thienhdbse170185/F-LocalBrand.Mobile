import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class RegisterDto {
  final String username;
  final String fullName;
  final String password;
  final String confirm;
  final String email;
  final String phone;
  final String address;
  final XFile? image;

  const RegisterDto({
    required this.username,
    required this.password,
    required this.confirm,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    this.image,
  });

  Future<Map<String, dynamic>> toJson() async => {
        'UserName': username,
        'FullName': fullName,
        'Password': password,
        'ConfirmPassword': confirm,
        'Email': email,
        'Phone': phone,
        'Address': address,
        'ImageUrl': await MultipartFile.fromFile(image!.path,
            filename: image!.name, contentType: MediaType('image', 'jpeg')),
      };
}
