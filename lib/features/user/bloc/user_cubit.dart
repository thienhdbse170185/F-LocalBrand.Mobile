import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../result_type.dart';
import '../data/user_repository.dart';
import '../dto/user_dto.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit(this.userRepository) : super(UserInitial(null));

  Future<void> getUserInfo() async {
    emit(GetUserInfoProgress(null));
    final result = await userRepository.getUserInfo();
    return (switch (result) {
      Success() => emit(GetUserInfoSuccess(user: result.data)),
      Failure() => emit(GetUserInfoFailure(null))
    });
  }

  Future<void> getUserProfile() async {
    emit(GetUserProfileProgress(null));
    final result = await userRepository.getUserProfile();
    if (result != null) {
      emit(GetUserProfileSuccess(user: result));
    } else {
      emit(GetUserProfileFailure(null));
    }
  }
}
