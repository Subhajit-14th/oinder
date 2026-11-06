import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/explore/provider/explore_provider.dart';
import 'package:oinder/module/explore/view/featured_banner.dart';
import 'package:oinder/module/explore/view/vibe_grid.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class ExploreView extends ConsumerWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discoverByVibeState = ref.watch(discoverByVibeProvider);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///=========================
          /// HEADER
          ///=========================
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
            child: Row(
              children: [
                Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: AppColor.primaryLight.withValues(alpha: .35),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Texts(
                      "O",
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Texts(
                  "Oinder",
                  color: AppColor.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                Texts(
                  " • Explore",
                  color: AppColor.white.withValues(alpha: .80),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),

          ///=========================
          /// FEATURED BANNER
          ///=========================
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 20),
            child: FeaturedBanner(),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Texts(
              "Discover by Vibe",
              color: AppColor.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          ///=========================
          /// GRID
          ///=========================
          Expanded(
            child: discoverByVibeState.when(
              loading: () => const Center(child: CircularProgressIndicator()),

              error: (error, stackTrace) =>
                  Center(child: Texts(error.toString(), color: AppColor.white)),

              data: (response) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: VibeGrid(vibes: response.options),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
