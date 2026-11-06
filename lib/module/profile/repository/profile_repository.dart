import 'dart:io';
import 'package:dio/dio.dart';
import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/module/profile/model/delete_account_api_response.dart';
import 'package:oinder/module/profile/model/delete_my_photos_api_response.dart';
import 'package:oinder/module/profile/model/get_my_photos_api_response_dart_model.dart';
import 'package:oinder/module/profile/model/get_profile_api_response_model.dart';
import 'package:oinder/module/profile/model/post_photo_upload_api_response.dart';
import 'package:oinder/module/profile/model/profile_photo_updated_api_response_model.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  /// Get Profile Data
  Future<UserProfileModel> getProfileData({required String token}) async {
    final response = await _apiService.getRequest(
      ApiContants.getProfile,
      headers: {"Authorization": "Bearer $token"},
    );
    return UserProfileModel.fromJson(response.data);
  }

  /// Update Profile Photo
  Future<ProfilePhotoUpdateResponse> updateProfileImage({
    required String token,
    required File image,
  }) async {
    final fileName = image.path.split('/').last;
    final multipartFile = await MultipartFile.fromFile(
      image.path,
      filename: fileName,
    );
    final formData = FormData.fromMap({
      "files": [multipartFile],
    });
    final response = await _apiService.fromDataMultipartRequest(
      ApiContants.updateProfilePhoto,
      headers: {"Authorization": "Bearer $token"},
      formData: formData,
    );
    return ProfilePhotoUpdateResponse.fromJson(response.data);
  }

  /// Get My Photos
  Future<PhotoUploadResponseModel> getMyPhotos({required String token}) async {
    final response = await _apiService.getRequest(
      ApiContants.getMyPhotos,
      headers: {"Authorization": "Bearer $token"},
    );
    return PhotoUploadResponseModel.fromJson(response.data);
  }

  Future<DeletePhotoResponseModel> deletePhoto({
    required String token,
    required String photoId,
  }) async {
    final response = await _apiService.deleteRequest(
      ApiContants.deletePhoto,
      headers: {"Authorization": "Bearer $token"},
      data: {"photoId": photoId},
    );
    return DeletePhotoResponseModel.fromJson(response.data);
  }

  /// Delete Account
  Future<DeleteAccountResponse> deleteAccount({required String userId}) async {
    final response = await _apiService.postRequest(
      {},
      ApiContants.deleteAccount,
      data: {"userId": userId},
    );
    return DeleteAccountResponse.fromJson(response.data);
  }

  /// Photo Upload
  Future<UploadMyPhotosResponseModel> uploadMyPhotos({
    required String token,
    required List<File> photos,
  }) async {
    final formData = FormData();
    formData.fields.add(const MapEntry("append", "true"));
    for (final photo in photos) {
      formData.files.add(
        MapEntry(
          "photos",
          await MultipartFile.fromFile(
            photo.path,
            filename: photo.uri.pathSegments.last,
          ),
        ),
      );
    }
    final response = await _apiService.fromDataMultipartRequest(
      ApiContants.uploadMyPhotos,
      headers: {"Authorization": "Bearer $token"},
      formData: formData,
    );
    return UploadMyPhotosResponseModel.fromJson(response.data);
  }
}
