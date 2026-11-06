import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/profileUtlis/provider/profile_utils_provider.dart';
import 'package:oinder/utils/app_color.dart';
import 'package:oinder/widget/widget.dart';

class BlockedUsersView extends ConsumerWidget {
  const BlockedUsersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockedUsersAsync = ref.watch(getBlockedUsersProvider);

    return Scaffold(
      backgroundColor: AppColor.bodyColor,
      appBar: AppBar(
        backgroundColor: AppColor.bodyColor,
        title: const Texts(
          "Blocked Users",
          color: AppColor.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColor.white),
      ),
      body: blockedUsersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
        data: (response) {
          final users = response.blockedUsers;

          if (users.isEmpty) {
            return const Center(
              child: Texts("No blocked users found", fontSize: 16),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: const Color(0xff24262B),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: user.profilePhoto,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SizedBox(
                            width: 70,
                            height: 70,
                            child: Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (_, __, ___) => Container(
                            width: 70,
                            height: 70,
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.person,
                              size: 35,
                              color: AppColor.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Texts(
                              "${user.name}, ${user.age}",
                              color: AppColor.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                            const SizedBox(height: 4),

                            Texts(
                              "${user.city}, ${user.country}",
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(height: 6),

                            Texts(
                              user.relationshipGoals,
                              color: Colors.grey.shade600,
                            ),

                            if (user.bio.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Texts(
                                user.bio,
                                color: AppColor.white,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          if (user.isVerified)
                            const Icon(
                              Icons.verified,
                              color: AppColor.primaryColor,
                            ),

                          const SizedBox(height: 10),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.red.withValues(alpha: .1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Texts(
                              "Blocked",
                              color: AppColor.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
