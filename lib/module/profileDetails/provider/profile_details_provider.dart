import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/get_device_id.dart';
import 'package:oinder/module/profileDetails/model/profile_details_api_response_model.dart';
import 'package:oinder/module/profileDetails/repository/profile_details_repository.dart';

/// Repository Provider
final profileDetailsRepositoryProvider = Provider<ProfileDetailsRepository>((
  ref,
) {
  final apiService = ref.watch(apiServiceProvider);
  return ProfileDetailsRepository(apiService);
});

/// Profile Details Provider
final profileDetailsProvider = FutureProvider.autoDispose
    .family<ProfileDetailsResponse, String>((ref, userId) async {
      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);

      if (token == null || token.isEmpty) {
        throw Exception("User not authenticated");
      }

      final repository = ref.read(profileDetailsRepositoryProvider);
      return repository.getUserProfileDetails(token: token, userId: userId);
    });
