import 'package:flutter/material.dart';
import 'package:oinder/utils/utils.dart';

class AppSnackbar {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void show({
    required String message,
    required Color backgroundColor,
    required Color iconBackgroundColor,
    required IconData icon,
  }) {
    messengerKey.currentState?.hideCurrentSnackBar();

    messengerKey.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColor.transparent,
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        duration: const Duration(seconds: 3),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: AppColor.black.withValues(alpha: .18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColor.white, size: 23),
              ),
              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  message,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColor.white,
                    fontSize: 15,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Success Snackbar
  static void showSuccess(
    String message, {
    IconData icon = Icons.check_circle_rounded,
  }) {
    show(
      message: message,
      backgroundColor: AppColor.secondaryDark,
      iconBackgroundColor: AppColor.secondaryColor,
      icon: icon,
    );
  }

  /// Error Snackbar
  static void showError(String message, {IconData icon = Icons.error_rounded}) {
    show(
      message: message,
      backgroundColor: const Color(0xff3A1F2B),
      iconBackgroundColor: const Color(0xffE53935),
      icon: icon,
    );
  }

  /// Info Snackbar
  static void showInfo(String message, {IconData icon = Icons.info_rounded}) {
    show(
      message: message,
      backgroundColor: AppColor.primaryDark,
      iconBackgroundColor: AppColor.primaryColor,
      icon: icon,
    );
  }

  /// Warning Snackbar
  static void showWarning(
    String message, {
    IconData icon = Icons.warning_rounded,
  }) {
    show(
      message: message,
      backgroundColor: const Color(0xff3B3320),
      iconBackgroundColor: const Color(0xffF9A825),
      icon: icon,
    );
  }
}
