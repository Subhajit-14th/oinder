import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/profile/provider/profile_provider.dart';
import 'package:oinder/module/profile/view/profile_header.dart';
import 'package:oinder/module/profile/view/profile_menu_section.dart';
import 'package:oinder/module/profile/view/profile_progress_card.dart';
import 'package:oinder/module/profile/view/profile_quick_action_grid.dart';
import 'package:oinder/module/profile/view/profile_subcription_card.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

import '../../../core/services/Hive/hive_database.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    return SafeArea(
      top: true,
      child: profileState.when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stack) {
          return Center(child: Texts(error.toString(), color: AppColor.white));
        },
        data: (profile) {
          log("Profile Data: ${profile.toJson()}");

          Future.microtask(() async {
            await HiveDataBase.saveGender(gender: profile.gender ?? "");
          });

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ProfileHeader(profile: profile),
                ProfileProgressCard(profile: profile),
                if (profile.gender != "Woman") const ProfileSubcriptionCard(),
                const ProfileQuickActionGrid(),
                const ProfileMenuSection(),
              ],
            ),
          );
        },
      ),
    );
  }
}
