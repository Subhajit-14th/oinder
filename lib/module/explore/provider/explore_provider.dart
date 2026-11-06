import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/get_device_id.dart';
import 'package:oinder/module/explore/model/discory_by_vibe_api_response_model.dart';
import 'package:oinder/module/explore/repository/explore_repository.dart';

/// Repository
final exploreRepositoryProvider = Provider<ExploreRepository>((ref) {
  return ExploreRepository(ref.read(apiServiceProvider));
});

/// Discover By Vibe
final discoverByVibeProvider =
    FutureProvider.autoDispose<LookingForOptionsResponse>((ref) async {
      final repository = ref.read(exploreRepositoryProvider);

      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);

      if (token == null || token.isEmpty) {
        throw Exception("Token not found");
      }

      return repository.getDiscoverByVibeList(token: token);
    });
