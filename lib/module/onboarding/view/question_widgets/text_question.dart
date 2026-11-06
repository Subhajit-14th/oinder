import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/onboarding/model/onboarding_question_model.dart';
import 'package:oinder/module/onboarding/provider/onbaording_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class TextQuestion extends ConsumerStatefulWidget {
  final OnboardingQuestionModel question;

  const TextQuestion({super.key, required this.question});

  @override
  ConsumerState<TextQuestion> createState() => _TextQuestionState();
}

class _TextQuestionState extends ConsumerState<TextQuestion> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    final state = ref.read(onboardingProvider);

    controller = TextEditingController(
      text: state.answers[widget.question.id]?.toString() ?? "",
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(onboardingProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          cursorColor: AppColor.primaryColor,
          style: Styles.textStyle(
            color: AppColor.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: widget.question.placeholder ?? "Enter here",
            hintStyle: Styles.textStyle(
              color: AppColor.grey.withValues(alpha: .45),
              fontSize: 22,
            ),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            notifier.saveAnswer(widget.question.id, value);
          },
        ),

        Container(height: 1.5, color: AppColor.grey.withValues(alpha: .35)),

        const SizedBox(height: 16),

        if (widget.question.helperText != null)
          Texts(
            widget.question.helperText!,
            color: AppColor.grey,
            fontSize: 15,
            height: 1.4,
          ),
      ],
    );
  }
}
