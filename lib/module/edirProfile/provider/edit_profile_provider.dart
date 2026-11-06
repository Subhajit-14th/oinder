import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/get_device_id.dart';
import 'package:oinder/module/edirProfile/model/profile_update_success_api_response_model.dart';
import 'package:oinder/module/edirProfile/provider/edit_profile_state.dart';
import 'package:oinder/module/edirProfile/repository/edit_profile_repository.dart';
import 'package:oinder/module/onboarding/model/onbaording_question_api_response_model.dart';
import 'package:oinder/module/onboarding/repository/onboarding_repository.dart';

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return OnboardingRepository(apiService: ref.read(apiServiceProvider));
});

final editProfileRepositoryProvider = Provider<EditProfileRepository>((ref) {
  return EditProfileRepository(ref.read(apiServiceProvider));
});

final editProfileQuestionsProvider =
    FutureProvider.autoDispose<OnboardingResponse>((ref) async {
      final repository = ref.read(onboardingRepositoryProvider);
      return repository.getOnboardingQuestions();
    });

class EditProfileNotifier extends Notifier<EditProfileState> {
  @override
  EditProfileState build() {
    return const EditProfileState();
  }

  void setAnswers(Map<String, dynamic> value) {
    state = state.copyWith(answers: value);
  }

  void updateAnswer(String key, dynamic value) {
    state = state.copyWith(answers: {...state.answers, key: value});
  }

  dynamic getAnswer(String key) {
    return state.answers[key];
  }

  Future<UpdateProfileResponseModel> updateProfile({
    required Map<String, dynamic> profileData,
  }) async {
    final deviceId = await ref.read(deviceIdProvider.future);

    final token = await AuthStorage.getToken(deviceId);

    if (token == null || token.isEmpty) {
      throw Exception("User not authenticated");
    }

    final repository = ref.read(editProfileRepositoryProvider);

    final response = await repository.updateProfile(
      token: token,
      profileData: profileData,
    );

    return response;
  }

  void clear() {
    state = const EditProfileState();
  }
}

final editProfileProvider =
    NotifierProvider<EditProfileNotifier, EditProfileState>(
      EditProfileNotifier.new,
    );
