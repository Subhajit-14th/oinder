import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:oinder/module/onboarding/model/onboarding_question_model.dart';
import 'package:oinder/module/onboarding/provider/onbaording_provider.dart';
import 'package:oinder/utils/utils.dart';

class DateQuestion extends ConsumerStatefulWidget {
  final OnboardingQuestionModel question;

  const DateQuestion({super.key, required this.question});

  @override
  ConsumerState<DateQuestion> createState() => _DateQuestionState();
}

class _DateQuestionState extends ConsumerState<DateQuestion> {
  DateTime? selectedDate;

  Future<void> pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year - 18, now.month, now.day),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColor.primaryColor,
              surface: AppColor.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      ref
          .read(onboardingProvider.notifier)
          .saveAnswer(
            widget.question.id,
            DateFormat("yyyy-MM-dd").format(picked),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: pickDate,
          child: Container(
            height: 62,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: AppColor.black.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColor.white.withValues(alpha: .18)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  color: AppColor.white,
                  size: 26,
                ),
                const SizedBox(width: 14),

                Expanded(
                  child: Text(
                    selectedDate == null
                        ? "Select your birthday"
                        : DateFormat("dd MMM yyyy").format(selectedDate!),
                    style: TextStyle(
                      color: selectedDate == null
                          ? AppColor.grey
                          : AppColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.white),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
