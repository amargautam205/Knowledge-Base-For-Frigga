import 'package:knowledge_base_front/repository/api_repository.dart';
import 'package:knowledge_base_front/utils/api_const.dart';

class CreateDocumentScreenPresenter {
  CreateDocumentScreenPresenter();

  static Future<void> createDocument(
      String title, String content, bool isPublic) async {
    final response = await ApiRepository.postAPI(
      endpoint: ApiConst.createDocument,
      data: {
        'title': title,
        'content': content,
        'isPublic': isPublic,
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
