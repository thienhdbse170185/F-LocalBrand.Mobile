part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  final UserDto? user;
  const UserState(this.user);

  @override
  List<Object?> get props => [user];
}

final class UserInitial extends UserState {
  UserInitial(super.user);

  @override
  List<Object?> get props => [user];
}

class GetUserInfoProgress extends UserState {
  GetUserInfoProgress(super.user);

  @override
  List<Object?> get props => [user];
}

class GetUserInfoSuccess extends UserState {
  final UserDto user;

  GetUserInfoSuccess({required this.user}) : super(user);

  @override
  List<Object?> get props => [user];
}

class GetUserInfoFailure extends UserState {
  GetUserInfoFailure(super.user);

  @override
  List<Object?> get props => [user];
}

class GetUserProfileProgress extends UserState {
  GetUserProfileProgress(super.user);

  @override
  List<Object?> get props => [user];
}

class GetUserProfileSuccess extends UserState {
  final UserDto user;

  GetUserProfileSuccess({required this.user}) : super(user);

  @override
  List<Object?> get props => [user];
}

class GetUserProfileFailure extends UserState {
  GetUserProfileFailure(super.user);

  @override
  List<Object?> get props => [user];
}
