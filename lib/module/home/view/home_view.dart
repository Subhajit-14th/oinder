import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/services/locationUpdate/provider/update_location_provider.dart';
import 'package:oinder/module/home/model/home_profile_model.dart';
import 'package:oinder/module/home/provider/home_provider.dart';
import 'package:oinder/module/home/view/home_action_buttons.dart';
import 'package:oinder/module/home/view/home_app_bar.dart';
import 'package:oinder/module/home/view/home_its_match_page.dart';
import 'package:oinder/module/home/view/home_profile_card.dart';
import 'package:oinder/module/home/view/premium_deals_card.dart';
import 'package:oinder/module/home/view/swipeable_profile_card.dart';
import 'package:oinder/module/preferences/provider/preferences_provider.dart';
import 'package:oinder/module/profile/provider/profile_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  double swipeProgress = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listenManual(getPreferencesAnswersProvider, (previous, next) {
        if (next.hasValue) {
          ref.read(homeProfilesProvider.notifier).getUsers();
        }
      });

      ref.read(locationUpdateProvider.notifier).updateLocation(context);

      ref.read(homeProfilesProvider.notifier).getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profiles = ref.watch(homeProfilesProvider);
    final profileState = ref.watch(profileProvider);
    final isLoading = ref.watch(homeLoadingProvider);
    return SafeArea(
      top: true,
      child: Column(
        children: [
          ///=========================
          /// APP BAR
          ///=========================
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 12, 18, 10),
            child: HomeAppBar(),
          ),

          ///=========================
          /// PROFILE CARD
          ///=========================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : profiles.isEmpty
                  ? _emptyView(ref)
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        if (profiles.length > 2)
                          Transform.translate(
                            offset: const Offset(0, 18),
                            child: Transform.scale(
                              scale: .93 + (swipeProgress * .04),
                              child: Opacity(
                                opacity: .35,
                                child: ProfileCard(profile: profiles[2]),
                              ),
                            ),
                          ),

                        if (profiles.length > 1)
                          Transform.translate(
                            offset: const Offset(0, 9),
                            child: Transform.scale(
                              scale: .96 + (swipeProgress * .04),
                              child: Opacity(
                                opacity: .60,
                                child: ProfileCard(profile: profiles[1]),
                              ),
                            ),
                          ),

                        SwipeableProfileCard(
                          key: ValueKey(profiles.first.id),
                          profile: profiles.first,
                          onDragging: (value) {
                            setState(() {
                              swipeProgress = value;
                            });
                          },
                          onSwipeLeft: () {
                            setState(() {
                              swipeProgress = 0;
                            });

                            ref
                                .read(homeProfilesProvider.notifier)
                                .removeTopCard();
                          },
                          onSwipeRight: () {
                            setState(() {
                              swipeProgress = 0;
                            });

                            final profile = profiles.first;

                            ref
                                .read(homeProfilesProvider.notifier)
                                .removeTopCard();

                            openMatchPage(profile);
                          },
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 18),

          ///=========================
          /// ACTION BUTTONS
          ///=========================
          ActionButtons(
            onDislike: () {
              ref.read(homeProfilesProvider.notifier).removeTopCard();
            },
            onLike: () {
              final profile = profiles.first;
              ref.read(homeProfilesProvider.notifier).removeTopCard();
              openMatchPage(profile);
            },
            onSuperLike: () async {
              final profile = profiles.first;
              ref.read(homeProfilesProvider.notifier).removeTopCard();
              try {
                final response = await ref.read(
                  userSuperLikeProfileProvider(profile.id).future,
                );

                if (!mounted) return;

                if (response.success == true) {
                  ref.read(homeProfilesProvider.notifier).removeTopCard();
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            onBoost: () {},
          ),
          const SizedBox(height: 16),

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
                  ? PremiumDealsCard()
                  : SizedBox();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _emptyView(WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            color: AppColor.primaryColor,
            size: 70,
          ),

          const SizedBox(height: 18),

          const Texts(
            "No More Profiles",
            color: AppColor.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),

          const SizedBox(height: 8),

          Texts(
            "You've seen everyone nearby.\nCome back later.",
            textAlign: TextAlign.center,
            color: AppColor.white.withValues(alpha: .70),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {
              ref.read(homeProfilesProvider.notifier).resetCards();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
            ),
            child: const Text("Reload Profiles"),
          ),
        ],
      ),
    );
  }

  Future<void> openMatchPage(HomeProfileModel profile) async {
    try {
      // Like API
      final matchResponse = await ref.read(
        getUsersMatchProfileProvider(profile.id).future,
      );

      if (!mounted) return;

      if (matchResponse.success != true) {
        AppSnackbar.showError(matchResponse.message ?? "Something went wrong");
        return;
      }

      // User didn't like you before → only show snackbar
      if (profile.isLike != true) {
        AppSnackbar.showSuccess(
          matchResponse.message ?? "Profile liked successfully",
        );
        return;
      }

      final cometChatUid = matchResponse.user?.cometchatUserId ?? "";

      if (!mounted) return;

      Navigator.push(
        context,
        AppRoutes.fadePopIn(
          HomeItsMatchPage(profile: profile, cometChatUid: cometChatUid),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showError(e.toString());
    }
  }
}
