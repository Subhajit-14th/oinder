import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:oinder/core/network/dio_client.dart';
import 'package:oinder/core/network/network_error_handler.dart';
import 'package:oinder/utils/utils.dart';

class ApiService {
  final Dio _dio;

  ApiService(DioClient dioClient) : _dio = dioClient.dio;

  // GET API
  Future<Response> getRequest(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      return await _dio.get(
        endpoint,
        options: headers != null ? Options(headers: headers) : null,
      );
    } on DioException catch (e) {
      throw NetworkExceptions.fromDioError(e);
    }
  }

  Future<Response> getRequestWithHeader(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        options: headers != null ? Options(headers: headers) : null,
      );

      // 🔥 Ensure always Map
      if (response.data is String) {
        response.data = jsonDecode(response.data);
      }

      return response;
    } on DioException catch (e) {
      throw NetworkExceptions.fromDioError(e);
    }
  }

  Future<Response> getRequestWithParams(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
    } on DioException catch (e) {
      throw NetworkExceptions.fromDioError(e);
    }
  }

  // POST API
  Future<Response> postRequest(
    Map<String, String>? headers,
    String endpoint, {
    required Map<String, dynamic> data,
  }) async {
    log("POST request sent to $endpoint with data: $data");
    try {
      return await _dio.post(
        endpoint,
        data: data,
        options: headers != null ? Options(headers: headers) : null,
      );
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        type: e.type,
        error: e.response?.data?["error"] ?? e.message,
      );
    } catch (e, stackTrace) {
      log("API Error: $e", stackTrace: stackTrace);

      throw Exception("Unexpected error occurred: $e");
    }
  }

  // MULTIPART POST API
  Future<Response> multipartRequest(
    String endpoint, {
    Map<String, String>? headers,
    required Map<String, dynamic> fields,
    void Function(int sent, int total)? onProgress,
  }) async {
    try {
      FormData formData = FormData.fromMap(fields);

      return await _dio.post(
        endpoint,
        data: formData,
        options: Options(headers: headers, contentType: "multipart/form-data"),
        onSendProgress: onProgress,
      );
    } on DioException catch (e) {
      log("Dio Error: $e");
      log("Status Code: ${e.response?.statusCode}");
      log("Message: ${e.message}");
      throw NetworkExceptions.fromDioError(e);
    }
  }

  Future<Response> fromDataMultipartRequest(
    String endpoint, {
    Map<String, String>? headers,
    required FormData formData,
    void Function(int sent, int total)? onProgress,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(headers: headers, contentType: "multipart/form-data"),
        onSendProgress: onProgress,
      );

      return response;
    } on DioException catch (e) {
      log("========== MULTIPART API ERROR ==========");
      log("URL: $endpoint");
      log("STATUS CODE: ${e.response?.statusCode}");
      log("RESPONSE: ${e.response?.data}");
      log("MESSAGE: ${e.message}");

      throw NetworkExceptions.fromDioError(e);
    } catch (e, stackTrace) {
      log(
        "========== UNKNOWN API ERROR ==========",
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  Future<Response> deleteRequest(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.delete(
        endpoint,
        data: data,
        options: headers != null ? Options(headers: headers) : null,
      );
    } on DioException catch (e) {
      throw NetworkExceptions.fromDioError(e);
    }
  }
}
