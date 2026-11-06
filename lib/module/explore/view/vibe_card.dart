import 'package:flutter/material.dart';
import 'package:oinder/module/explore/model/explore_model.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class VibeCard extends StatelessWidget {
  final ExploreModel vibe;
  final VoidCallback? onTap;

  const VibeCard({super.key, required this.vibe, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: vibe.colors,
            ),
          ),
          child: Stack(
            children: [
              ///==============================
              /// Decorative Circle
              ///==============================
              Positioned(
                top: -25,
                right: -25,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                  ),
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.white.withValues(alpha: .08),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: -35,
                left: -35,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.white.withValues(alpha: .05),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///=========================
                    /// ICON
                    ///=========================
                    Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                        color: AppColor.white.withValues(alpha: .18),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.white.withValues(alpha: .20),
                        ),
                      ),
                      child: Icon(vibe.icon, color: AppColor.white, size: 28),
                    ),
                    const Spacer(),

                    ///=========================
                    /// TITLE
                    ///=========================
                    Texts(
                      vibe.title,
                      color: AppColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 8),

                    ///=========================
                    /// SUBTITLE
                    ///=========================
                    Texts(
                      vibe.subtitle,
                      color: AppColor.white.withValues(alpha: .88),
                      fontSize: 12,
                      maxLines: 3,
                      height: 1.35,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
