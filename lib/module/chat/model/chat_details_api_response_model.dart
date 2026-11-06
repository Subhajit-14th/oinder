class ThreadMessagesResponse {
  final bool? success;
  final String? message;
  final String? threadId;
  final int? compatibility;
  final String? status;
  final bool? hasFlaggedContent;
  final int? unreadCount;
  final int? messagesCount;
  final DateTime? lastMessageAt;
  final DateTime? createdAt;
  final ThreadUser? user1;
  final ThreadUser? user2;
  final CometChatData? cometChat;
  final List<ThreadMessage>? messages;

  ThreadMessagesResponse({
    this.success,
    this.message,
    this.threadId,
    this.compatibility,
    this.status,
    this.hasFlaggedContent,
    this.unreadCount,
    this.messagesCount,
    this.lastMessageAt,
    this.createdAt,
    this.user1,
    this.user2,
    this.cometChat,
    this.messages,
  });

  factory ThreadMessagesResponse.fromJson(Map<String, dynamic> json) {
    return ThreadMessagesResponse(
      success: json['success'],
      message: json['message'],
      threadId: json['threadId'],
      compatibility: json['compatibility'],
      status: json['status'],
      hasFlaggedContent: json['hasFlaggedContent'],
      unreadCount: json['unreadCount'],
      messagesCount: json['messagesCount'],
      lastMessageAt: json['lastMessageAt'] != null
          ? DateTime.tryParse(json['lastMessageAt'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      user1: json['user1'] != null ? ThreadUser.fromJson(json['user1']) : null,
      user2: json['user2'] != null ? ThreadUser.fromJson(json['user2']) : null,
      cometChat: json['cometChat'] != null
          ? CometChatData.fromJson(json['cometChat'])
          : null,
      messages: json['messages'] != null
          ? List<ThreadMessage>.from(
              json['messages'].map((x) => ThreadMessage.fromJson(x)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "threadId": threadId,
      "compatibility": compatibility,
      "status": status,
      "hasFlaggedContent": hasFlaggedContent,
      "unreadCount": unreadCount,
      "messagesCount": messagesCount,
      "lastMessageAt": lastMessageAt?.toIso8601String(),
      "createdAt": createdAt?.toIso8601String(),
      "user1": user1?.toJson(),
      "user2": user2?.toJson(),
      "cometChat": cometChat?.toJson(),
      "messages": messages?.map((e) => e.toJson()).toList(),
    };
  }
}

class ThreadUser {
  final String? id;
  final String? uid;
  final String? name;
  final String? photo;
  final int? age;
  final String? gender;
  final String? city;

  ThreadUser({
    this.id,
    this.uid,
    this.name,
    this.photo,
    this.age,
    this.gender,
    this.city,
  });

  factory ThreadUser.fromJson(Map<String, dynamic> json) {
    return ThreadUser(
      id: json['id'],
      uid: json['uid'],
      name: json['name'],
      photo: json['photo'],
      age: json['age'],
      gender: json['gender'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uid": uid,
      "name": name,
      "photo": photo,
      "age": age,
      "gender": gender,
      "city": city,
    };
  }
}

class CometChatData {
  final String? appId;
  final String? senderUid;
  final String? receiverUid;

  CometChatData({this.appId, this.senderUid, this.receiverUid});

  factory CometChatData.fromJson(Map<String, dynamic> json) {
    return CometChatData(
      appId: json['appId'],
      senderUid: json['senderUid'],
      receiverUid: json['receiverUid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"appId": appId, "senderUid": senderUid, "receiverUid": receiverUid};
  }
}

class ThreadMessage {
  final String? id;
  final String? senderId;
  final String? senderName;
  final String? senderPhoto;
  final String? text;
  final bool? isFlagged;
  final String? flagReason;
  final bool? isSystemNotice;
  final bool? read;
  final DateTime? timestamp;
  final String? timeAgo;
  final bool? isMe;

  ThreadMessage({
    this.id,
    this.senderId,
    this.senderName,
    this.senderPhoto,
    this.text,
    this.isFlagged,
    this.flagReason,
    this.isSystemNotice,
    this.read,
    this.timestamp,
    this.timeAgo,
    this.isMe,
  });

  factory ThreadMessage.fromJson(Map<String, dynamic> json) {
    return ThreadMessage(
      id: json['_id'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      senderPhoto: json['senderPhoto'],
      text: json['text'],
      isFlagged: json['isFlagged'],
      flagReason: json['flagReason'],
      isSystemNotice: json['isSystemNotice'],
      read: json['read'],
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'])
          : null,
      timeAgo: json['timeAgo'],
      isMe: json['isMe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "senderId": senderId,
      "senderName": senderName,
      "senderPhoto": senderPhoto,
      "text": text,
      "isFlagged": isFlagged,
      "flagReason": flagReason,
      "isSystemNotice": isSystemNotice,
      "read": read,
      "timestamp": timestamp?.toIso8601String(),
      "timeAgo": timeAgo,
      "isMe": isMe,
    };
  }
}
