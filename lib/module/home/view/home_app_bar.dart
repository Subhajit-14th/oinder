import 'package:flutter/material.dart';
import 'package:oinder/module/notification/view/notification_view.dart';
import 'package:oinder/module/preferences/view/preference_bottom_sheet.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///==========================
        /// PROFILE IMAGE
        ///==========================
        // Container(
        //   height: 42,
        //   width: 42,
        //   decoration: BoxDecoration(
        //     color: AppColor.primaryLight.withValues(alpha: .35),
        //     borderRadius: BorderRadius.circular(14),
        //   ),
        //   child: const Center(
        //     child: Texts(
        //       "O",
        //       color: AppColor.white,
        //       fontWeight: FontWeight.bold,
        //       fontSize: 18,
        //     ),
        //   ),
        // ),

        // const SizedBox(width: 12),

        ///==========================
        /// APP NAME
        ///==========================
        Expanded(
          child: Row(
            children: [
              Image.asset(
                "assets/app_logo/app_logo_transparent.png",
                height: 26,
                width: 26,
              ),

              const SizedBox(width: 8),

              const Texts(
                "Oinder",
                color: AppColor.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),

        ///==========================
        /// FILTER BUTTON
        ///==========================
        _CircleButton(
          icon: Icons.tune_rounded,
          onTap: () {
            showPreferenceBottomSheet(context);
          },
        ),
        const SizedBox(width: 10),

        ///==========================
        /// NOTIFICATION BUTTON
        ///==========================
        Stack(
          clipBehavior: Clip.none,
          children: [
            _CircleButton(
              icon: Icons.notifications_none_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  AppRoutes.slideFromRight(NotificationView()),
                );
              },
            ),

            Positioned(
              right: 10,
              top: 10,
              child: Container(
                height: 9,
                width: 9,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xff1E1E22),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showPreferenceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (_) {
        return const FractionallySizedBox(
          heightFactor: .88,
          child: PreferenceBottomSheet(),
        );
      },
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Ink(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: const Color(0xff2C2C31),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: .08)),
        ),
        child: Icon(icon, color: AppColor.white, size: 22),
      ),
    );
  }
}
