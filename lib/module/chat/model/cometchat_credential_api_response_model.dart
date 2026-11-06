class CometChatCredentialResponse {
  final bool? success;
  final String? message;
  final CometChatUserModel? user;
  final CometChatConfigModel? cometChat;

  const CometChatCredentialResponse({
    this.success,
    this.message,
    this.user,
    this.cometChat,
  });

  factory CometChatCredentialResponse.fromJson(Map<String, dynamic> json) {
    return CometChatCredentialResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      user: json['user'] is Map<String, dynamic>
          ? CometChatUserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      cometChat: json['cometChat'] is Map<String, dynamic>
          ? CometChatConfigModel.fromJson(
              json['cometChat'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'user': user?.toJson(),
      'cometChat': cometChat?.toJson(),
    };
  }
}

class CometChatUserModel {
  final String? uid;
  final String? name;
  final String? avatar;
  final String? authToken;
  final int? createdAt;

  const CometChatUserModel({
    this.uid,
    this.name,
    this.avatar,
    this.authToken,
    this.createdAt,
  });

  factory CometChatUserModel.fromJson(Map<String, dynamic> json) {
    return CometChatUserModel(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      authToken: json['authToken'] as String?,
      createdAt: json['createdAt'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'avatar': avatar,
      'authToken': authToken,
      'createdAt': createdAt,
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
      'appId': appId,
      'region': region,
      'authKey': authKey,
      'apiKey': apiKey,
      'baseUrl': baseUrl,
    };
  }
}
