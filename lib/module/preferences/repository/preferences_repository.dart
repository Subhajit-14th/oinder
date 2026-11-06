import 'dart:developer';

import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/module/preferences/model/get_discovery_response_model.dart';
import 'package:oinder/module/preferences/model/looking_for_you_question_api_response_model.dart';
import 'package:oinder/module/preferences/model/post_discovery_preferences_answer_api_response.dart';

class PreferencesRepository {
  final ApiService _apiService;

  PreferencesRepository(this._apiService);

  /// Get Looking For You Questions
  Future<OnboardingQuestionResponse> getLookingForYouQuestions({
    required String token,
  }) async {
    final response = await _apiService.getRequest(
      ApiContants.getLookingForYouQuestions,
      headers: {"Authorization": "Bearer $token"},
    );
    return OnboardingQuestionResponse.fromJson(response.data);
  }

  /// Post Preferences Answers
  Future<DiscoveryResponse> postPreferencesAnswers({
    required String token,
    required Map<String, dynamic> answers,
  }) async {
    final response = await _apiService.postRequest(
      {"Authorization": "Bearer $token"},
      ApiContants.postPreferencesAnswers,
      data: answers,
    );
    return DiscoveryResponse.fromJson(response.data);
  }

  /// Get Preferences Answers
  Future<DiscoveryPreferencesResponse> getPreferencesAnswers({
    required String token,
  }) async {
    try {
      log("========== GET PREFERENCES START ==========");
      log("API: ${ApiContants.getPreferencesAnswers}");
      log("Token Available: ${token.isNotEmpty}");
      final response = await _apiService.getRequest(
        ApiContants.getPreferencesAnswers,
        headers: {"Authorization": "Bearer $token"},
      );
      log("Response Status: ${response.statusCode}");
      log("Response Data: ${response.data}");
      log("========== GET PREFERENCES END ==========");
      return DiscoveryPreferencesResponse.fromJson(response.data);
    } catch (e, stackTrace) {
      log("GET PREFERENCES ERROR: $e");
      log(stackTrace.toString());
      rethrow;
    }
  }
}
