class OnboardingQuestionResponse {
  final bool? success;
  final String? id;
  final String? stepId;
  final int? stepNumber;
  final String? title;
  final String? subtitle;
  final String? type;
  final bool? required;
  final bool? canSkip;
  final List<QuestionOptionModel>? options;
  final bool? isActive;
  final DateTime? createdAt;
  final int? v;
  final QuestionModel? question;
  final QuestionModel? data;

  const OnboardingQuestionResponse({
    this.success,
    this.id,
    this.stepId,
    this.stepNumber,
    this.title,
    this.subtitle,
    this.type,
    this.required,
    this.canSkip,
    this.options,
    this.isActive,
    this.createdAt,
    this.v,
    this.question,
    this.data,
  });

  factory OnboardingQuestionResponse.fromJson(Map<String, dynamic> json) {
    return OnboardingQuestionResponse(
      success: json['success'] as bool?,
      id: json['_id'] as String?,
      stepId: json['stepId'] as String?,
      stepNumber: json['stepNumber'] as int?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      type: json['type'] as String?,
      required: json['required'] as bool?,
      canSkip: json['canSkip'] as bool?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => QuestionOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      v: json['__v'] as int?,
      question: json['question'] != null
          ? QuestionModel.fromJson(json['question'] as Map<String, dynamic>)
          : null,
      data: json['data'] != null
          ? QuestionModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      '_id': id,
      'stepId': stepId,
      'stepNumber': stepNumber,
      'title': title,
      'subtitle': subtitle,
      'type': type,
      'required': required,
      'canSkip': canSkip,
      'options': options?.map((e) => e.toJson()).toList(),
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      '__v': v,
      'question': question?.toJson(),
      'data': data?.toJson(),
    };
  }
}

class QuestionModel {
  final String? id;
  final String? stepId;
  final int? stepNumber;
  final String? title;
  final String? subtitle;
  final String? type;
  final bool? required;
  final bool? canSkip;
  final List<QuestionOptionModel>? options;
  final bool? isActive;
  final DateTime? createdAt;
  final int? v;

  const QuestionModel({
    this.id,
    this.stepId,
    this.stepNumber,
    this.title,
    this.subtitle,
    this.type,
    this.required,
    this.canSkip,
    this.options,
    this.isActive,
    this.createdAt,
    this.v,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['_id'] as String?,
      stepId: json['stepId'] as String?,
      stepNumber: json['stepNumber'] as int?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      type: json['type'] as String?,
      required: json['required'] as bool?,
      canSkip: json['canSkip'] as bool?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => QuestionOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      v: json['__v'] as int?,
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
      'options': options?.map((e) => e.toJson()).toList(),
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      '__v': v,
    };
  }
}

class QuestionOptionModel {
  final String? id;
  final String? label;
  final String? optionId;

  const QuestionOptionModel({this.id, this.label, this.optionId});

  factory QuestionOptionModel.fromJson(Map<String, dynamic> json) {
    return QuestionOptionModel(
      id: json['id'] as String?,
      label: json['label'] as String?,
      optionId: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'label': label, '_id': optionId};
  }
}
