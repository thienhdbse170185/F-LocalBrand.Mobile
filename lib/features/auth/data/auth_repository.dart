import 'dart:developer';

import 'package:f_localbrand/features/auth/data/auth_api_client.dart';
import 'package:f_localbrand/features/user/data/user_api_client.dart';
import 'package:f_localbrand/service/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

import '../../result_type.dart';
import '../dto/login_dto.dart';
import '../dto/register_dto.dart';
import 'auth_exception.dart';
import 'auth_local_data_source.dart';

class AuthRepository {
  final AuthApiClient authApiClient;
  final AuthLocalDataSource authLocalDataSource;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final UserApiClient userApiClient;

  AuthRepository(
      {required this.authApiClient,
      required this.authLocalDataSource,
      required this.userApiClient,
      firebase_auth.FirebaseAuth? firebaseAuth,
      GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  Future<Result<void>> login({
    required String username,
    required String password,
  }) async {
    try {
      final loginSuccessDto = await authApiClient.login(
        LoginDto(username: username, password: password),
      );
      await authLocalDataSource.saveToken(loginSuccessDto.accessToken);
      String token = await PushNotifications.getDeviceToken();
      await userApiClient.updateDeviceId(token, loginSuccessDto.accessToken);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
    return Success(null);
  }

  Future<Result<void>> register(RegisterDto user) async {
    try {
      await authApiClient.register(user);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
    return Success(null);
  }

  Future<Result<String?>> getToken() async {
    try {
      final token = await authLocalDataSource.getToken();
      if (token == null) {
        return Success(null);
      }
      return Success(token);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
  }

  Future<Result<void>> logout() async {
    try {
      await authLocalDataSource.deleteToken();
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      return Success(null);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<Result> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print(credential);

      final firebase_auth.UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final response = await authApiClient
          .loginGoogle(userCredential.credential?.accessToken);
      print(response.accessToken);
      String token = await PushNotifications.getDeviceToken();
      await userApiClient.updateDeviceId(token, response.accessToken);
      await authLocalDataSource.saveToken(response.accessToken);
      return Success(null);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<Result<void>> loginShipper({
    required String username,
    required String password,
  }) async {
    try {
      final loginSuccessDto = await authApiClient.loginShipper(
        LoginDto(username: username, password: password),
      );
      await authLocalDataSource.saveToken(loginSuccessDto.accessToken);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
    return Success(null);
  }
}
