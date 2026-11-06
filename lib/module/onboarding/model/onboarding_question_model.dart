enum QuestionType {
  text,
  date,
  singleChoice,
  multiChoice,
  cardChoice,
  slider,
  groupChoice,
  tags,
  bio,
  imagePicker,
}

class OnboardingQuestionModel {
  final String id;

  /// API stepId
  final String stepId;

  /// API stepNumber
  final int stepNumber;

  final String title;
  final String? subTitle;

  final QuestionType type;

  final List<OptionModel>? options;

  final bool isRequired;
  final bool canSkip;

  /// single/multi selection
  final int? minSelection;
  final int? maxSelection;

  /// slider
  final double? sliderMin;
  final double? sliderMax;
  final double? sliderValue;
  final String? sliderUnit;
  final String? sliderFooterNote;

  /// text field
  final String? placeholder;
  final String? helperText;

  /// toggle field from API
  final ToggleFieldModel? toggleField;

  /// group questions
  final List<QuestionGroupModel>? groups;

  /// interests categories
  final List<InterestCategoryModel>? categories;

  /// simple tags
  final List<String>? tags;

  final bool isActive;
  final String? createdAt;

  const OnboardingQuestionModel({
    required this.id,
    this.stepId = "",
    this.stepNumber = 0,
    required this.title,
    required this.type,
    this.subTitle,
    this.options,
    this.isRequired = true,
    this.canSkip = false,
    this.minSelection,
    this.maxSelection,
    this.sliderMin,
    this.sliderMax,
    this.sliderValue,
    this.sliderUnit,
    this.sliderFooterNote,
    this.placeholder,
    this.helperText,
    this.toggleField,
    this.groups,
    this.categories,
    this.tags,
    this.isActive = true,
    this.createdAt,
  });
}

class OptionModel {
  final String id;
  final String title;
  final String? subtitle;

  const OptionModel({required this.id, required this.title, this.subtitle});
}

class ToggleFieldModel {
  final String name;
  final String label;
  final bool defaultValue;

  const ToggleFieldModel({
    required this.name,
    required this.label,
    required this.defaultValue,
  });
}

class QuestionGroupModel {
  final String id;
  final String title;
  final String type;
  final List<String> options;

  const QuestionGroupModel({
    required this.id,
    required this.title,
    required this.type,
    required this.options,
  });
}

class InterestCategoryModel {
  final String name;
  final List<String> tags;

  const InterestCategoryModel({required this.name, required this.tags});
}
