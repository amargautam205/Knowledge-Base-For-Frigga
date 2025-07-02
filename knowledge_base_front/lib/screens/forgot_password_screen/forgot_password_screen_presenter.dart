import 'package:knowledge_base_front/repository/api_repository.dart';
import 'package:knowledge_base_front/utils/api_const.dart';

class ForgotPasswordPresenter {
  static Future<void> sendResetLink(String email) async {
    print("I am here 1 >?>?>?>?>?>?>");
    final response = await ApiRepository.postAPI(
      endpoint: ApiConst.forgotPassword,
      data: {'email': email},
    );

    final json = response.data;
     print("I am here 2>?>?>?>?>?>?>");
    if (response.statusCode == 200 && json['status'] == 'success') {
       print("I am here 3>?>?>?>?>?>?>");
      return;
    } else {
       print("I am here 4>?>?>?>?>?>?>");
      throw Exception(json['message'] ?? 'Something went wrong');
    }
  }
}
