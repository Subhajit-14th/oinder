import 'package:flutter/material.dart';
import 'package:oinder/module/profile/model/get_profile_api_response_model.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class ProfileProgressCard extends StatelessWidget {
  final UserProfileModel profile;

  const ProfileProgressCard({super.key, required this.profile});

  double get progress {
    int completed = 0;
    int total = 10;

    if (profile.name?.isNotEmpty == true) {
      completed++;
    }

    if (profile.email?.isNotEmpty == true) {
      completed++;
    }

    if (profile.gender?.isNotEmpty == true) {
      completed++;
    }

    if (profile.bio?.isNotEmpty == true) {
      completed++;
    }

    if (profile.profilePhoto?.isNotEmpty == true) {
      completed++;
    }

    if (profile.photos?.isNotEmpty == true) {
      completed++;
    }

    if (profile.interests?.isNotEmpty == true) {
      completed++;
    }

    if (profile.relationshipGoals?.isNotEmpty == true) {
      completed++;
    }

    if (profile.educationLevel?.isNotEmpty == true) {
      completed++;
    }

    if (profile.location?.city?.isNotEmpty == true) {
      completed++;
    }

    return completed / total;
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).toInt();
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 28, 18, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xff2A2A2F),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: .18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          ///=========================
          /// TITLE
          ///=========================
          Row(
            children: [
              const Expanded(
                child: Texts(
                  "Profile Completeness",
                  color: AppColor.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Texts(
                "$percentage%",
                color: AppColor.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 18),

          ///=========================
          /// PROGRESS BAR
          ///=========================
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              children: [
                Container(
                  height: 6,
                  color: AppColor.white.withValues(alpha: .08),
                ),

                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOut,
                  tween: Tween(begin: 0, end: progress),
                  builder: (context, value, child) {
                    return FractionallySizedBox(
                      widthFactor: value,
                      child: Container(
                        height: 6,
                        decoration: const BoxDecoration(
                          gradient: AppColor.appGradient,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          ///=========================
          /// FOOTER
          ///=========================
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 15,
                color: AppColor.white.withValues(alpha: .55),
              ),
              const SizedBox(width: 6),

              Expanded(
                child: Texts(
                  "Complete your profile to get more matches.",
                  color: AppColor.white.withValues(alpha: .60),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
