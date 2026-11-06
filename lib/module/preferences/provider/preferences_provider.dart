import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/get_device_id.dart';
import 'package:oinder/module/onboarding/model/onbaording_question_api_response_model.dart';
import 'package:oinder/module/onboarding/repository/onboarding_repository.dart';
import 'package:oinder/module/preferences/model/get_discovery_response_model.dart';
import 'package:oinder/module/preferences/model/looking_for_you_question_api_response_model.dart';
import 'package:oinder/module/preferences/model/post_discovery_preferences_answer_api_response.dart';
import 'package:oinder/module/preferences/repository/preferences_repository.dart';

/// Repository Provider
final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PreferencesRepository(apiService);
});

/// Looking For You Question Provider
final lookingForYouQuestionProvider =
    FutureProvider.autoDispose<OnboardingQuestionResponse>((ref) async {
      final repository = ref.watch(preferencesRepositoryProvider);
      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);

      if (token == null || token.isEmpty) {
        throw Exception("User not authenticated");
      }

      return repository.getLookingForYouQuestions(token: token);
    });

/// -------------------- Onboarding Question Post Provider -------------------- ///
/// Repository Provider
final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return OnboardingRepository(apiService: apiService);
});

/// Get Onboarding Questions Provider
final onboardingQuestionsProvider =
    FutureProvider.autoDispose<OnboardingResponse>((ref) async {
      final repository = ref.watch(onboardingRepositoryProvider);
      return repository.getOnboardingQuestions();
    });

// Preferences Submit Provider
final postPreferencesProvider =
    AsyncNotifierProvider<PostPreferencesNotifier, DiscoveryResponse?>(
      PostPreferencesNotifier.new,
    );

class PostPreferencesNotifier extends AsyncNotifier<DiscoveryResponse?> {
  late PreferencesRepository _repository;

  @override
  Future<DiscoveryResponse?> build() async {
    _repository = ref.read(preferencesRepositoryProvider);
    return null;
  }

  Future<void> submitPreferences({
    required Map<String, dynamic> answers,
  }) async {
    state = const AsyncLoading();

    try {
      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);

      if (token == null || token.isEmpty) {
        throw Exception("User not authenticated");
      }

      final response = await _repository.postPreferencesAnswers(
        token: token,
        answers: answers,
      );

      state = AsyncData(response);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final getPreferencesAnswersProvider =
    FutureProvider.autoDispose<DiscoveryPreferencesResponse>((ref) async {
      final repository = ref.watch(preferencesRepositoryProvider);
      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);
      if (token == null || token.isEmpty) {
        throw Exception("User not authenticated");
      }
      return repository.getPreferencesAnswers(token: token);
    });
