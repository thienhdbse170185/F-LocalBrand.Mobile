import 'package:shared_preferences/shared_preferences.dart';

import '../dto/user_dto.dart';
import 'constants.dart';

class UserLocalDataSource {
  UserLocalDataSource(this.sf);

  final SharedPreferences sf;

  Future<void> saveUserInfo(UserDto user) async {
    await sf.setInt(UserDataConstants.userIdKey, user.id);
    await sf.setString(UserDataConstants.usernameKey, user.username ?? "");
    await sf.setString(UserDataConstants.fullNameKey, user.fullName ?? "");
    await sf.setString(UserDataConstants.emailKey, user.email);
    await sf.setString(UserDataConstants.phoneKey, user.phone ?? "");
    await sf.setString(UserDataConstants.addressKey, user.address ?? "");
    await sf.setString(UserDataConstants.imageKey, user.image ?? "");
  }

  Future<UserDto?> getUserInfo() async {
    final userId = sf.getInt(UserDataConstants.userIdKey);
    final username = sf.getString(UserDataConstants.usernameKey);
    final fullname = sf.getString(UserDataConstants.fullNameKey);
    final email = sf.getString(UserDataConstants.emailKey);
    final phone = sf.getString(UserDataConstants.phoneKey);
    final address = sf.getString(UserDataConstants.addressKey);
    final image = sf.getString(UserDataConstants.imageKey);

    if (userId == null ||
        username == null ||
        fullname == null ||
        email == null ||
        phone == null ||
        address == null ||
        image == null) {
      return null;
    }

    return UserDto(userId, username, fullname, email, phone, address, image);
  }

  Future<void> clearUserInfo() async {
    await sf.remove(UserDataConstants.userIdKey);
    await sf.remove(UserDataConstants.usernameKey);
    await sf.remove(UserDataConstants.emailKey);
    await sf.remove(UserDataConstants.phoneKey);
    await sf.remove(UserDataConstants.addressKey);
    await sf.remove(UserDataConstants.imageKey);
  }
}
