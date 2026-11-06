import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/bottomNavigation/provider/bottom_navigation_provider.dart';
import 'package:oinder/module/explore/model/discory_by_vibe_api_response_model.dart';
import 'package:oinder/module/explore/model/explore_model.dart';
import 'package:oinder/module/explore/view/vibe_card.dart';
import 'package:oinder/module/preferences/provider/preferences_provider.dart';
import 'package:oinder/utils/utils.dart';

class VibeGrid extends ConsumerWidget {
  final List<LookingForOption> vibes;

  const VibeGrid({super.key, required this.vibes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 25),
      itemCount: vibes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: .85,
      ),
      itemBuilder: (context, index) {
        final item = vibes[index];

        final exploreModel = ExploreModel(
          title: item.label,
          subtitle: "",
          icon: _getIcon(item.label),
          colors: _getColors(item.label),
        );

        return Hero(
          tag: item.id,
          child: Material(
            color: AppColor.transparent,
            child: VibeCard(
              vibe: exploreModel,
              onTap: () async {
                ref.read(bottomNavigationProvider.notifier).state = 0;

                final payload = {"lookingFor": item.label};

                log("Preference Payload: $payload");

                await ref
                    .read(postPreferencesProvider.notifier)
                    .submitPreferences(answers: payload);
              },
            ),
          ),
        );
      },
    );
  }

  IconData _getIcon(String label) {
    switch (label) {
      case "Long-term partner":
        return Icons.favorite_rounded;

      case "Long-term, open to short":
        return Icons.favorite_border_rounded;

      case "Short-term, open to long":
        return Icons.local_fire_department_rounded;

      case "Short-term fun":
        return Icons.celebration_rounded;

      case "New friends":
        return Icons.people_alt_rounded;

      case "Still figuring it out":
        return Icons.explore_rounded;

      default:
        return Icons.favorite_rounded;
    }
  }

  List<Color> _getColors(String label) {
    switch (label) {
      case "Long-term partner":
        return const [Color(0xffFF4B6E), Color(0xffFF3D57), Color(0xffFF6138)];

      case "Long-term, open to short":
        return const [Color(0xffF06292), Color(0xffEC407A), Color(0xffD81B60)];

      case "Short-term, open to long":
        return const [Color(0xff8E24AA), Color(0xffAB47BC), Color(0xffCE93D8)];

      case "Short-term fun":
        return const [Color(0xff6A2C91), Color(0xffF43F73), Color(0xffFF7A45)];

      case "New friends":
        return const [Color(0xff0093E9), Color(0xff36CFC9), Color(0xff80D0C7)];

      case "Still figuring it out":
        return const [Color(0xff3B5998), Color(0xff4F6DB8), Color(0xff243B6B)];

      default:
        return const [Color(0xffFF4B6E), Color(0xffFF3D57), Color(0xffFF6138)];
    }
  }
}
