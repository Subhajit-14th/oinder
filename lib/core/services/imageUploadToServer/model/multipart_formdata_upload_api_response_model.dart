class UploadImageResponseModel {
  final bool? success;
  final String? message;
  final String? url;
  final String? imageUrl;
  final String? profilePhoto;
  final List<String>? photos;
  final List<UploadFileModel>? files;

  const UploadImageResponseModel({
    this.success,
    this.message,
    this.url,
    this.imageUrl,
    this.profilePhoto,
    this.photos,
    this.files,
  });

  factory UploadImageResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadImageResponseModel(
      success: json["success"] as bool?,
      message: json["message"] as String?,
      url: json["url"] as String?,
      imageUrl: json["imageUrl"] as String?,
      profilePhoto: json["profilePhoto"] as String?,
      photos: (json["photos"] as List?)?.map((e) => e.toString()).toList(),
      files: (json["files"] as List?)
          ?.map((e) => UploadFileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "url": url,
      "imageUrl": imageUrl,
      "profilePhoto": profilePhoto,
      "photos": photos,
      "files": files?.map((e) => e.toJson()).toList(),
    };
  }

  UploadImageResponseModel copyWith({
    bool? success,
    String? message,
    String? url,
    String? imageUrl,
    String? profilePhoto,
    List<String>? photos,
    List<UploadFileModel>? files,
  }) {
    return UploadImageResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      photos: photos ?? this.photos,
      files: files ?? this.files,
    );
  }
}

class UploadFileModel {
  final String? filename;
  final String? originalName;
  final int? size;
  final String? mimetype;
  final String? url;

  const UploadFileModel({
    this.filename,
    this.originalName,
    this.size,
    this.mimetype,
    this.url,
  });

  factory UploadFileModel.fromJson(Map<String, dynamic> json) {
    return UploadFileModel(
      filename: json["filename"] as String?,
      originalName: json["originalName"] as String?,
      size: json["size"] as int?,
      mimetype: json["mimetype"] as String?,
      url: json["url"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "filename": filename,
      "originalName": originalName,
      "size": size,
      "mimetype": mimetype,
      "url": url,
    };
  }

  UploadFileModel copyWith({
    String? filename,
    String? originalName,
    int? size,
    String? mimetype,
    String? url,
  }) {
    return UploadFileModel(
      filename: filename ?? this.filename,
      originalName: originalName ?? this.originalName,
      size: size ?? this.size,
      mimetype: mimetype ?? this.mimetype,
      url: url ?? this.url,
    );
  }
}
