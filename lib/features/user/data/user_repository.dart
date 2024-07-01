import 'package:f_localbrand/features/auth/data/auth_local_data_source.dart';
import 'package:f_localbrand/features/user/data/user_api_client.dart';
import 'package:f_localbrand/features/user/data/user_local_data_source.dart';
import 'package:f_localbrand/features/user/dto/user_dto.dart';

import '../../result_type.dart';

class UserRepository {
  final UserApiClient userApiClient;
  final UserLocalDataSource userLocalDataSource;
  final AuthLocalDataSource authLocalDataSource;

  const UserRepository(
      {required this.userApiClient,
      required this.userLocalDataSource,
      required this.authLocalDataSource});

  Future<Result<UserDto>> getUserInfo() async {
    try {
      final String? jwtToken = await authLocalDataSource.getToken();
      final UserDto userInfo = await userApiClient.getUserInfo(jwtToken);
      await userLocalDataSource.saveUserInfo(userInfo);
      return Success(userInfo);
    } catch (e) {
      return Failure('$e');
    }
  }

  Future<UserDto?> getUserProfile() async {
    try {
      final UserDto? user = await userLocalDataSource.getUserInfo();
      return user;
    } catch (e) {
      return null;
    }
  }
}
