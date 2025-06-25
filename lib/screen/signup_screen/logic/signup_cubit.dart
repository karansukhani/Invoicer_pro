import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:invoicer_pro_flutter/screen/signup_screen/logic/signup_repository.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> callSignupApi(FormData signupFormData) async {
    emit(SignupLoading());

    await SignupRepository().callSignupApi(signupFormData);

    emit(SignupSuccess());
    //Progress pending model integration pending
  }
}
