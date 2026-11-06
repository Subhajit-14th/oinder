import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/onboarding/model/onboarding_question_model.dart';
import 'package:oinder/module/onboarding/provider/onbaording_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class SliderQuestion extends ConsumerWidget {
  final OnboardingQuestionModel question;

  const SliderQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);
    double value =
        (state.answers[question.id] as double?) ??
        question.sliderValue ??
        question.sliderMin ??
        0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withValues(alpha: .15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Texts(
              "${value.round()} km",
              color: AppColor.primaryColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 45),

        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColor.primaryColor,
            inactiveTrackColor: AppColor.grey.withValues(alpha: .25),
            thumbColor: AppColor.primaryColor,
            overlayColor: AppColor.primaryColor.withValues(alpha: .15),
            trackHeight: 6,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
          ),
          child: Slider(
            value: value,
            min: question.sliderMin ?? 0,
            max: question.sliderMax ?? 100,
            divisions: ((question.sliderMax ?? 100) - (question.sliderMin ?? 0))
                .round(),
            label: value.round().toString(),
            onChanged: (newValue) {
              notifier.updateSliderValue(
                questionId: question.id,
                value: newValue,
              );
            },
          ),
        ),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Texts(
              "${question.sliderMin?.round() ?? 0} km",
              color: AppColor.grey,
              fontSize: 14,
            ),
            Texts(
              "${question.sliderMax?.round() ?? 100} km",
              color: AppColor.grey,
              fontSize: 14,
            ),
          ],
        ),

        if (question.helperText != null) ...[
          const SizedBox(height: 28),
          Texts(
            question.helperText!,
            color: AppColor.grey,
            fontSize: 15,
            height: 1.4,
          ),
        ],
      ],
    );
  }
}
