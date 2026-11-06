import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/home/provider/home_provider.dart';
import 'package:oinder/module/profileDetails/model/profile_details_api_response_model.dart';
import 'package:oinder/module/profileDetails/provider/profile_details_provider.dart';
import 'package:oinder/module/profileUtlis/provider/profile_utils_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class ProfileDetailsView extends ConsumerStatefulWidget {
  final String userId;
  const ProfileDetailsView({super.key, required this.userId});

  @override
  ConsumerState<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends ConsumerState<ProfileDetailsView> {
  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileDetailsProvider(widget.userId));
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
      body: profileAsync.when(
        data: (response) {
          final user = response.data;
          final lifestyle = response.data?.lifestyle;

          if (user == null) {
            return const Center(
              child: Texts("Profile not found", color: AppColor.white),
            );
          }
          return Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _headerImage(user),
                        const SizedBox(height: 10),

                        if ((user.communicationStyle ?? '').isNotEmpty)
                          _infoRow(
                            Icons.chat_outlined,
                            user.communicationStyle!,
                          ),
                        const SizedBox(height: 16),

                        if ((user.college ?? '').isNotEmpty)
                          _infoRow(Icons.school_outlined, user.college!),
                        const SizedBox(height: 16),

                        _infoRow(
                          Icons.location_on_outlined,
                          [user.location?.city, user.location?.state]
                                  .where((e) => e != null && e.isNotEmpty)
                                  .join(", ")
                                  .isNotEmpty
                              ? [user.location?.city, user.location?.state]
                                    .where((e) => e != null && e.isNotEmpty)
                                    .join(", ")
                              : "Location not added",
                        ),
                        const SizedBox(height: 26),

                        Container(
                          height: 1,
                          color: AppColor.white.withValues(alpha: .08),
                        ),
                        const SizedBox(height: 30),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: const Texts(
                            "About Me",
                            color: AppColor.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 18),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Texts(
                            user.bio?.isNotEmpty == true
                                ? user.bio!
                                : "No bio added yet.",
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.7,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 30),

                        Container(
                          height: 1,
                          color: AppColor.white.withValues(alpha: .08),
                        ),
                        const SizedBox(height: 28),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: const Texts(
                            "Passions",
                            color: AppColor.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        if (user.interests != null &&
                            user.interests!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: user.interests!
                                  .map((e) => _passionChip(e))
                                  .toList(),
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: const Texts(
                              "No interests added",
                              color: Colors.white54,
                            ),
                          ),
                        const SizedBox(height: 16),

                        // Container(
                        //   height: 1,
                        //   color: AppColor.white.withValues(alpha: .08),
                        // ),
                        // const SizedBox(height: 16),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 24),
                        //   child: const Texts(
                        //     "My Anthem",
                        //     color: AppColor.white,
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // const SizedBox(height: 16),

                        // Container(
                        //   width: double.infinity,
                        //   padding: const EdgeInsets.all(18),
                        //   margin: EdgeInsets.symmetric(horizontal: 24),
                        //   decoration: BoxDecoration(
                        //     color: const Color(0xff1E1F23),
                        //     borderRadius: BorderRadius.circular(22),
                        //     border: Border.all(color: Colors.white10),
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         height: 55,
                        //         width: 55,
                        //         decoration: const BoxDecoration(
                        //           color: Color(0xff22C55E),
                        //           shape: BoxShape.circle,
                        //         ),
                        //         child: const Icon(
                        //           Icons.music_note,
                        //           color: AppColor.white,
                        //           size: 24,
                        //         ),
                        //       ),
                        //       const SizedBox(width: 18),
                        //       const Expanded(
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Texts(
                        //               "Midnight City",
                        //               color: AppColor.white,
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //             SizedBox(height: 6),
                        //             Texts(
                        //               "M83",
                        //               color: Colors.white54,
                        //               fontSize: 12,
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(height: 16),
                        Container(
                          height: 1,
                          color: AppColor.white.withValues(alpha: .08),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: const Text(
                            "Basics & Lifestyle",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        if (lifestyle?.drinking?.isNotEmpty == true)
                          _lifestyleRow(
                            Icons.local_bar_outlined,
                            "Drinking",
                            lifestyle?.drinking ?? '',
                          ),

                        if (lifestyle?.smoking?.isNotEmpty == true)
                          _lifestyleRow(
                            Icons.smoke_free_outlined,
                            "Smoking",
                            lifestyle?.smoking ?? '',
                          ),

                        if (lifestyle?.workout?.isNotEmpty == true)
                          _lifestyleRow(
                            Icons.fitness_center,
                            "Workout",
                            lifestyle?.workout ?? '',
                          ),

                        if (lifestyle?.pets?.isNotEmpty == true)
                          _lifestyleRow(
                            Icons.pets,
                            "Pets",
                            lifestyle?.pets?.join(", ") ?? '',
                          ),
                        const SizedBox(height: 16),

                        if (user.photos != null && user.photos!.isNotEmpty) ...[
                          SizedBox(
                            height: 400,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: user.photos!.length,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              itemBuilder: (context, index) {
                                final image = user.photos![index];

                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: index == user.photos!.length - 1
                                        ? 0
                                        : 14,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(28),
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width -
                                          48,
                                      height: 400,
                                      child: CachedNetworkImage(
                                        imageUrl: image,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                              child: Icon(
                                                Icons.broken_image_outlined,
                                                color: Colors.grey,
                                                size: 50,
                                              ),
                                            ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                        ],

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          height: 45,
                          child: AppButton(
                            text: "Block User",
                            backgroundColor: Colors.redAccent,
                            onTap: () async {
                              try {
                                final response = await ref.read(
                                  postBlockedUserProvider(widget.userId).future,
                                );
                                if (!mounted) return;
                                if (response.success == true) {
                                  AppSnackbar.showSuccess(response.message);
                                  Navigator.pop(context);
                                  ref
                                      .read(homeProfilesProvider.notifier)
                                      .removeTopCard();
                                }
                              } catch (e) {
                                if (!mounted) return;
                                AppSnackbar.showError(e.toString());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Positioned(
                right: 18,
                top: MediaQuery.of(context).padding.top + 10,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: AppColor.white),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stack) {
          return Center(child: Texts(error.toString(), color: AppColor.white));
        },
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _headerImage(ProfileDetailsModel user) {
    log("My user profile photo: ${user.toJson()}");
    return Stack(
      children: [
        SizedBox(
          height: 720,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl:
                (user.profilePhoto != null && user.profilePhoto!.isNotEmpty)
                ? user.profilePhoto!
                : "https://i.pravatar.cc/500?img=12",
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => CachedNetworkImage(
              imageUrl: "https://i.pravatar.cc/500?img=5",
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.person, size: 80, color: Colors.grey),
            ),
          ),
        ),

        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.transparent,
                  AppColor.transparent,
                  AppColor.bodyColor,
                ],
              ),
            ),
          ),
        ),

        Positioned(
          left: 24,
          right: 24,
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Texts(
                      user.name ?? '',
                      color: AppColor.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),

                  if (user.age != null) ...[
                    const SizedBox(width: 10),
                    Texts(
                      "${user.age}",
                      color: Colors.grey.shade300,
                      fontSize: 24,
                    ),
                  ],
                  const SizedBox(width: 10),

                  if (user.isVerified == true)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xffC8A2FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColor.white,
                        size: 14,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color(0xffC8A2FF)),
                ),
                child: Texts(
                  responseMatchText(user),
                  color: Color(0xffD8BCFF),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xffC8A2FF)),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Looking for : ",
                        style: Styles.textStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text:
                            user.relationshipGoals != null &&
                                user.relationshipGoals!.isNotEmpty
                            ? user.relationshipGoals!
                            : "Not specified",
                        style: Styles.textStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String responseMatchText(ProfileDetailsModel user) {
    return "${user.matchPercentage ?? 0}% Match";
  }

  Widget _bottomBar() {
    return SafeArea(
      child: Container(
        height: 92,
        decoration: const BoxDecoration(color: Color(0xff26262A)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _circleButton(
              Icons.close,
              AppColor.white,
              const Color(0xff36363B),
              () => Navigator.pop(context),
            ),
            _circleButton(
              Icons.star,
              AppColor.white,
              const Color(0xff36363B),
              () async {
                try {
                  final response = await ref.read(
                    userSuperLikeProfileProvider(widget.userId).future,
                  );

                  if (!mounted) return;

                  if (response.success == true) {
                    AppSnackbar.showSuccess("Super Like sent successfully");
                    Navigator.pop(context, true);
                    ref.read(homeProfilesProvider.notifier).removeTopCard();
                  }
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
            ),
            _circleButton(
              Icons.favorite,
              AppColor.white,
              const Color(0xffC8A2FF),
              () async {
                try {
                  final response = await ref.read(
                    getUsersMatchProfileProvider(widget.userId).future,
                  );

                  if (!mounted) return;

                  if (response.success == true) {
                    AppSnackbar.showSuccess("Like sent successfully");
                    Navigator.pop(context);
                    ref.read(homeProfilesProvider.notifier).removeTopCard();
                  }
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(
    IconData icon,
    Color iconColor,
    Color bgColor,
    Function()? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }

  Widget _infoRow(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Icon(icon, color: Colors.white54, size: 18),
          const SizedBox(width: 14),
          Expanded(
            child: Texts(
              title,
              color: Colors.white70,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _passionChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xff1F2024),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Texts(
        text,
        color: AppColor.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _lifestyleRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.white54),
          const SizedBox(width: 14),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$title: ",
                    style: Styles.textStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: Styles.textStyle(
                      color: AppColor.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
