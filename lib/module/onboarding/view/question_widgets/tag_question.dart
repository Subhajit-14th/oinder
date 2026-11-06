import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:oinder/module/onboarding/model/onboarding_question_model.dart';
import 'package:oinder/module/onboarding/provider/onbaording_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class TagQuestion extends ConsumerWidget {
  final OnboardingQuestionModel question;

  const TagQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final selectedTags = List<String>.from(state.answers[question.id] ?? []);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...?question.categories?.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Texts(
                category.name,
                color: AppColor.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 14),

              Wrap(
                spacing: 10,
                runSpacing: 12,
                children: category.tags.map((tag) {
                  final isSelected = selectedTags.contains(tag);
                  return GestureDetector(
                    onTap: () {
                      final values = List<String>.from(selectedTags);
                      if (isSelected) {
                        values.remove(tag);
                      } else {
                        if (values.length >= 10) {
                          return;
                        }
                        values.add(tag);
                      }
                      ref
                          .read(onboardingProvider.notifier)
                          .saveAnswer(question.id, values);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColor.primaryColor
                            : AppColor.white.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isSelected
                              ? AppColor.primaryColor
                              : AppColor.white.withValues(alpha: .18),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Texts(
                            tag,
                            color: isSelected
                                ? AppColor.white
                                : AppColor.white.withValues(alpha: .85),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.check_circle,
                              size: 16,
                              color: AppColor.white,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 28),
            ],
          );
        }),
      ],
    );
  }
}
