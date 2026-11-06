import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/network/network_error_handler.dart';

class NetworkManager extends Interceptor {
  final Ref ref;

  NetworkManager(this.ref);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final data = err.response?.data;
    if (statusCode == 401 ||
        (data is Map &&
            data['message'] != null &&
            data['message'].toString().toLowerCase().contains("token"))) {
      // ref.read(logoutTriggerProvider.notifier).state = true;
      return;
    }
    final exception = NetworkExceptions.fromDioError(err);
    err = err.copyWith(message: exception.message);

    handler.next(err);
  }
}
