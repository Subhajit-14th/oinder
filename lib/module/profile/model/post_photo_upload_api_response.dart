class UploadMyPhotosResponseModel {
  final bool? success;
  final String? message;
  final String? userId;
  final String? id;
  final String? profilePhoto;
  final List<UploadPhotoItemModel> photoList;
  final int? count;
  final int? maxAllowed;

  const UploadMyPhotosResponseModel({
    this.success,
    this.message,
    this.userId,
    this.id,
    this.profilePhoto,
    this.photoList = const [],
    this.count,
    this.maxAllowed,
  });

  factory UploadMyPhotosResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadMyPhotosResponseModel(
      success: json["success"] as bool?,
      message: json["message"] as String?,
      userId: json["userId"] as String?,
      id: json["_id"] as String?,
      profilePhoto: json["profilePhoto"] as String?,
      photoList:
          (json["photoList"] as List<dynamic>?)
              ?.map(
                (e) => UploadPhotoItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      count: json["count"] as int?,
      maxAllowed: json["maxAllowed"] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "userId": userId,
      "_id": id,
      "profilePhoto": profilePhoto,
      "photoList": photoList.map((e) => e.toJson()).toList(),
      "count": count,
      "maxAllowed": maxAllowed,
    };
  }
}

class UploadPhotoItemModel {
  final int? id;
  final String? photoId;
  final String? url;

  const UploadPhotoItemModel({this.id, this.photoId, this.url});

  factory UploadPhotoItemModel.fromJson(Map<String, dynamic> json) {
    return UploadPhotoItemModel(
      id: json["id"] as int?,
      photoId: json["photoId"] as String?,
      url: json["url"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "photoId": photoId, "url": url};
  }
}
