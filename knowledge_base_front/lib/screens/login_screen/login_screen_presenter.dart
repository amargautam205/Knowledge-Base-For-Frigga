import 'package:knowledge_base_front/repository/api_repository.dart';
import 'package:knowledge_base_front/utils/api_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenPresenter {
  LoginScreenPresenter();

  static Future<void> login(String email, String password) async {
    final response = await ApiRepository.postAPI(
      endpoint: ApiConst.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    final json = response.data;

    if (response.statusCode == 200 && json['status'] == 'success') {
      final token = json['data']['jwtToken'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      return;
    } else {
      throw Exception(json['message']);
    }
  }
}
