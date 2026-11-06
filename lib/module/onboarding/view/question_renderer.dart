import 'package:flutter/material.dart';
import 'package:oinder/module/onboarding/model/onboarding_question_model.dart';
import 'package:oinder/module/onboarding/view/question_widgets/bio_question.dart';
import 'package:oinder/module/onboarding/view/question_widgets/card_choice_question.dart';
import 'package:oinder/module/onboarding/view/question_widgets/date_question.dart';
import 'package:oinder/module/onboarding/view/question_widgets/group_choice_question.dart';
import 'package:oinder/module/onboarding/view/question_widgets/image_picker_question.dart';
import 'package:oinder/module/onboarding/view/question_widgets/multi_choice_question.dart';
import 'package:oinder/module/onboarding/view/question_widgets/single_choice_question.dart';
import 'package:oinder/module/onboarding/view/question_widgets/slider_question.dart';
import 'package:oinder/module/onboarding/view/question_widgets/tag_question.dart';
import 'package:oinder/module/onboarding/view/question_widgets/text_question.dart';

class QuestionRenderer extends StatelessWidget {
  final OnboardingQuestionModel question;

  const QuestionRenderer({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case QuestionType.text:
        return TextQuestion(question: question);

      case QuestionType.date:
        return DateQuestion(question: question);

      case QuestionType.singleChoice:
        return SingleChoiceQuestion(question: question);

      case QuestionType.multiChoice:
        return MultiChoiceQuestion(question: question);

      case QuestionType.cardChoice:
        return CardChoiceQuestion(question: question);

      case QuestionType.slider:
        return SliderQuestion(question: question);

      case QuestionType.groupChoice:
        return GroupChoiceQuestion(question: question);

      case QuestionType.tags:
        return TagQuestion(question: question);

      case QuestionType.bio:
        return BioQuestion(question: question);

      case QuestionType.imagePicker:
        return ImagePickerQuestion(question: question);
    }
  }
}
