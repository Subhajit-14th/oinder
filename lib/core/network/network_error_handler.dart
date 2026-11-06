import 'package:dio/dio.dart';

class NetworkExceptions implements Exception {
  final String message;
  NetworkExceptions(this.message);

  factory NetworkExceptions.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkExceptions("Connection Timeout");

      case DioExceptionType.connectionError:
        return NetworkExceptions("No Internet Connection");

      case DioExceptionType.badResponse:
        return _handleResponse(error);

      case DioExceptionType.cancel:
        return NetworkExceptions("Request Cancelled");

      default:
        return NetworkExceptions("Unexpected Error");
    }
  }

  static NetworkExceptions _handleResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (data is Map) {
      if (data['error'] != null) {
        return NetworkExceptions(data['error'].toString());
      }

      if (data['message'] != null) {
        return NetworkExceptions(data['message'].toString());
      }
    }

    switch (statusCode) {
      case 400:
        return NetworkExceptions("Bad Request");
      case 401:
        return NetworkExceptions("Unauthorized");
      case 403:
        return NetworkExceptions("Forbidden");
      case 404:
        return NetworkExceptions("Not Found");
      case 409:
        return NetworkExceptions("Conflict");
      case 500:
        return NetworkExceptions("Internal Server Error");
      default:
        return NetworkExceptions("Something went wrong");
    }
  }

  @override
  String toString() => message;
}
