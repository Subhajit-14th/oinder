class ChatSendMessageResponse {
  final bool? success;
  final String? message;
  final String? threadId;
  final ChatMessageData? data;
  final CometChatMessageModel? cometChat;

  const ChatSendMessageResponse({
    this.success,
    this.message,
    this.threadId,
    this.data,
    this.cometChat,
  });

  factory ChatSendMessageResponse.fromJson(Map<String, dynamic> json) {
    return ChatSendMessageResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      threadId: json['threadId'] as String?,
      data: json['data'] is Map<String, dynamic>
          ? ChatMessageData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      cometChat: json['cometChat'] is Map<String, dynamic>
          ? CometChatMessageModel.fromJson(
              json['cometChat'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'threadId': threadId,
      'data': data?.toJson(),
      'cometChat': cometChat?.toJson(),
    };
  }
}

class ChatMessageData {
  final String? senderId;
  final String? senderName;
  final String? senderPhoto;
  final String? text;
  final String? timestamp;
  final bool? read;

  const ChatMessageData({
    this.senderId,
    this.senderName,
    this.senderPhoto,
    this.text,
    this.timestamp,
    this.read,
  });

  factory ChatMessageData.fromJson(Map<String, dynamic> json) {
    return ChatMessageData(
      senderId: json['senderId'] as String?,
      senderName: json['senderName'] as String?,
      senderPhoto: json['senderPhoto'] as String?,
      text: json['text'] as String?,
      timestamp: json['timestamp'] as String?,
      read: json['read'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'senderPhoto': senderPhoto,
      'text': text,
      'timestamp': timestamp,
      'read': read,
    };
  }
}

class CometChatMessageModel {
  final String? id;
  final String? conversationId;
  final String? sender;
  final String? receiverType;
  final String? receiver;
  final String? category;
  final String? type;
  final CometChatDataModel? data;
  final int? sentAt;
  final int? updatedAt;

  const CometChatMessageModel({
    this.id,
    this.conversationId,
    this.sender,
    this.receiverType,
    this.receiver,
    this.category,
    this.type,
    this.data,
    this.sentAt,
    this.updatedAt,
  });

  factory CometChatMessageModel.fromJson(Map<String, dynamic> json) {
    return CometChatMessageModel(
      id: json['id'] as String?,
      conversationId: json['conversationId'] as String?,
      sender: json['sender'] as String?,
      receiverType: json['receiverType'] as String?,
      receiver: json['receiver'] as String?,
      category: json['category'] as String?,
      type: json['type'] as String?,
      data: json['data'] is Map<String, dynamic>
          ? CometChatDataModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      sentAt: json['sentAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversationId': conversationId,
      'sender': sender,
      'receiverType': receiverType,
      'receiver': receiver,
      'category': category,
      'type': type,
      'data': data?.toJson(),
      'sentAt': sentAt,
      'updatedAt': updatedAt,
    };
  }
}

class CometChatDataModel {
  final String? text;
  final CometChatEntitiesModel? entities;
  final Map<String, dynamic>? metadata;

  const CometChatDataModel({this.text, this.entities, this.metadata});

  factory CometChatDataModel.fromJson(Map<String, dynamic> json) {
    return CometChatDataModel(
      text: json['text'] as String?,
      entities: json['entities'] is Map<String, dynamic>
          ? CometChatEntitiesModel.fromJson(
              json['entities'] as Map<String, dynamic>,
            )
          : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'entities': entities?.toJson(), 'metadata': metadata};
  }
}

class CometChatEntitiesModel {
  final CometChatUserEntityModel? sender;
  final CometChatUserEntityModel? receiver;

  const CometChatEntitiesModel({this.sender, this.receiver});

  factory CometChatEntitiesModel.fromJson(Map<String, dynamic> json) {
    return CometChatEntitiesModel(
      sender: json['sender'] is Map<String, dynamic>
          ? CometChatUserEntityModel.fromJson(
              json['sender'] as Map<String, dynamic>,
            )
          : null,
      receiver: json['receiver'] is Map<String, dynamic>
          ? CometChatUserEntityModel.fromJson(
              json['receiver'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'sender': sender?.toJson(), 'receiver': receiver?.toJson()};
  }
}

class CometChatUserEntityModel {
  final CometChatEntityModel? entity;
  final String? entityType;

  const CometChatUserEntityModel({this.entity, this.entityType});

  factory CometChatUserEntityModel.fromJson(Map<String, dynamic> json) {
    return CometChatUserEntityModel(
      entity: json['entity'] is Map<String, dynamic>
          ? CometChatEntityModel.fromJson(
              json['entity'] as Map<String, dynamic>,
            )
          : null,
      entityType: json['entityType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entity': entity?.toJson(), 'entityType': entityType};
  }
}

class CometChatEntityModel {
  final String? uid;
  final String? name;
  final String? avatar;
  final String? status;
  final String? role;
  final int? createdAt;
  final int? updatedAt;
  final String? conversationId;

  const CometChatEntityModel({
    this.uid,
    this.name,
    this.avatar,
    this.status,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.conversationId,
  });

  factory CometChatEntityModel.fromJson(Map<String, dynamic> json) {
    return CometChatEntityModel(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      status: json['status'] as String?,
      role: json['role'] as String?,
      createdAt: json['createdAt'] as int?,
      updatedAt: json['updatedAt'] as int?,
      conversationId: json['conversationId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'avatar': avatar,
      'status': status,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'conversationId': conversationId,
    };
  }
}
