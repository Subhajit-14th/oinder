import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/likes/provider/likes_provider.dart';
import 'package:oinder/module/likes/view/likes_banner.dart';
import 'package:oinder/module/likes/view/likes_grid.dart';
import 'package:oinder/module/profile/provider/profile_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class LikesView extends ConsumerWidget {
  const LikesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesState = ref.watch(likesProvider);
    final profileState = ref.watch(profileProvider);
    return Scaffold(
      backgroundColor: const Color(0xff1E1E22),
      body: SafeArea(
        child: Column(
          children: [
            ///==========================
            /// HEADER
            ///==========================
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
              child: Row(
                children: [
                  Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xff2F2A38),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.workspace_premium_rounded,
                      color: Color(0xffFFB400),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: likesState.when(
                      data: (response) {
                        return Texts(
                          "Likes You (${response.count})",
                          color: AppColor.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        );
                      },
                      loading: () {
                        return const Texts(
                          "Likes You",
                          color: AppColor.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        );
                      },
                      error: (_, __) {
                        return const Texts(
                          "Likes You",
                          color: AppColor.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        );
                      },
                    ),
                  ),

                  // InkWell(
                  //   borderRadius: BorderRadius.circular(30),
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       AppRoutes.slideFromRight(SubscriptionView()),
                  //     );
                  //   },
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 14,
                  //       vertical: 8,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: const Color(0xff2B2B2F),
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //     child: const Texts(
                  //       "SEE ALL",
                  //       color: Color(0xffFFB400),
                  //       fontSize: 11,
                  //       fontWeight: FontWeight.bold,
                  //       letterSpacing: 1,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            ///==========================
            /// PREMIUM BANNER
            ///==========================
            profileState.when(
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              error: (error, stack) {
                return Center(
                  child: Texts(error.toString(), color: AppColor.white),
                );
              },
              data: (profile) {
                return profile.gender != "Woman"
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: LikesBanner(),
                      )
                    : SizedBox();
              },
            ),
            const SizedBox(height: 18),

            ///==========================
            /// GRID
            ///==========================
            Expanded(
              child: likesState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) {
                  return Center(
                    child: Texts(error.toString(), color: AppColor.white),
                  );
                },
                data: (response) {
                  if (response.users.isEmpty) {
                    return const Center(
                      child: Texts("No Likes Yet", color: AppColor.white),
                    );
                  }

                  // log(
                  //   " *************** My response: ${response.users.map((e) => e.toJson()).toList()}",
                  // );
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: LikesGrid(users: response.users),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
