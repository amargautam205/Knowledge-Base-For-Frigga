import 'package:dio/dio.dart';

class ApiRepository {
  static final Dio dio = Dio();
  static final String _baseUrl = "http://192.168.29.231:8080";

  // Generic GET method
  static Future<Response> getAPI({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await dio.get(
        '$_baseUrl/$endpoint',
        queryParameters: queryParams,
      );
      print("API called successfully.");
      if (response.statusCode == 200) {
        print("Response data: ${response.data}");
        return response;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to fetch data');
    }
  }

 //Genric Post Method 
static Future<Response> postAPI({
  required String endpoint,
  Map<String, dynamic>? queryParams,
  Map<String, dynamic>? data, // <-- Add this
}) async {
  try {
    final response = await dio.post(
      '$_baseUrl/$endpoint',
      queryParameters: queryParams,
      data: data, // <-- Use it here
    );
    print("API called successfully.");
    if (response.statusCode == 200) {
      print("Response data: ${response.data}");
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print("Error: $e");
    throw Exception('Failed to fetch data');
  }
}
}