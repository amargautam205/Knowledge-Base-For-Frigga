import 'package:knowledge_base_front/repository/api_repository.dart';
import 'package:knowledge_base_front/utils/api_const.dart';

class ForgotPasswordPresenter {
  static Future<void> sendResetLink(String email) async {
    final response = await ApiRepository.postAPI(
      endpoint: ApiConst.forgotPassword,
      data: {'email': email},
    );

    final json = response.data;
    if (response.statusCode == 200 && json['status'] == 'success') {
      return;
    } else {
      throw Exception(json['message'] ?? 'Something went wrong');
    }
  }
}
