import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/services/Hive/hive_database.dart';
import 'package:oinder/core/services/auth_provider.dart';
import 'package:oinder/module/notification/view/notification_view.dart';
import 'package:oinder/module/preferences/view/preference_bottom_sheet.dart';
import 'package:oinder/module/profile/view/delete_account_view.dart';
import 'package:oinder/module/profile/view/my_photos_view.dart';
import 'package:oinder/module/profile/view/profile_menu_tile.dart';
import 'package:oinder/module/profileUtlis/view/help_center_view.dart';
import 'package:oinder/module/profileUtlis/view/privacy_and_security.dart';
import 'package:oinder/module/splash/view/splash_view.dart';
import 'package:oinder/utils/app_routes.dart';
import 'package:oinder/widget/widget.dart';

class ProfileMenuSection extends ConsumerWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 24),
      child: Column(
        children: [
          ProfileMenuTile(
            icon: Icons.photo_library_rounded,
            title: "My Photos",
            onTap: () {
              Navigator.push(context, AppRoutes.slideFromRight(MyPhotosView()));
            },
          ),
          const SizedBox(height: 12),

          ProfileMenuTile(
            icon: Icons.explore_rounded,
            title: "Discovery Settings",
            onTap: () {
              showPreferenceBottomSheet(context);
            },
          ),
          const SizedBox(height: 12),

          ProfileMenuTile(
            icon: Icons.lock_outline_rounded,
            title: "Privacy & Security",
            onTap: () {
              Navigator.push(
                context,
                AppRoutes.slideFromRight(PrivacyAndSecurity()),
              );
            },
          ),
          const SizedBox(height: 12),

          ProfileMenuTile(
            icon: Icons.notifications_none_rounded,
            title: "Push Notifications",
            onTap: () {
              Navigator.push(
                context,
                AppRoutes.slideFromRight(NotificationView()),
              );
            },
          ),
          const SizedBox(height: 12),

          ProfileMenuTile(
            icon: Icons.help_outline_rounded,
            title: "Help Center",
            onTap: () {
              Navigator.push(
                context,
                AppRoutes.slideFromRight(HelpCenterView()),
              );
            },
          ),
          const SizedBox(height: 12),

          ProfileMenuTile(
            icon: Icons.logout_rounded,
            title: "Logout",
            iconColor: Colors.redAccent,
            isLogout: true,
            onTap: () async {
              await ref.read(authProvider.notifier).logout();

              await HiveDataBase.clearHiveData();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                AppRoutes.slideFromRight(const SplashScreen()),
                (route) => false,
              );
            },
          ),
          const SizedBox(height: 12),

          ProfileMenuTile(
            icon: Icons.delete_rounded,
            title: "Delete Account",
            iconColor: Colors.redAccent,
            isLogout: true,
            onTap: () async {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                backgroundColor: Colors.transparent,
                builder: (_) {
                  return const FractionallySizedBox(
                    heightFactor: .92,
                    child: DeleteAccountView(),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 30),

          Texts(
            "Version 1.0.0",
            color: Colors.white.withValues(alpha: .35),
            fontSize: 12,
          ),
        ],
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
