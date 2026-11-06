class ChatMatchesMessagesResponseModel {
  final bool? success;
  final CurrentUserModel? currentUser;
  final CometChatConfigModel? cometChat;
  final int? newMatchesCount;
  final List<NewMatchModel>? newMatches;
  final int? messagesCount;
  final List<ChatMessageItemModel>? messages;

  const ChatMatchesMessagesResponseModel({
    this.success,
    this.currentUser,
    this.cometChat,
    this.newMatchesCount,
    this.newMatches,
    this.messagesCount,
    this.messages,
  });

  factory ChatMatchesMessagesResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatMatchesMessagesResponseModel(
      success: json['success'] as bool?,
      currentUser: json['currentUser'] != null
          ? CurrentUserModel.fromJson(json['currentUser'])
          : null,
      cometChat: json['cometChat'] != null
          ? CometChatConfigModel.fromJson(json['cometChat'])
          : null,
      newMatchesCount: json['newMatchesCount'] as int?,
      newMatches: (json['newMatches'] as List?)
          ?.map((e) => NewMatchModel.fromJson(e))
          .toList(),
      messagesCount: json['messagesCount'] as int?,
      messages: (json['messages'] as List?)
          ?.map((e) => ChatMessageItemModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "currentUser": currentUser?.toJson(),
      "cometChat": cometChat?.toJson(),
      "newMatchesCount": newMatchesCount,
      "newMatches": newMatches?.map((e) => e.toJson()).toList(),
      "messagesCount": messagesCount,
      "messages": messages?.map((e) => e.toJson()).toList(),
    };
  }
}

class CurrentUserModel {
  final String? id;
  final String? uid;
  final String? cometchatUserId;
  final String? name;
  final String? profilePhoto;

  const CurrentUserModel({
    this.id,
    this.uid,
    this.cometchatUserId,
    this.name,
    this.profilePhoto,
  });

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
      id: json['_id'] as String?,
      uid: json['uid'] as String?,
      cometchatUserId: json['cometchat_user_id'] as String?,
      name: json['name'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "uid": uid,
      "cometchat_user_id": cometchatUserId,
      "name": name,
      "profilePhoto": profilePhoto,
    };
  }
}

class CometChatConfigModel {
  final String? appId;
  final String? region;
  final String? authKey;
  final String? apiKey;
  final String? baseUrl;

  const CometChatConfigModel({
    this.appId,
    this.region,
    this.authKey,
    this.apiKey,
    this.baseUrl,
  });

  factory CometChatConfigModel.fromJson(Map<String, dynamic> json) {
    return CometChatConfigModel(
      appId: json['appId'] as String?,
      region: json['region'] as String?,
      authKey: json['authKey'] as String?,
      apiKey: json['apiKey'] as String?,
      baseUrl: json['baseUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "appId": appId,
      "region": region,
      "authKey": authKey,
      "apiKey": apiKey,
      "baseUrl": baseUrl,
    };
  }
}

class NewMatchModel {
  final String? id;
  final String? uid;
  final String? cometchatUserId;
  final String? name;
  final String? profilePhoto;
  final int? age;
  final String? gender;
  final String? city;
  final bool? isVerified;
  final bool? isOnline;
  final String? onlineStatus;
  final String? lastActiveAt;
  final String? lastActiveText;
  final String? bio;

  const NewMatchModel({
    this.id,
    this.uid,
    this.cometchatUserId,
    this.name,
    this.profilePhoto,
    this.age,
    this.gender,
    this.city,
    this.isVerified,
    this.isOnline,
    this.onlineStatus,
    this.lastActiveAt,
    this.lastActiveText,
    this.bio,
  });

  factory NewMatchModel.fromJson(Map<String, dynamic> json) {
    return NewMatchModel(
      id: json['_id'] as String?,
      uid: json['uid'] as String?,
      cometchatUserId: json['cometchat_user_id'] as String?,
      name: json['name'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      city: json['city'] as String?,
      isVerified: json['isVerified'] as bool?,
      isOnline: json['isOnline'] as bool?,
      onlineStatus: json['onlineStatus'] as String?,
      lastActiveAt: json['lastActiveAt'] as String?,
      lastActiveText: json['lastActiveText'] as String?,
      bio: json['bio'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "uid": uid,
      "cometchat_user_id": cometchatUserId,
      "name": name,
      "profilePhoto": profilePhoto,
      "age": age,
      "gender": gender,
      "city": city,
      "isVerified": isVerified,
      "isOnline": isOnline,
      "onlineStatus": onlineStatus,
      "lastActiveAt": lastActiveAt,
      "lastActiveText": lastActiveText,
      "bio": bio,
    };
  }
}

class ChatMessageItemModel {
  final String? threadId;
  final ChatPartnerModel? partner;
  final LastMessageModel? lastMessage;
  final int? unreadCount;
  final bool? hasUnread;
  final int? compatibility;
  final String? status;
  final String? lastMessageAt;

  const ChatMessageItemModel({
    this.threadId,
    this.partner,
    this.lastMessage,
    this.unreadCount,
    this.hasUnread,
    this.compatibility,
    this.status,
    this.lastMessageAt,
  });

  factory ChatMessageItemModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageItemModel(
      threadId: json['threadId'] as String?,
      partner: json['partner'] != null
          ? ChatPartnerModel.fromJson(json['partner'])
          : null,
      lastMessage: json['lastMessage'] != null
          ? LastMessageModel.fromJson(json['lastMessage'])
          : null,
      unreadCount: json['unreadCount'] as int?,
      hasUnread: json['hasUnread'] as bool?,
      compatibility: json['compatibility'] as int?,
      status: json['status'] as String?,
      lastMessageAt: json['lastMessageAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'threadId': threadId,
      'partner': partner?.toJson(),
      'lastMessage': lastMessage?.toJson(),
      'unreadCount': unreadCount,
      'hasUnread': hasUnread,
      'compatibility': compatibility,
      'status': status,
      'lastMessageAt': lastMessageAt,
    };
  }
}

class ChatPartnerModel {
  final String? id;
  final String? uid;
  final String? cometchatUserId;
  final String? name;
  final String? profilePhoto;
  final int? age;
  final String? gender;
  final String? city;
  final bool? isVerified;
  final bool? isOnline;
  final String? onlineStatus;

  const ChatPartnerModel({
    this.id,
    this.uid,
    this.cometchatUserId,
    this.name,
    this.profilePhoto,
    this.age,
    this.gender,
    this.city,
    this.isVerified,
    this.isOnline,
    this.onlineStatus,
  });

  factory ChatPartnerModel.fromJson(Map<String, dynamic> json) {
    return ChatPartnerModel(
      id: json['_id'] as String?,
      uid: json['uid'] as String?,
      cometchatUserId: json['cometchat_user_id'] as String?,
      name: json['name'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      city: json['city'] as String?,
      isVerified: json['isVerified'] as bool?,
      isOnline: json['isOnline'] as bool?,
      onlineStatus: json['onlineStatus'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'uid': uid,
      'cometchat_user_id': cometchatUserId,
      'name': name,
      'profilePhoto': profilePhoto,
      'age': age,
      'gender': gender,
      'city': city,
      'isVerified': isVerified,
      'isOnline': isOnline,
      'onlineStatus': onlineStatus,
    };
  }
}

class LastMessageModel {
  final String? id;
  final String? text;
  final String? timestamp;
  final String? timeAgo;
  final String? senderId;
  final bool? isMe;
  final bool? read;

  const LastMessageModel({
    this.id,
    this.text,
    this.timestamp,
    this.timeAgo,
    this.senderId,
    this.isMe,
    this.read,
  });

  factory LastMessageModel.fromJson(Map<String, dynamic> json) {
    return LastMessageModel(
      id: json['_id'] as String?,
      text: json['text'] as String?,
      timestamp: json['timestamp'] as String?,
      timeAgo: json['timeAgo'] as String?,
      senderId: json['senderId'] as String?,
      isMe: json['isMe'] as bool?,
      read: json['read'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'text': text,
      'timestamp': timestamp,
      'timeAgo': timeAgo,
      'senderId': senderId,
      'isMe': isMe,
      'read': read,
    };
  }
}
