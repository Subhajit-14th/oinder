import 'package:flutter/material.dart';
import 'package:oinder/module/chat/model/match_and_message_api_response_model.dart';
import 'package:oinder/module/chat/view/new_match_item.dart';
import 'package:oinder/module/profileDetails/view/profile_details_view.dart';
import 'package:oinder/utils/utils.dart';

class NewMatchList extends StatelessWidget {
  final List<NewMatchModel> matches;

  const NewMatchList({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: matches.length,
      separatorBuilder: (_, __) => const SizedBox(width: 14),
      itemBuilder: (context, index) {
        return Hero(
          tag: "match_${matches[index].name}",
          child: Material(
            color: Colors.transparent,
            child: NewMatchItem(
              match: matches[index],
              onTap: () {
                Navigator.push(
                  context,
                  AppRoutes.slideFromBottom(
                    ProfileDetailsView(userId: "${matches[index].id}"),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
