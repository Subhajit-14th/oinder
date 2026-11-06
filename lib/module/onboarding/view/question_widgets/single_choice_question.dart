import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/onboarding/model/onboarding_question_model.dart';
import 'package:oinder/module/onboarding/provider/onbaording_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class SingleChoiceQuestion extends ConsumerWidget {
  final OnboardingQuestionModel question;

  const SingleChoiceQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);

    final notifier = ref.read(onboardingProvider.notifier);

    final selected = state.answers[question.id]?.toString();

    return Column(
      children: [
        ...question.options!.map((option) {
          final isSelected = selected == option.id;

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                notifier.selectSingleOption(question.id, option.id);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColor.primaryColor
                      : AppColor.bodyColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColor.primaryColor
                        : AppColor.grey.withValues(alpha: .35),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Texts(
                        option.title,
                        color: AppColor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? AppColor.white : AppColor.grey,
                          width: 2,
                        ),
                        color: isSelected ? AppColor.white : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 15,
                              color: AppColor.primaryColor,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
