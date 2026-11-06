import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/get_device_id.dart';
import 'package:oinder/module/onboarding/model/onboarding_question_model.dart';
import 'package:oinder/module/onboarding/model/onboarding_question_register_api_response_model.dart';
import 'package:oinder/module/onboarding/provider/onboarding_state.dart';
import 'package:oinder/module/onboarding/provider/question_mapper.dart';
import 'package:oinder/module/onboarding/repository/onboarding_repository.dart';

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);

  return OnboardingRepository(apiService: apiService);
});

final onboardingProvider =
    NotifierProvider<OnboardingNotifier, OnboardingState>(
      OnboardingNotifier.new,
    );

class OnboardingNotifier extends Notifier<OnboardingState> {
  @override
  OnboardingState build() {
    return const OnboardingState();
  }

  Future<void> getQuestions() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = ref.read(onboardingRepositoryProvider);
      final response = await repository.getOnboardingQuestions();
      final questions = response.questions
          .map((e) => e.toQuestionModel())
          .toList();
      state = state.copyWith(
        questions: questions,
        currentPage: 0,
        isLoading: false,
        canContinue: questions.isNotEmpty
            ? _validate(state.answers, questions.first)
            : false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void nextPage() {
    if (state.questions.isEmpty) {
      return;
    }
    if (state.currentPage >= state.questions.length - 1) {
      return;
    }
    final next = state.currentPage + 1;
    final question = state.questions[next];
    state = state.copyWith(
      currentPage: next,
      canContinue: _validate(state.answers, question),
    );
  }

  void previousPage() {
    if (state.questions.isEmpty) {
      return;
    }
    if (state.currentPage <= 0) {
      return;
    }
    final previous = state.currentPage - 1;
    final question = state.questions[previous];
    state = state.copyWith(
      currentPage: previous,
      canContinue: _validate(state.answers, question),
    );
  }

  void saveAnswer(String id, dynamic value) {
    final data = Map<String, dynamic>.from(state.answers);
    data[id] = value;
    if (state.questions.isEmpty) {
      state = state.copyWith(answers: data);
      return;
    }
    final question = state.questions[state.currentPage];
    state = state.copyWith(
      answers: data,
      canContinue: _validate(data, question),
    );
  }

  void selectSingleOption(String questionId, String optionId) {
    saveAnswer(questionId, optionId);
  }

  void toggleMultiSelection({
    required String questionId,
    required String optionId,
    int? maxSelection,
  }) {
    final values = List<String>.from(state.answers[questionId] ?? []);
    if (values.contains(optionId)) {
      values.remove(optionId);
    } else {
      if (maxSelection != null && values.length >= maxSelection) {
        return;
      }
      values.add(optionId);
    }
    saveAnswer(questionId, values);
  }

  void updateSliderValue({required String questionId, required double value}) {
    saveAnswer(questionId, value);
  }

  void addImage(String questionId, String path) {
    final images = List<String>.from(state.answers[questionId] ?? []);
    images.add(path);
    saveAnswer(questionId, images);
  }

  void removeImage(String questionId, String path) {
    final images = List<String>.from(state.answers[questionId] ?? []);
    images.remove(path);
    saveAnswer(questionId, images);
  }

  bool _validate(
    Map<String, dynamic> answers,
    OnboardingQuestionModel question,
  ) {
    final value = answers[question.id];
    switch (question.type) {
      case QuestionType.text:
      case QuestionType.date:
        return value != null && value.toString().trim().isNotEmpty;
      case QuestionType.singleChoice:
      case QuestionType.cardChoice:
        return value != null;
      case QuestionType.multiChoice:
      case QuestionType.tags:
        return value is List && value.isNotEmpty;
      case QuestionType.slider:
        return value != null;
      case QuestionType.groupChoice:
        return value is Map && value.isNotEmpty;
      case QuestionType.bio:
        if (value is Map) {
          return (value["bio"] ?? "").toString().trim().isNotEmpty;
        }
        return false;
      case QuestionType.imagePicker:
        return value is List && value.isNotEmpty;
    }
  }
}

/// Onboarding Post Question
final onboardingSubmitProvider =
    AsyncNotifierProvider<
      OnboardingSubmitNotifier,
      CompleteProfileResponseModel?
    >(OnboardingSubmitNotifier.new);

class OnboardingSubmitNotifier
    extends AsyncNotifier<CompleteProfileResponseModel?> {
  @override
  Future<CompleteProfileResponseModel?> build() async {
    return null;
  }

  Future<CompleteProfileResponseModel> submit({
    required Map<String, dynamic> payload,
  }) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(onboardingRepositoryProvider);

      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);

      if (token == null || token.isEmpty) {
        throw Exception("User not authenticated");
      }

      final response = await repository.postOnboardingPost(
        token: token,
        data: payload,
      );

      state = AsyncData(response);

      return response;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
