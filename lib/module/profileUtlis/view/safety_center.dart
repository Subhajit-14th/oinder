import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/profile/provider/profile_provider.dart';
import 'package:oinder/module/profileUtlis/model/safety_action_model.dart';
import 'package:oinder/module/profileUtlis/provider/profile_utils_provider.dart';
import 'package:oinder/module/profileUtlis/view/blocked_user_view.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class SafetyCenter extends ConsumerStatefulWidget {
  const SafetyCenter({super.key});

  @override
  ConsumerState<SafetyCenter> createState() => _SafetyCenterState();
}

class _SafetyCenterState extends ConsumerState<SafetyCenter> {
  bool isProfileHidden = false;
  final List<SafetyAction> actions = [
    SafetyAction(
      title: "Blocked Users",
      subtitle: "Manage blocked profiles",
      icon: Icons.block,
      color: Colors.deepOrange,
    ),
    SafetyAction(
      title: "Privacy",
      subtitle: "Hide my profile",
      icon: Icons.lock,
      color: Colors.blue,
    ),
    SafetyAction(
      title: "Help",
      subtitle: "Contact support anytime",
      icon: Icons.support_agent,
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
      appBar: AppBar(
        backgroundColor: AppColor.bodyColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColor.white),
        ),
        title: const Texts(
          "Safety Center",
          color: AppColor.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: const LinearGradient(
                  colors: [Color(0xff8B5CF6), Color(0xff6D28D9)],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.shield_rounded, color: AppColor.white, size: 35),
                  SizedBox(height: 18),

                  Texts(
                    "Stay Safe While Dating",
                    color: AppColor.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 10),

                  Texts(
                    "Always meet in public places, protect your personal information and report suspicious behaviour immediately.",
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // const Texts(
            //   "Emergency",
            //   color: AppColor.white,
            //   fontSize: 16,
            //   fontWeight: FontWeight.bold,
            // ),
            // const SizedBox(height: 14),

            // Container(
            //   padding: const EdgeInsets.all(18),
            //   decoration: BoxDecoration(
            //     color: const Color(0xff2A2023),
            //     borderRadius: BorderRadius.circular(22),
            //     border: Border.all(
            //       color: Colors.redAccent.withValues(alpha: .35),
            //     ),
            //   ),
            //   child: Row(
            //     children: [
            //       Container(
            //         width: 50,
            //         height: 50,
            //         decoration: const BoxDecoration(
            //           color: Colors.redAccent,
            //           shape: BoxShape.circle,
            //         ),
            //         child: const Icon(
            //           Icons.sos,
            //           color: AppColor.white,
            //           size: 24,
            //         ),
            //       ),
            //       const SizedBox(width: 16),

            //       const Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Texts(
            //               "Emergency SOS",
            //               color: AppColor.white,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //             ),
            //             SizedBox(height: 6),

            //             Texts(
            //               "Quickly contact emergency services if you ever feel unsafe.",
            //               color: Colors.white60,
            //               height: 1.4,
            //             ),
            //           ],
            //         ),
            //       ),

            //       ElevatedButton(
            //         onPressed: () {},
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.redAccent,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(16),
            //           ),
            //         ),
            //         child: const Texts("SOS", color: AppColor.white),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 30),
            const Texts(
              "Privacy & Protection",
              color: AppColor.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),

            _buildHideProfileTile(),
            const SizedBox(height: 30),

            const Texts(
              "Quick Actions",
              color: AppColor.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: actions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: .95,
              ),
              itemBuilder: (context, index) {
                final item = actions[index];
                return InkWell(
                  onTap: () {
                    if (item.title == "Blocked Users") {
                      Navigator.push(
                        context,
                        AppRoutes.slideFromRight(BlockedUsersView()),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xff24262B),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: item.color.withValues(alpha: .15),
                          child: Icon(item.icon, color: item.color),
                        ),
                        const Spacer(),

                        Texts(
                          item.title,
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        const SizedBox(height: 6),

                        Texts(
                          item.subtitle,
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // const Texts(
            //   "Privacy & Protection",
            //   color: AppColor.white,
            //   fontSize: 20,
            //   fontWeight: FontWeight.bold,
            // ),
            // const SizedBox(height: 16),

            // _buildSettingTile(
            //   icon: Icons.visibility_off_rounded,
            //   color: Colors.blue,
            //   title: "Hide My Profile",
            //   subtitle: "Temporarily hide your profile from others.",
            // ),

            // _buildSettingTile(
            //   icon: Icons.location_on_outlined,
            //   color: Colors.green,
            //   title: "Live Location Sharing",
            //   subtitle: "Share your live location with a trusted contact.",
            // ),

            // _buildSettingTile(
            //   icon: Icons.block_rounded,
            //   color: Colors.deepOrange,
            //   title: "Blocked Users",
            //   subtitle: "Manage people you've blocked.",
            // ),

            // _buildSettingTile(
            //   icon: Icons.flag_circle_outlined,
            //   color: Colors.redAccent,
            //   title: "Report & Feedback",
            //   subtitle: "Report fake accounts or inappropriate behaviour.",
            // ),
            // const SizedBox(height: 28),
            const Texts(
              "Safety Tips",
              color: AppColor.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),

            _buildTipCard(
              Icons.public,
              "Meet in Public",
              "Always meet for the first time in a public place.",
            ),
            const SizedBox(height: 14),

            _buildTipCard(
              Icons.lock_outline,
              "Protect Your Information",
              "Avoid sharing your address, passwords or banking details.",
            ),
            const SizedBox(height: 14),

            _buildTipCard(
              Icons.phone_enabled,
              "Tell a Friend",
              "Share your plans with someone you trust before meeting.",
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(IconData icon, String title, String description) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xff24262B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xff8B5CF6).withValues(alpha: .15),
            child: Icon(icon, color: const Color(0xff8B5CF6)),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Texts(
                  title,
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                const SizedBox(height: 6),

                Texts(
                  description,
                  color: Colors.white60,
                  height: 1.5,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHideProfileTile() {
    final profileState = ref.watch(profileProvider);

    return profileState.when(
      loading: () => const SizedBox(
        height: 90,
        child: Center(child: CircularProgressIndicator()),
      ),

      error: (error, stack) => const SizedBox(),

      data: (profile) {
        final isProfileHidden = profile.is_hide ?? false;
        log("My profile visible status is: ${profile.toJson()}");

        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xff24262B),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: .15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.visibility_off_rounded,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(width: 16),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Texts(
                      "Hide My Profile",
                      color: AppColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 6),
                    Texts(
                      "Temporarily hide your profile from other users.",
                      color: Colors.white54,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ],
                ),
              ),

              Switch(
                value: isProfileHidden,
                activeColor: const Color(0xff8B5CF6),
                onChanged: (value) async {
                  try {
                    final response = await ref.read(
                      hideMyProfileProvider(value).future,
                    );

                    if (!mounted) return;

                    if (response.success == true) {
                      log("MY PROFILE HIDE STATUS: ${response.toJson()}");
                      AppSnackbar.showSuccess(response.message);

                      // profile data refresh
                      ref.invalidate(profileProvider);
                    }
                  } catch (e) {
                    if (!mounted) return;

                    AppSnackbar.showError(e.toString());
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
