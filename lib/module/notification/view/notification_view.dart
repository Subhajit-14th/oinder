import 'package:flutter/material.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final List<NotificationModel> notifications = [
    NotificationModel(
      name: "Aditi",
      message: "liked your profile ❤️",
      time: "2 min ago",
      image:
          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=500",
      type: NotificationType.like,
      section: "Today",
      isRead: false,
    ),
    NotificationModel(
      name: "Sophia",
      message: "It's a Match! 🎉",
      time: "18 min ago",
      image:
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500",
      type: NotificationType.match,
      section: "Today",
      isRead: false,
    ),
    NotificationModel(
      name: "Emma",
      message: "sent you a message 💬",
      time: "Yesterday",
      image: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500",
      type: NotificationType.message,
      section: "Yesterday",
      isRead: true,
    ),
    NotificationModel(
      name: "Olivia",
      message: "viewed your profile 👀",
      time: "Yesterday",
      image:
          "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=500",
      type: NotificationType.view,
      section: "Yesterday",
      isRead: true,
    ),
    NotificationModel(
      name: "Charlotte",
      message: "Super Liked you ⭐",
      time: "3 days ago",
      image:
          "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=500",
      type: NotificationType.superLike,
      section: "This Week",
      isRead: true,
    ),
  ];

  Future<void> _refreshNotifications() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  void _markAllAsRead() {
    setState(() {
      for (int i = 0; i < notifications.length; i++) {
        notifications[i] = NotificationModel(
          name: notifications[i].name,
          message: notifications[i].message,
          time: notifications[i].time,
          image: notifications[i].image,
          section: notifications[i].section,
          type: notifications[i].type,
          isRead: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentSection = "";
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
      appBar: AppBar(
        backgroundColor: const Color(0xff18191D),
        elevation: 0,
        centerTitle: true,
        title: const Texts(
          "Notifications",
          color: AppColor.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColor.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: const Texts(
              "Read All",
              color: Color(0xffD7BBFF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNotifications,
        child: notifications.isEmpty
            ? const _EmptyNotification()
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];

                  bool showHeader = currentSection != notification.section;

                  if (showHeader) {
                    currentSection = notification.section;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showHeader)
                        Padding(
                          padding: const EdgeInsets.only(top: 14, bottom: 14),
                          child: Texts(
                            notification.section,
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),

                      /// Part-2 এ এখানে Notification Card আসবে
                      Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        child: Texts(notification.name, color: AppColor.white),
                      ),

                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: notification.isRead
                              ? const Color(0xff24262B)
                              : const Color(0xff2D2438),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: notification.isRead
                                ? Colors.white10
                                : const Color(
                                    0xffD7BBFF,
                                  ).withValues(alpha: .35),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    notification.image,
                                  ),
                                ),

                                Positioned(
                                  right: -2,
                                  bottom: -2,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: _iconBackground(notification.type),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xff18191D),
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      _notificationIcon(notification.type),
                                      color: AppColor.white,
                                      size: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: notification.name,
                                          style: Styles.textStyle(
                                            color: AppColor.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " ${notification.message}",
                                          style: Styles.textStyle(
                                            color: Colors.white70,
                                            fontSize: 15,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  Texts(
                                    notification.time,
                                    color: Colors.white38,
                                    fontSize: 13,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!notification.isRead)
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffD7BBFF),
                                      shape: BoxShape.circle,
                                    ),
                                  ),

                                const SizedBox(height: 14),

                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.white24,
                                  size: 24,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }

  IconData _notificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.like:
        return Icons.favorite;

      case NotificationType.match:
        return Icons.favorite_rounded;

      case NotificationType.message:
        return Icons.chat_bubble;

      case NotificationType.view:
        return Icons.remove_red_eye;

      case NotificationType.superLike:
        return Icons.star;
    }
  }

  Color _iconBackground(NotificationType type) {
    switch (type) {
      case NotificationType.like:
        return Colors.redAccent;

      case NotificationType.match:
        return const Color(0xffD7BBFF);

      case NotificationType.message:
        return Colors.blueAccent;

      case NotificationType.view:
        return Colors.orange;

      case NotificationType.superLike:
        return Colors.amber;
    }
  }
}

enum NotificationType { like, match, message, view, superLike }

class NotificationModel {
  final String name;
  final String message;
  final String time;
  final String image;
  final String section;
  final NotificationType type;
  final bool isRead;

  NotificationModel({
    required this.name,
    required this.message,
    required this.time,
    required this.image,
    required this.section,
    required this.type,
    required this.isRead,
  });
}

class _EmptyNotification extends StatelessWidget {
  const _EmptyNotification();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.notifications_off_outlined,
            color: Colors.white24,
            size: 90,
          ),
          SizedBox(height: 18),
          Text(
            "No Notifications Yet",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "We'll notify you when something happens.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }
}
