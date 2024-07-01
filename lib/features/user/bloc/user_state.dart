part of 'user_cubit.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

class GetUserInfoProgress extends UserState {}

class GetUserInfoSuccess extends UserState {
  final UserDto user;

  GetUserInfoSuccess({required this.user});
}

class GetUserInfoFailure extends UserState {}

class GetUserProfileProgress extends UserState {}

class GetUserProfileSuccess extends UserState {
  final UserDto user;

  GetUserProfileSuccess({required this.user});
}

class GetUserProfileFailure extends UserState {}
