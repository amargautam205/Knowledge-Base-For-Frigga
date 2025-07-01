import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base_front/screens/signup_screen/bloc/signup_screen_event.dart';
import 'package:knowledge_base_front/screens/signup_screen/bloc/signup_screen_state.dart';
import 'package:knowledge_base_front/screens/signup_screen/login_screen_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupButtonPressed>(_onSignupButtonPressed);
  }

  void _onSignupButtonPressed(
      SignupButtonPressed event, Emitter<SignupState> emit) async {
    try {
      emit(SignupLoading());
      await SignupScreenPresenter.signup(
          event.firstName, event.lastName, event.email, event.password);
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure(error: e.toString().replaceAll("Exception: ", "")));
    }
  }
}
