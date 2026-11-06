import 'package:flutter/material.dart';
import 'package:oinder/utils/utils.dart';

class OnboardingProgress extends StatelessWidget {
  final int current;
  final int total;

  const OnboardingProgress({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total <= 0 ? 0.0 : (current + 1) / total;

    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: progress),
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return LinearProgressIndicator(
            value: value,
            minHeight: 6,
            backgroundColor: AppColor.white.withValues(alpha: .12),
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColor.primaryColor,
            ),
          );
        },
      ),
    );
  }
}
