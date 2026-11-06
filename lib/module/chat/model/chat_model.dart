class ChatModel {
  final String name;
  final String image;
  final String lastMessage;
  final String time;
  final bool verified;
  final bool unread;
  final bool online;
  final int unreadCount;

  const ChatModel({
    required this.name,
    required this.image,
    required this.lastMessage,
    required this.time,
    this.verified = false,
    this.unread = false,
    this.online = false,
    this.unreadCount = 0,
  });
}
