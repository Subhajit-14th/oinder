class DeletePhotoResponseModel {
  final bool? success;
  final String? message;

  final String? userId;
  final String? id;

  final int? deletedCount;

  final List<String> deletedPhotos;

  final String? profilePhoto;

  final List<PhotoItemModel> photoList;

  final int? count;
  final int? maxAllowed;

  const DeletePhotoResponseModel({
    this.success,
    this.message,
    this.userId,
    this.id,
    this.deletedCount,
    this.deletedPhotos = const [],
    this.profilePhoto,
    this.photoList = const [],
    this.count,
    this.maxAllowed,
  });

  factory DeletePhotoResponseModel.fromJson(Map<String, dynamic> json) {
    return DeletePhotoResponseModel(
      success: json['success'] as bool?,

      message: json['message'] as String?,

      userId: json['userId'] as String?,

      id: json['_id'] as String?,

      deletedCount: json['deletedCount'] as int?,

      deletedPhotos:
          (json['deletedPhotos'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],

      profilePhoto: json['profilePhoto'] as String?,

      photoList:
          (json['photoList'] as List<dynamic>?)
              ?.map((e) => PhotoItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],

      count: json['count'] as int?,

      maxAllowed: json['maxAllowed'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "userId": userId,
      "_id": id,
      "deletedCount": deletedCount,
      "deletedPhotos": deletedPhotos,
      "profilePhoto": profilePhoto,
      "photoList": photoList.map((e) => e.toJson()).toList(),
      "count": count,
      "maxAllowed": maxAllowed,
    };
  }
}

class PhotoItemModel {
  final int? id;
  final String? photoId;
  final String? url;

  const PhotoItemModel({this.id, this.photoId, this.url});

  factory PhotoItemModel.fromJson(Map<String, dynamic> json) {
    return PhotoItemModel(
      id: json['id'] as int?,

      photoId: json['photoId'] as String?,

      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "photoId": photoId, "url": url};
  }
}
