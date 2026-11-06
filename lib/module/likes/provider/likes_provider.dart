import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/get_device_id.dart';
import 'package:oinder/module/likes/model/likes_you_api_response_model.dart';
import 'package:oinder/module/likes/repository/likes_repository.dart';

/// Repository Provider
final likesRepositoryProvider = Provider<LikesRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return LikesRepository(apiService);
});

/// Get Likes Data Provider
final likesProvider = FutureProvider.autoDispose<LikesYouResponse>((ref) async {
  final deviceId = await ref.read(deviceIdProvider.future);
  final token = await AuthStorage.getToken(deviceId);

  if (token == null || token.isEmpty) {
    throw Exception("User not authenticated");
  }

  final repository = ref.read(likesRepositoryProvider);
  return repository.getLikesData(token: token);
});
