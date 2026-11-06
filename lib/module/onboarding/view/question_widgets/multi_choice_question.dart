import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/onboarding/model/onboarding_question_model.dart';
import 'package:oinder/module/onboarding/provider/onbaording_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class MultiChoiceQuestion extends ConsumerWidget {
  final OnboardingQuestionModel question;

  const MultiChoiceQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);
    final selected = List<String>.from(state.answers[question.id] ?? []);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (question.maxSelection != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: Texts(
              "${selected.length}/${question.maxSelection} selected",
              color: AppColor.grey,
              fontSize: 15,
            ),
          ),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: question.options!.map((option) {
            final isSelected = selected.contains(option.id);

            return InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                notifier.toggleMultiSelection(
                  questionId: question.id,
                  optionId: option.id,
                  maxSelection: question.maxSelection,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColor.primaryColor
                      : AppColor.bodyColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isSelected
                        ? AppColor.primaryColor
                        : AppColor.grey.withValues(alpha: .35),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Texts(
                      option.title,
                      color: AppColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),

                    if (isSelected) ...[
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.check_circle,
                        color: AppColor.white,
                        size: 18,
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
