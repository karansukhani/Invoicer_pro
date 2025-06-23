import 'package:bloc/bloc.dart';
import 'package:invoicer_pro_flutter/screen/signup_screen/logic/signup_repository.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> callSignupApi(Map<String, dynamic> signupMap) async {
    emit(SignupLoading());

    await SignupRepository().callSignupApi(signupMap);

    emit(SignupSuccess());
    //Progress pending model integration pending
  }
}
