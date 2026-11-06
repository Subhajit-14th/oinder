import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oinder/module/home/model/home_profile_model.dart';
import 'package:oinder/module/profileDetails/view/profile_details_view.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class ProfileCard extends StatelessWidget {
  final HomeProfileModel profile;

  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: .25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ///==========================
            /// IMAGE
            ///==========================
            CachedNetworkImage(
              imageUrl: profile.image,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: Colors.grey.shade300),
              errorWidget: (_, __, ___) => Container(
                color: Colors.grey.shade300,
                child: const Icon(Icons.person, size: 80),
              ),
            ),

            ///==========================
            /// GRADIENT OVERLAY
            ///==========================
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Color.fromRGBO(0, 0, 0, .20),
                    Color.fromRGBO(0, 0, 0, .85),
                  ],
                  stops: [.0, .45, .70, 1],
                ),
              ),
            ),

            ///==========================
            /// MATCH %
            ///==========================
            Positioned(
              top: 18,
              left: 18,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, size: 15, color: Colors.red),
                    const SizedBox(width: 6),
                    Texts(
                      "${profile.match}% Match",
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ],
                ),
              ),
            ),

            ///==========================
            /// STATUS CHIP
            ///==========================
            Positioned(
              top: 18,
              right: 18,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .18),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .25),
                  ),
                ),
                child: const Row(
                  children: [
                    Text("🥂", style: TextStyle(fontSize: 13)),
                    SizedBox(width: 5),
                    Texts(
                      "Short-term",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ],
                ),
              ),
            ),

            ///==========================
            /// BOTTOM INFO
            ///==========================
            Positioned(
              left: 22,
              right: 22,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Name
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Texts(
                                "${profile.name}, ${profile.age}",
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            if (profile.isVerified) ...[
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.verified,
                                color: Color(0xff3BA4FF),
                                size: 22,
                              ),
                            ],
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            AppRoutes.slideFromBottom(
                              ProfileDetailsView(userId: profile.id),
                            ),
                          );
                        },
                        child: Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Profession
                  Row(
                    children: [
                      const Icon(
                        Icons.work_outline,
                        size: 18,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Texts(
                          profile.profession,
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  /// Distance
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 6),
                      Texts(
                        profile.distance,
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Texts(
                    "About",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 8),

                  Texts(
                    profile.bio,
                    color: Colors.white.withValues(alpha: .85),
                    fontSize: 14,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
