import 'package:knowledge_base_front/repository/api_repository.dart';
import 'package:knowledge_base_front/utils/api_const.dart';

class LoginScreenPresenter {
  LoginScreenPresenter();

  //Method to Login User.
  static Future<void> login(String email, String password) async {
    try {
      await ApiRepository.postAPI(
        endpoint: ApiConst.login,
        data: {
          'email': email,
          'password': password,
        },
      );
    } catch (e) {
      // Handle exceptions
      print('Error : $e');
      throw Exception('Failed to Login');
    }
  }
}
