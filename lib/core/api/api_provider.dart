import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/core/network/dio_client.dart';

final dioClientProvider = Provider(
  (ref) => DioClient(baseUrl: ApiContants.baseUrl, ref: ref),
);

final apiServiceProvider = Provider(
  (ref) => ApiService(ref.read(dioClientProvider)),
);
