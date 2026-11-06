import 'package:flutter/material.dart';
import 'package:oinder/module/likes/model/like_user_model.dart';
import 'package:oinder/module/likes/model/likes_you_api_response_model.dart';
import 'package:oinder/module/likes/view/like_user_card.dart';

class LikesGrid extends StatelessWidget {
  final List<LikeUser> users;
  const LikesGrid({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 25),
      itemCount: users.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: .72,
      ),
      itemBuilder: (context, index) {
        final apiUser = users[index];
        final user = LikeUserModel(
          id: apiUser.id,
          name: apiUser.firstName.isNotEmpty ? apiUser.firstName : apiUser.name,
          age: apiUser.age ?? 0,
          location: apiUser.location?.city.isNotEmpty == true
              ? apiUser.location!.city
              : "Unknown",
          distance: 0,
          image: apiUser.profilePhoto.isNotEmpty
              ? apiUser.profilePhoto
              : "assets/app_logo/app_logo_transparent.png",
          isLocked: true,
          gradient: const [Color(0xff8E5A3C), Color(0xff44332B)],
        );
        return Hero(
          tag: "like_${user.name}",
          child: Material(
            color: Colors.transparent,
            child: LikeUserCard(user: user),
          ),
        );
      },
    );
  }
}
