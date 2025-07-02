import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base_front/screens/forgot_password_screen/bloc/forgot_password_screen_event.dart';
import 'package:knowledge_base_front/screens/forgot_password_screen/bloc/forgot_password_screen_state.dart';
import 'package:knowledge_base_front/screens/forgot_password_screen/forgot_password_screen_presenter.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  void _onSubmitted(
      ForgotPasswordSubmitted event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    try {
      await ForgotPasswordPresenter.sendResetLink(event.email);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(ForgotPasswordFailure(error: e.toString().replaceAll("Exception: ", "")));
    }
  }
}
