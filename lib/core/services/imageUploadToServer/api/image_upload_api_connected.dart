import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/core/services/imageUploadToServer/model/multipart_formdata_upload_api_response_model.dart';

class ImageUploadApiConnected {
  final ApiService _apiService;

  ImageUploadApiConnected(this._apiService);

  // Image upload Multipart / FormData
  Future<UploadImageResponseModel> imageUploadToServer({
    required File imageFile,
    String fieldName = "photo",
  }) async {
    final formData = FormData.fromMap({
      fieldName: await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
    });
    final response = await _apiService.fromDataMultipartRequest(
      ApiContants.uploadImageToServer,
      formData: formData,
    );
    return UploadImageResponseModel.fromJson(response.data);
  }
}
