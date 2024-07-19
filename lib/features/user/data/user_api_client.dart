import 'dart:io';

import 'package:dio/dio.dart';
import 'package:f_localbrand/features/user/dto/user_dto.dart';

class UserApiClient {
  const UserApiClient(this.dio);

  final Dio dio;

  Future<UserDto> getUserInfo(String? jwtToken) async {
    try {
      final response = await dio.get('/auth/customer-info',
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'Bearer $jwtToken'}));
      return UserDto.fromJson(response.data['result']);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['result']['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }

  Future<void> updateDeviceId(String deviceId) async {
    try {
      await dio.put(
        '/user/update/deviceid/$deviceId',
      );
    } catch (e) {
      rethrow;
    }
  }
}
