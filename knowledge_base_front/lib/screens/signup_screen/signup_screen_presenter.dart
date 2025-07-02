import 'package:knowledge_base_front/repository/api_repository.dart';
import 'package:knowledge_base_front/utils/api_const.dart';

class SignupScreenPresenter {
  SignupScreenPresenter();

  static Future<void> signup(
      String firstName, String lastName, String email, String password) async {
    final response = await ApiRepository.postAPI(
      endpoint: ApiConst.signup,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      },
    );

    final json = response.data;

    if (response.statusCode == 200 && json['status'] == 'success') {
      return;
    } else {
      throw Exception(json['message']);
    }
  }
}
