import 'package:bloc/bloc.dart';

import '../../result_type.dart';
import '../data/user_repository.dart';
import '../dto/user_dto.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit(this.userRepository) : super(UserInitial());

  Future<void> getUserInfo() async {
    emit(GetUserInfoProgress());
    final result = await userRepository.getUserInfo();
    return (switch (result) {
      Success() => emit(GetUserInfoSuccess(user: result.data)),
      Failure() => emit(GetUserInfoFailure())
    });
  }

  Future<void> getUserProfile() async {
    emit(GetUserProfileProgress());
    final result = await userRepository.getUserProfile();
    if (result != null) {
      emit(GetUserProfileSuccess(user: result));
    } else {
      emit(GetUserProfileFailure());
    }
  }
}
