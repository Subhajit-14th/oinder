import 'package:flutter/material.dart';
import 'package:oinder/module/edirProfile/view/edit_profile_view.dart';
import 'package:oinder/module/preferences/view/preference_bottom_sheet.dart';
import 'package:oinder/module/profileUtlis/view/safety_center.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class ProfileQuickActionGrid extends StatelessWidget {
  const ProfileQuickActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.edit_rounded, "Edit Profile"),
      (Icons.tune_rounded, "Preferences"),
      (Icons.shield_rounded, "Safety Center"),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Row(
        children: items.map((item) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: _QuickActionCard(
                icon: item.$1,
                title: item.$2,
                onTap: () {
                  if (item.$2 == "Edit Profile") {
                    Navigator.push(
                      context,
                      AppRoutes.slideFromRight(EditProfileView()),
                    );
                  }
                  if (item.$2 == "Preferences") {
                    showPreferenceBottomSheet(context);
                  }

                  if (item.$2 == "Safety Center") {
                    Navigator.push(
                      context,
                      AppRoutes.slideFromRight(SafetyCenter()),
                    );
                  }
                },
              ),
            ),
          );
        }).toList(),
      ),
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

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          height: 118,
          decoration: BoxDecoration(
            color: const Color(0xff2A2A2F),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColor.white.withValues(alpha: .04)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: AppColor.primaryLight.withValues(alpha: .15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColor.primaryColor, size: 24),
              ),
              const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Texts(
                  title,
                  color: AppColor.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
