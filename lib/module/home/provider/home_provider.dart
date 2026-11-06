import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/get_device_id.dart';
import 'package:oinder/module/home/model/get_users_profile_api_response_model.dart';
import 'package:oinder/module/home/model/home_profile_model.dart';
import 'package:oinder/module/home/model/user_like_match_api_response_model.dart';
import 'package:oinder/module/home/model/user_super_like_api_response_model.dart';
import 'package:oinder/module/home/repository/home_repository.dart';
import 'package:oinder/module/preferences/provider/preferences_provider.dart';

// Repository Provider
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return HomeRepository(apiService);
});

// Home Provider
final homeProfilesProvider =
    StateNotifierProvider<HomeProfileNotifier, List<HomeProfileModel>>((ref) {
      final repository = ref.read(homeRepositoryProvider);
      return HomeProfileNotifier(repository: repository, ref: ref);
    });

class HomeProfileNotifier extends StateNotifier<List<HomeProfileModel>> {
  final HomeRepository repository;
  final Ref ref;

  HomeProfileNotifier({required this.repository, required this.ref})
    : super([]);

  Future<void> getUsers() async {
    ref.read(homeLoadingProvider.notifier).state = true;
    try {
      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);
      if (token == null || token.isEmpty) {
        throw Exception("User not authenticated");
      }
      final preferences = await ref.read(getPreferencesAnswersProvider.future);
      final filters = preferences.filtersApplied;
      final usersResponse = await repository.getUsersProfile(
        token: token,
        lookingFor: filters?.lookingFor,
        interestedIn:
            filters?.interestedIn != null && filters!.interestedIn.isNotEmpty
            ? filters.interestedIn.first
            : null,
        minAge: filters?.minAge,
        maxAge: filters?.maxAge,
        maxDistance: filters?.maxDistance,
        isVerified: filters?.isVerified,
      );
      log("Users Count: ${usersResponse.users?.length ?? 0}");
      state =
          usersResponse.users
              ?.map((user) => _convertToHomeProfile(user))
              .toList() ??
          [];
    } catch (e, stackTrace) {
      log("Get Users Error: $e");
      log(stackTrace.toString());
      state = [];
    } finally {
      ref.read(homeLoadingProvider.notifier).state = false;
    }
  }

  HomeProfileModel _convertToHomeProfile(UserProfileModel user) {
    return HomeProfileModel(
      id: user.id ?? '',
      name: user.name?.isNotEmpty == true ? user.name! : "Unknown",
      age: user.age ?? 0,
      profession: user.educationLevel?.isNotEmpty == true
          ? user.educationLevel!
          : "Professional",
      distance: "${user.distancePreference ?? 0} km away",
      bio: user.bio?.isNotEmpty == true ? user.bio! : "No bio available",
      image: user.profilePhoto?.isNotEmpty == true
          ? user.profilePhoto!
          : "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800",
      match: _calculateMatch(user),
      isVerified: user.isVerified ?? false,
      isLike: user.isLike ?? false,
    );
  }

  int _calculateMatch(UserProfileModel user) {
    int match = 80;
    if (user.interests?.isNotEmpty == true) {
      match += 5;
    }
    if (user.isVerified == true) {
      match += 5;
    }
    return match > 99 ? 99 : match;
  }

  void removeTopCard() {
    if (state.isEmpty) return;
    state = [...state.skip(1)];
  }

  Future<void> resetCards() async {
    await getUsers();
  }
}

final homeLoadingProvider = StateProvider<bool>((ref) => false);

final getUsersMatchProfileProvider =
    FutureProvider.family<LikeResponseModel, String>((ref, userId) async {
      final repository = ref.read(homeRepositoryProvider);
      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);
      if (token == null) {
        throw Exception("Authentication token not found");
      }
      return repository.getUsersMatchProfile(token: token, userId: userId);
    });

final userSuperLikeProfileProvider = FutureProvider.autoDispose
    .family<UserSuperLikeResponse, String>((ref, userId) async {
      final repository = ref.read(homeRepositoryProvider);
      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);
      if (token == null) {
        throw Exception("Authentication token not found");
      }
      return repository.getUserSuperLikeProfile(token: token, userId: userId);
    });
