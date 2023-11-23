import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/freezed_bloc/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit()
      : super(UserState(
            userModel: const UserModel(
                name: 'Initial', email: 'initial', phone: '0314029402')));

  void updateName(String newName) {
    final updatedUserModel = state.userModel.copyWith(name: newName);
    emit(UserState(userModel: updatedUserModel));
  }
}
