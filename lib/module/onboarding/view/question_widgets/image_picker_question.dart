import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oinder/core/services/imageUploadToServer/provider/image_upload_provider.dart';
import 'package:oinder/module/onboarding/model/onboarding_question_model.dart';
import 'package:oinder/module/onboarding/provider/onbaording_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class ImagePickerQuestion extends ConsumerWidget {
  final OnboardingQuestionModel question;

  const ImagePickerQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final List<String> images = List<String>.from(
      state.answers[question.id] ?? [],
    );
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: .78,
          ),
          itemBuilder: (_, index) {
            final hasImage = index < images.length;

            return InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () async {
                final picker = ImagePicker();

                final XFile? file = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 85,
                );

                if (file == null) return;

                final imageUrl = await ref
                    .read(imageUploadProvider.notifier)
                    .uploadImage(imageFile: File(file.path));

                if (imageUrl != null) {
                  ref
                      .read(onboardingProvider.notifier)
                      .addImage(question.id, imageUrl);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.surfaceLight,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColor.grey.withValues(alpha: .25),
                  ),
                ),
                child: hasImage
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(images[index], fit: BoxFit.cover),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add_a_photo,
                            size: 36,
                            color: AppColor.primaryColor,
                          ),
                          SizedBox(height: 10),
                          Texts(
                            "Add Photo",
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),

        Texts(
          question.helperText ?? "Add at least 2 recent photos.",
          textAlign: TextAlign.center,
          color: AppColor.grey,
          fontSize: 15,
        ),
      ],
    );
  }
}
