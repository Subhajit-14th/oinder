class OnboardingResponse {
  final bool success;
  final int totalSteps;
  final List<OnboardingQuestion> questions;

  const OnboardingResponse({
    required this.success,
    required this.totalSteps,
    required this.questions,
  });

  factory OnboardingResponse.fromJson(Map<String, dynamic> json) {
    return OnboardingResponse(
      success: json['success'] ?? false,
      totalSteps: json['totalSteps'] ?? 0,
      questions: (json['questions'] as List<dynamic>? ?? [])
          .map((e) => OnboardingQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'totalSteps': totalSteps,
      'questions': questions.map((e) => e.toJson()).toList(),
    };
  }
}

/// QUESTION MODEL
class OnboardingQuestion {
  final String id;
  final String stepId;
  final int stepNumber;
  final String title;
  final String? subtitle;
  final String type;
  final bool required;
  final bool canSkip;

  final List<OnboardingOption> options;

  final ToggleField? toggleField;
  final SliderConfig? sliderConfig;

  final List<QuestionGroup>? groups;
  final List<InterestCategory>? categories;

  final bool isActive;
  final String? createdAt;

  const OnboardingQuestion({
    required this.id,
    required this.stepId,
    required this.stepNumber,
    required this.title,
    this.subtitle,
    required this.type,
    required this.required,
    required this.canSkip,
    required this.options,
    this.toggleField,
    this.sliderConfig,
    this.groups,
    this.categories,
    required this.isActive,
    this.createdAt,
  });

  factory OnboardingQuestion.fromJson(Map<String, dynamic> json) {
    return OnboardingQuestion(
      id: json['_id'] ?? '',

      stepId: json['stepId'] ?? '',

      stepNumber: json['stepNumber'] ?? 0,

      title: json['title'] ?? '',

      subtitle: json['subtitle'],

      type: json['type'] ?? '',

      required: json['required'] ?? false,

      canSkip: json['canSkip'] ?? false,

      options: (json['options'] as List<dynamic>? ?? [])
          .map((e) => OnboardingOption.fromJson(e as Map<String, dynamic>))
          .toList(),

      toggleField: json['toggleField'] != null
          ? ToggleField.fromJson(json['toggleField'])
          : null,

      sliderConfig: json['sliderConfig'] != null
          ? SliderConfig.fromJson(json['sliderConfig'])
          : null,

      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => QuestionGroup.fromJson(e as Map<String, dynamic>))
          .toList(),

      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => InterestCategory.fromJson(e as Map<String, dynamic>))
          .toList(),

      isActive: json['isActive'] ?? false,

      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,

      'stepId': stepId,

      'stepNumber': stepNumber,

      'title': title,

      'subtitle': subtitle,

      'type': type,

      'required': required,

      'canSkip': canSkip,

      'options': options.map((e) => e.toJson()).toList(),

      'toggleField': toggleField?.toJson(),

      'sliderConfig': sliderConfig?.toJson(),

      'groups': groups?.map((e) => e.toJson()).toList(),

      'categories': categories?.map((e) => e.toJson()).toList(),

      'isActive': isActive,

      'createdAt': createdAt,
    };
  }
}

/// OPTION MODEL

class OnboardingOption {
  final String id;
  final String label;
  final String? optionId;
  final String? description;

  const OnboardingOption({
    required this.id,
    required this.label,
    this.optionId,
    this.description,
  });

  factory OnboardingOption.fromJson(Map<String, dynamic> json) {
    return OnboardingOption(
      id: json['id'] ?? '',

      label: json['label'] ?? '',

      optionId: json['_id'],

      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      '_id': optionId,
      'description': description,
    };
  }
}

/// TOGGLE FIELD

class ToggleField {
  final String name;
  final String label;
  final bool defaultValue;

  const ToggleField({
    required this.name,
    required this.label,
    required this.defaultValue,
  });

  factory ToggleField.fromJson(Map<String, dynamic> json) {
    return ToggleField(
      name: json['name'] ?? '',

      label: json['label'] ?? '',

      defaultValue: json['default'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'label': label, 'default': defaultValue};
  }
}

/// SLIDER CONFIG

class SliderConfig {
  final String unit;
  final double min;
  final double max;
  final double defaultValue;
  final String? footerNote;

  const SliderConfig({
    required this.unit,
    required this.min,
    required this.max,
    required this.defaultValue,
    this.footerNote,
  });

  factory SliderConfig.fromJson(Map<String, dynamic> json) {
    return SliderConfig(
      unit: json['unit'] ?? '',

      min: (json['min'] ?? 0).toDouble(),

      max: (json['max'] ?? 0).toDouble(),

      defaultValue: (json['defaultValue'] ?? 0).toDouble(),

      footerNote: json['footerNote'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unit': unit,

      'min': min,

      'max': max,

      'defaultValue': defaultValue,

      'footerNote': footerNote,
    };
  }
}

/// GROUP MODEL

class QuestionGroup {
  final String id;
  final String title;
  final String type;
  final List<String> options;

  const QuestionGroup({
    required this.id,
    required this.title,
    required this.type,
    required this.options,
  });

  factory QuestionGroup.fromJson(Map<String, dynamic> json) {
    return QuestionGroup(
      id: json['id'] ?? '',

      title: json['title'] ?? '',

      type: json['type'] ?? '',

      options: (json['options'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'type': type, 'options': options};
  }
}

/// INTEREST CATEGORY

class InterestCategory {
  final String name;
  final List<String> tags;

  const InterestCategory({required this.name, required this.tags});

  factory InterestCategory.fromJson(Map<String, dynamic> json) {
    return InterestCategory(
      name: json['name'] ?? '',

      tags: (json['tags'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'tags': tags};
  }
}
