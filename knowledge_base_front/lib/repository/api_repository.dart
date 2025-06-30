import 'package:dio/dio.dart';

class ApiRepository {
  static final Dio dio = Dio();
  static final String _baseUrl = "http://192.168.137.137:8080";

  static Future<Response> getAPI({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await dio.get(
        '$_baseUrl/$endpoint',
        queryParameters: queryParams,
      );
      print("GET API Success: ${response.data}");
      return response;
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Failed to fetch data';
      throw Exception(errorMessage);
    }
  }

  static Future<Response> postAPI({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.post(
        '$_baseUrl/$endpoint',
        queryParameters: queryParams,
        data: data,
      );
      print("POST API Success: ${response.data}");
      return response;
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Failed to fetch data';
      throw Exception(errorMessage);
    }
  }
}
