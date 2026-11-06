import 'package:oinder/module/onboarding/model/onboarding_question_model.dart';

class OnboardingState {
  final int currentPage;

  final List<OnboardingQuestionModel> questions;

  final Map<String, dynamic> answers;

  final bool canContinue;

  final bool isLoading;

  final String? error;

  const OnboardingState({
    this.currentPage = 0,
    this.questions = const [],
    this.answers = const {},
    this.canContinue = false,
    this.isLoading = false,
    this.error,
  });

  OnboardingState copyWith({
    int? currentPage,
    List<OnboardingQuestionModel>? questions,
    Map<String, dynamic>? answers,
    bool? canContinue,
    bool? isLoading,
    String? error,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      canContinue: canContinue ?? this.canContinue,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
