import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/get_device_id.dart';
import 'package:oinder/module/profileUtlis/model/get_blocked_user_api_response.dart';
import 'package:oinder/module/profileUtlis/model/post_blocked_user_api_response.dart';
import 'package:oinder/module/profileUtlis/model/post_hide_my_profile_api_response.dart';
import 'package:oinder/module/profileUtlis/repository/profile_utils_repository.dart';

/// Repository
final profileUtilsRepositoryProvider = Provider<ProfileUtilsRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ProfileUtilsRepository(apiService);
});

/// Get Blocked Users
final getBlockedUsersProvider = FutureProvider.autoDispose<BlockedUserResponse>(
  (ref) async {
    final repository = ref.watch(profileUtilsRepositoryProvider);
    final deviceId = await ref.watch(deviceIdProvider.future);
    final token = await AuthStorage.getToken(deviceId);
    if (token == null || token.isEmpty) {
      throw Exception('Authentication token not found');
    }
    return repository.getBlockedUsersList(token: token);
  },
);

/// Block User
final postBlockedUserProvider = FutureProvider.autoDispose
    .family<PostBlockedUserResponse, String>((ref, userId) async {
      final repository = ref.watch(profileUtilsRepositoryProvider);
      final deviceId = await ref.watch(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);
      if (token == null || token.isEmpty) {
        throw Exception("Authentication token not found");
      }

      return repository.postBlockedUser(token: token, userId: userId);
    });

/// Hide / Show Profile Provider
final hideMyProfileProvider = FutureProvider.autoDispose
    .family<HideProfileResponse, bool>((ref, isHide) async {
      final repository = ref.watch(profileUtilsRepositoryProvider);
      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);
      if (token == null || token.isEmpty) {
        throw Exception("User not authenticated");
      }
      return repository.hideMyProfile(token: token, isHide: isHide);
    });
