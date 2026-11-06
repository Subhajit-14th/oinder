import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:oinder/module/onboarding/model/onboarding_question_model.dart';
import 'package:oinder/module/onboarding/provider/onbaording_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class BioQuestion extends ConsumerStatefulWidget {
  final OnboardingQuestionModel question;

  const BioQuestion({super.key, required this.question});

  @override
  ConsumerState<BioQuestion> createState() => _BioQuestionState();
}

class _BioQuestionState extends ConsumerState<BioQuestion> {
  late TextEditingController bioController;
  late TextEditingController promptController;

  @override
  void initState() {
    super.initState();
    bioController = TextEditingController();
    promptController = TextEditingController();
    final oldData = ref.read(onboardingProvider).answers[widget.question.id];
    if (oldData is Map) {
      bioController.text = oldData["bio"] ?? "";
      promptController.text = oldData["prompt"] ?? "";
    }
  }

  void saveData() {
    ref.read(onboardingProvider.notifier).saveAnswer(widget.question.id, {
      "bio": bioController.text.trim(),
      "prompt": promptController.text.trim(),
    });
  }

  @override
  void dispose() {
    bioController.dispose();
    promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label("About you"),
        const SizedBox(height: 12),

        Container(
          decoration: BoxDecoration(
            color: AppColor.white.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.white.withValues(alpha: .18)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: TextField(
            controller: bioController,
            maxLines: 5,
            maxLength: 500,
            onChanged: (_) => saveData(),
            style: Styles.textStyle(color: AppColor.white, fontSize: 16),
            decoration: InputDecoration(
              hintText: "Write something about yourself...",
              hintStyle: Styles.textStyle(color: AppColor.grey),
              border: InputBorder.none,
              counterStyle: Styles.textStyle(color: AppColor.grey),
            ),
          ),
        ),
        const SizedBox(height: 28),

        _label("Add a prompt"),
        const SizedBox(height: 12),

        Container(
          decoration: BoxDecoration(
            color: AppColor.white.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.white.withValues(alpha: .18)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: promptController,
            maxLines: 3,
            maxLength: 150,
            onChanged: (_) => saveData(),
            style: Styles.textStyle(color: AppColor.white, fontSize: 16),
            decoration: InputDecoration(
              hintText: "Example: My perfect Sunday is...",
              hintStyle: Styles.textStyle(color: AppColor.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Texts(
      text,
      color: AppColor.white,
      fontSize: 17,
      fontWeight: FontWeight.w700,
    );
  }
}
