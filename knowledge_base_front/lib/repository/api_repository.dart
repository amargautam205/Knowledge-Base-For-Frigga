import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRepository {
  static final Dio dio = Dio();
  static final String _baseUrl = "http://192.168.137.137:8080";

  // Get token from SharedPreferences
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  // Common method to build headers
  static Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': token != null && token.isNotEmpty ? 'Bearer $token' : '',
    };
  }

  // GET
  static Future<Response> getAPI({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final headers = await _getHeaders();
      print("<><><><><><><><>"+ '$_baseUrl/$endpoint',);
      final response = await dio.get(
        '$_baseUrl/$endpoint',
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      print("GET API Success: ${response.data}");
      return response;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to fetch data';
      throw Exception(errorMessage);
    }
  }

  // POST
  static Future<Response> postAPI({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
  }) async {
    try {
      final headers = await _getHeaders();

      final response = await dio.post(
        '$_baseUrl/$endpoint',
        queryParameters: queryParams,
        data: data,
        options: Options(headers: headers),
      );
      print("POST API Success: ${response.data}");
      return response;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to Insert data';
      throw Exception(errorMessage);
    }
  }

  // ✅ PUT
  static Future<Response> putAPI({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
  }) async {
    try {
      final headers = await _getHeaders();
      final response = await dio.put(
        '$_baseUrl/$endpoint',
        queryParameters: queryParams,
        data: data,
        options: Options(headers: headers),
      );
      print("PUT API Success: ${response.data}");
      return response;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to update data';
      throw Exception(errorMessage);
    }
  }

  // ✅ DELETE
  static Future<Response> deleteAPI({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final headers = await _getHeaders();
      final response = await dio.delete(
        '$_baseUrl/$endpoint',
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      print("DELETE API Success: ${response.data}");
      return response;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['message'] ?? 'Failed to delete data';
      throw Exception(errorMessage);
    }
  }
}
