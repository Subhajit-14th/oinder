import 'package:oinder/module/onboarding/model/onbaording_question_api_response_model.dart';
import 'package:oinder/module/onboarding/model/onboarding_question_model.dart';

extension OnboardingQuestionMapper on OnboardingQuestion {
  OnboardingQuestionModel toQuestionModel() {
    return OnboardingQuestionModel(
      id: stepId,

      stepId: stepId,

      stepNumber: stepNumber,

      title: title,

      subTitle: subtitle,

      type: _getQuestionType(type),

      isRequired: required,

      canSkip: canSkip,

      options: options
          .map(
            (e) =>
                OptionModel(id: e.id, title: e.label, subtitle: e.description),
          )
          .toList(),

      toggleField: toggleField == null
          ? null
          : ToggleFieldModel(
              name: toggleField!.name,
              label: toggleField!.label,
              defaultValue: toggleField!.defaultValue,
            ),

      sliderMin: sliderConfig?.min,

      sliderMax: sliderConfig?.max,

      sliderValue: sliderConfig?.defaultValue,

      sliderUnit: sliderConfig?.unit,

      sliderFooterNote: sliderConfig?.footerNote,

      groups: groups
          ?.map(
            (e) => QuestionGroupModel(
              id: e.id,
              title: e.title,
              type: e.type,
              options: e.options,
            ),
          )
          .toList(),

      categories: categories
          ?.map((e) => InterestCategoryModel(name: e.name, tags: e.tags))
          .toList(),
    );
  }

  QuestionType _getQuestionType(String type) {
    switch (type) {
      case "text":
        return QuestionType.text;

      case "date":
        return QuestionType.date;

      case "single_select":
        return QuestionType.singleChoice;

      case "multi_select":
        return QuestionType.multiChoice;

      case "single_select_cards":
        return QuestionType.cardChoice;

      case "slider":
        return QuestionType.slider;

      case "multi_group_select":
        return QuestionType.groupChoice;

      case "multi_select_tags":
        return QuestionType.tags;

      case "bio_and_prompts":
        return QuestionType.bio;

      case "photos_grid":
        return QuestionType.imagePicker;

      default:
        return QuestionType.text;
    }
  }
}
