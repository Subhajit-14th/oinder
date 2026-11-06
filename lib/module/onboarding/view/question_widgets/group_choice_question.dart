import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:oinder/module/onboarding/model/onboarding_question_model.dart';
import 'package:oinder/module/onboarding/provider/onbaording_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class GroupChoiceQuestion extends ConsumerWidget {
  final OnboardingQuestionModel question;

  const GroupChoiceQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final answers = Map<String, dynamic>.from(state.answers[question.id] ?? {});
    return Column(
      children: [
        ...?question.groups?.map((group) {
          return _GroupSection(
            group: group,
            selectedValue: answers[group.id],
            onSingleSelect: (value) {
              final data = Map<String, dynamic>.from(answers);
              data[group.id] = value;
              ref
                  .read(onboardingProvider.notifier)
                  .saveAnswer(question.id, data);
            },
            onMultiSelect: (value) {
              final data = Map<String, dynamic>.from(answers);
              data[group.id] = value;
              ref
                  .read(onboardingProvider.notifier)
                  .saveAnswer(question.id, data);
            },
          );
        }),
      ],
    );
  }
}

class _GroupSection extends StatelessWidget {
  final QuestionGroupModel group;
  final dynamic selectedValue;
  final Function(String) onSingleSelect;
  final Function(List<String>) onMultiSelect;

  const _GroupSection({
    required this.group,
    required this.selectedValue,
    required this.onSingleSelect,
    required this.onMultiSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Texts(
          group.title,
          color: AppColor.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 14),

        ...group.options.map((option) {
          final isMulti = group.type == "multi";
          final isSelected = isMulti
              ? (selectedValue ?? []).contains(option)
              : selectedValue == option;
          return GestureDetector(
            onTap: () {
              if (isMulti) {
                final List<String> values = List<String>.from(
                  selectedValue ?? [],
                );
                if (values.contains(option)) {
                  values.remove(option);
                } else {
                  values.add(option);
                }
                onMultiSelect(values);
              } else {
                onSingleSelect(option);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primaryColor.withValues(alpha: .18)
                    : AppColor.white.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isSelected
                      ? AppColor.primaryColor
                      : AppColor.white.withValues(alpha: .15),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      option,
                      style: const TextStyle(
                        color: AppColor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColor.primaryColor
                          : Colors.transparent,
                      border: Border.all(
                        color: AppColor.white.withValues(alpha: .4),
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 14,
                            color: AppColor.white,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 30),
      ],
    );
  }
}
