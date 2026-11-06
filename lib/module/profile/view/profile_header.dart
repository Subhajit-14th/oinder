import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oinder/module/preferences/view/preference_bottom_sheet.dart';
import 'package:oinder/module/profile/model/get_profile_api_response_model.dart';
import 'package:oinder/module/profile/provider/profile_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key, required this.profile});

  final UserProfileModel profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Column(
        children: [
          ///=================================
          /// APP BAR
          ///=================================
          Row(
            children: [
              Texts(
                "Profile",
                color: AppColor.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 26),

          ///=================================
          /// PROFILE IMAGE
          ///=================================
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  height: 110,
                  width: 110,
                  padding: const EdgeInsets.all(18),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: profile.profilePhoto != null
                        ? Image.network(
                            profile.profilePhoto!,
                            fit: BoxFit.cover,
                            height: 110,
                            width: 110,
                          )
                        : Image.asset(
                            "assets/app_logo/app_logo_transparent.png",
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),

              Positioned(
                bottom: 4,
                right: 2,
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   AppRoutes.slideFromRight(EditProfileView()),
                    // );
                    _pickAndUploadImage(context, ref);
                  },
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xff1E1E22),
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      color: AppColor.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          ///=================================
          /// NAME
          ///=================================
          Texts(
            "${profile.firstName ?? profile.name ?? ""}, ${profile.age ?? ""}",
            color: AppColor.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.work_outline_rounded,
                size: 16,
                color: AppColor.white.withValues(alpha: .55),
              ),
              const SizedBox(width: 6),

              Texts(
                profile.educationLevel ?? "",
                color: AppColor.white.withValues(alpha: .65),
                fontSize: 15,
              ),

              Texts(
                " • ",
                color: AppColor.white.withValues(alpha: .40),
                fontSize: 15,
              ),

              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColor.white.withValues(alpha: .55),
              ),

              const SizedBox(width: 4),

              Texts(
                profile.location?.city?.isNotEmpty == true
                    ? profile.location!.city!
                    : "Location",
                color: AppColor.white.withValues(alpha: .65),
                fontSize: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickAndUploadImage(BuildContext context, WidgetRef ref) async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image == null) {
        return;
      }
      final file = File(image.path);
      final response = await ref.read(updateProfileImageProvider(file).future);
      if (response.success) {
        log("Invalidating profileProvider...");
        ref.invalidate(profileProvider);
        AppSnackbar.showSuccess(response.message);
        log("Profile refresh triggered");
      }
    } catch (e) {
      AppSnackbar.showError(e.toString());
    }
  }

  void showPreferenceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (_) {
        return const FractionallySizedBox(
          heightFactor: .88,
          child: PreferenceBottomSheet(),
        );
      },
    );
  }
}
