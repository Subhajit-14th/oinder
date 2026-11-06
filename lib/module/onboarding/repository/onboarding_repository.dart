import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/module/onboarding/model/onbaording_question_api_response_model.dart';
import 'package:oinder/module/onboarding/model/onboarding_question_register_api_response_model.dart';

class OnboardingRepository {
  final ApiService apiService;

  OnboardingRepository({required this.apiService});

  /// Get Onboarding Questions
  Future<OnboardingResponse> getOnboardingQuestions() async {
    final response = await apiService.getRequest(
      ApiContants.getOnboardingQuestions,
    );
    return OnboardingResponse.fromJson(response.data);
  }

  /// Get Onboarding Question Post
  Future<CompleteProfileResponseModel> postOnboardingPost({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final response = await apiService.postRequest(
      {"Authorization": "Bearer $token"},
      ApiContants.postOnboardingQuestionsAnswer,
      data: data,
    );
    return CompleteProfileResponseModel.fromJson(response.data);
  }
}
