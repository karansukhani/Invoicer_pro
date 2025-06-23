import 'package:bloc/bloc.dart';
import 'package:invoicer_pro_flutter/screen/login/logic/login_repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> callLoginApi(Map<String, dynamic> loginMap) async {
    emit(LoginLoading());

    LoginRepository().callLoginApi(loginMap);
  }
}
