import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base_front/repository/api_repository.dart';
import 'package:knowledge_base_front/screens/login_screen/bloc/login_screen_event.dart';
import 'package:knowledge_base_front/screens/login_screen/bloc/login_screen_state.dart';
import 'package:knowledge_base_front/screens/login_screen/login_screen_presenter.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      await LoginScreenPresenter.login(event.email, event.password);
      emit(LoginSuccess());
      print("Login successful");
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
      print("Login failed: $e");
    }
  }
}
