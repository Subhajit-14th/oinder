import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/network/network_manager.dart';

class DioClient {
  final Dio _dio;

  DioClient({
    required String baseUrl,
    required Ref ref,
    List<Interceptor>? interceptors,
  }) : _dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           connectTimeout: const Duration(seconds: 30),
           receiveTimeout: const Duration(seconds: 30),
           sendTimeout: const Duration(seconds: 30),
         ),
       ) {
    _dio.interceptors.addAll(interceptors ?? [NetworkManager(ref)]);
  }

  Dio get dio => _dio;
}
