import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/bottomNavigation/provider/bottom_navigation_provider.dart';
import 'package:oinder/module/chat/view/chat_view.dart';
import 'package:oinder/module/explore/view/explore_view.dart';
import 'package:oinder/module/home/view/home_view.dart';
import 'package:oinder/module/likes/provider/likes_provider.dart';
import 'package:oinder/module/likes/view/likes_view.dart';
import 'package:oinder/module/profile/view/profile_view.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class BottomNavigationBarView extends ConsumerWidget {
  const BottomNavigationBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationProvider);
    final likesCount = ref
        .watch(likesProvider)
        .maybeWhen(data: (response) => response.count, orElse: () => 0);
    final pages = [
      const HomeView(),
      const ExploreView(),
      const LikesView(),
      const ChatView(),
      const ProfileView(),
    ];
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
      body: pages[selectedIndex],
      bottomNavigationBar: SafeArea(
        // minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xff322E3B),
            // borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: AppColor.black.withValues(alpha: .18),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              _item(ref, index: 0, icon: Icons.local_fire_department_rounded),
              _item(ref, index: 1, icon: Icons.explore_rounded),
              _item(
                ref,
                index: 2,
                icon: Icons.favorite_rounded,
                badge: likesCount > 0 ? likesCount.toString() : null,
              ),
              _item(ref, index: 3, icon: Icons.chat_bubble_rounded, badge: "1"),
              _item(ref, index: 4, icon: Icons.person_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(
    WidgetRef ref, {
    required int index,
    required IconData icon,
    String? badge,
  }) {
    final selected = ref.watch(bottomNavigationProvider) == index;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          ref.read(bottomNavigationProvider.notifier).state = index;
        },
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.fastOutSlowIn,
              height: 46,
              width: selected ? 62 : 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: selected ? AppColor.primaryGradient : null,
                color: selected ? null : AppColor.transparent,
              ),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 250),
                scale: selected ? 1.1 : 1,
                child: Icon(
                  icon,
                  size: selected ? 26 : 23,
                  color: selected
                      ? AppColor.white
                      : AppColor.white.withValues(alpha: .60),
                ),
              ),
            ),
            if (badge != null)
              Positioned(
                top: 12,
                right: 18,
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 18,
                    minWidth: 18,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xffFFB000),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xff322E3B),
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Texts(
                    badge,
                    color: AppColor.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
