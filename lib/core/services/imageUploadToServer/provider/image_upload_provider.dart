import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/core/services/imageUploadToServer/api/image_upload_api_connected.dart';
import 'package:oinder/core/services/imageUploadToServer/model/multipart_formdata_upload_api_response_model.dart';

// Repository Provider
final imageUploadApiConnectedProvider = Provider<ImageUploadApiConnected>((
  ref,
) {
  return ImageUploadApiConnected(ref.read(apiServiceProvider));
});

// Upload Provider
final imageUploadProvider =
    AsyncNotifierProvider<ImageUploadNotifier, UploadImageResponseModel?>(
      ImageUploadNotifier.new,
    );

class ImageUploadNotifier extends AsyncNotifier<UploadImageResponseModel?> {
  @override
  Future<UploadImageResponseModel?> build() async {
    return null;
  }

  Future<String?> uploadImage({
    required File imageFile,
    String fieldName = "photo",
  }) async {
    state = const AsyncLoading();

    try {
      final response = await ref
          .read(imageUploadApiConnectedProvider)
          .imageUploadToServer(imageFile: imageFile, fieldName: fieldName);

      state = AsyncData(response);

      final imageUrl =
          response.url ??
          response.imageUrl ??
          response.profilePhoto ??
          response.files?.firstOrNull?.url;

      return imageUrl;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);

      return null;
    }
  }
}
