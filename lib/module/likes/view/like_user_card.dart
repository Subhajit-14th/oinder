import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/likes/model/like_user_model.dart';
import 'package:oinder/module/likes/provider/likes_provider.dart';
import 'package:oinder/module/profile/provider/profile_provider.dart';
import 'package:oinder/module/profileDetails/view/profile_details_view.dart';
import 'package:oinder/module/subscription/view/subscription_view.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class LikeUserCard extends ConsumerWidget {
  final LikeUserModel user;

  const LikeUserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    return profileState.when(
      data: (profile) {
        final bool showLock = profile.gender != "Woman";
        return InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () async {
            if (showLock) {
              Navigator.push(
                context,
                AppRoutes.slideFromRight(SubscriptionView()),
              );
            } else {
              final result = await Navigator.push(
                context,
                AppRoutes.slideFromRight(ProfileDetailsView(userId: user.id)),
              );

              if (result == true) {
                ref.invalidate(likesProvider);
              }
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ///========================
                /// IMAGE
                ///========================
                CachedNetworkImage(
                  imageUrl: user.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.broken_image_rounded,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                ),

                ///========================
                /// BLUR
                ///========================
                if (showLock) ...[
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      color: AppColor.black.withValues(alpha: .10),
                    ),
                  ),

                  ///========================
                  /// DARK OVERLAY
                  ///========================
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.black.withValues(alpha: .10),
                          AppColor.black.withValues(alpha: .20),
                          AppColor.black.withValues(alpha: .70),
                        ],
                      ),
                    ),
                  ),

                  ///========================
                  /// LOCK BUTTON
                  ///========================
                  Center(
                    child: Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: AppColor.black.withValues(alpha: .35),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_rounded,
                        color: Color(0xffFFD54F),
                        size: 28,
                      ),
                    ),
                  ),
                ],

                ///========================
                /// USER INFO
                ///========================
                Positioned(
                  left: 14,
                  right: 14,
                  bottom: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if ((user.age <= 0) &&
                          (user.location.trim().isEmpty ||
                              user.location.trim().toLowerCase() == "unknown"))
                        Texts(
                          user.name,
                          color: AppColor.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )
                      else
                        Texts(
                          "${user.age} • ${user.location}",
                          color: AppColor.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      const SizedBox(height: 6),

                      if (user.distance > 0)
                        Texts(
                          "${user.distance.toInt()} km away",
                          color: AppColor.white.withValues(alpha: .80),
                          fontSize: 13,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stack) {
        return Center(child: Texts(error.toString(), color: AppColor.white));
      },
    );
  }
}
