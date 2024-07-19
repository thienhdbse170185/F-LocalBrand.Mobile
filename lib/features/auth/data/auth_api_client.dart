import 'dart:io';

import 'package:dio/dio.dart';
import 'package:f_localbrand/features/auth/dto/login_dto.dart';

import '../dto/login_success.dart';
import '../dto/register_dto.dart';

class AuthApiClient {
  AuthApiClient(this.dio);

  final Dio dio;

  Future<LoginSuccessDto> login(LoginDto loginDto) async {
    try {
      final response = await dio.post(
        '/auth/customer-login',
        data: loginDto.toJson(),
      );
      return LoginSuccessDto.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['result']['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> register(RegisterDto registerDto) async {
    try {
      FormData formData = FormData.fromMap(await registerDto.toJson());
      await dio.post('/auth/customer/register-customer', data: formData);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['result']['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<LoginSuccessDto> loginGoogle(String? token) async {
    final request = {'idToken': token};
    try {
      final response = await dio.post('/auth/google-login', data: request);
      return LoginSuccessDto.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['result']['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<LoginSuccessDto> loginShipper(LoginDto loginDto) async {
    try {
      final response = await dio.post(
        '/auth/user',
        data: loginDto.toJson(),
      );
      return LoginSuccessDto.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['result']['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }
}
