import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final bool isActive;
  final bool enableHaptic;

  const AppButton({
    super.key,
    required this.text,
    this.onTap,
    this.style,
    this.textStyle,
    this.width,
    this.height,
    this.backgroundColor,
    this.isActive = true,
    this.enableHaptic = true,
  });

  void _maybeHaptic() {
    if (enableHaptic && !kIsWeb) {
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = onTap != null;

    // Default colors (orange if active, gray if not)
    final Color bgColor =
        backgroundColor ??
        (isActive ? AppColor.primaryColor : AppColor.primaryLight);

    final double btnWidth = width ?? double.infinity;
    final double btnHeight = height ?? 56.0;

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      disabledBackgroundColor: bgColor.withOpacity(0.6),
      foregroundColor: AppColor.white,
      disabledForegroundColor: Colors.white70,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.zero,
      minimumSize: Size(btnWidth, btnHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ).merge(style);

    return SizedBox(
      width: btnWidth,
      height: btnHeight,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: enabled
            ? () {
                _maybeHaptic();
                onTap?.call();
              }
            : null,
        child: Texts(
          text,
          fontSize: 18,
          color: AppColor.white,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
