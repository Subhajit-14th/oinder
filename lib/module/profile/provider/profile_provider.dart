import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/get_device_id.dart';

import 'package:oinder/module/profile/model/delete_account_api_response.dart';
import 'package:oinder/module/profile/model/delete_my_photos_api_response.dart';
import 'package:oinder/module/profile/model/get_my_photos_api_response_dart_model.dart';
import 'package:oinder/module/profile/model/get_profile_api_response_model.dart';
import 'package:oinder/module/profile/model/post_photo_upload_api_response.dart';
import 'package:oinder/module/profile/model/profile_photo_updated_api_response_model.dart';

import 'package:oinder/module/profile/repository/profile_repository.dart';

// Repository Provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);

  return ProfileRepository(apiService);
});

// Profile Provider
final profileProvider = FutureProvider.autoDispose<UserProfileModel>((
  ref,
) async {
  final deviceId = await ref.read(deviceIdProvider.future);
  final token = await AuthStorage.getToken(deviceId);
  if (token == null || token.isEmpty) {
    throw Exception("User not authenticated");
  }
  return ref.read(profileRepositoryProvider).getProfileData(token: token);
});

// Update Profile Image
final updateProfileImageProvider =
    FutureProvider.family<ProfilePhotoUpdateResponse, File>((ref, image) async {
      final deviceId = await ref.read(deviceIdProvider.future);

      final token = await AuthStorage.getToken(deviceId);

      if (token == null || token.isEmpty) {
        throw Exception("User not authenticated");
      }

      return ref
          .read(profileRepositoryProvider)
          .updateProfileImage(token: token, image: image);
    });

// =======================================================
// Local Selected Photos
// =======================================================
final myPhotosProvider =
    StateNotifierProvider<MyPhotosLocalNotifier, List<File>>((ref) {
      return MyPhotosLocalNotifier();
    });

class MyPhotosLocalNotifier extends StateNotifier<List<File>> {
  MyPhotosLocalNotifier() : super([]);

  void addImage(File image) {
    if (state.length >= 5) {
      return;
    }

    state = [...state, image];
  }

  void removeImage(int index) {
    final images = [...state];

    images.removeAt(index);

    state = images;
  }

  void clearImages() {
    state = [];
  }
}

// =======================================================
// My Photos API
// =======================================================
final myPhotosApiProvider =
    StateNotifierProvider<
      MyPhotosNotifier,
      AsyncValue<PhotoUploadResponseModel?>
    >((ref) {
      return MyPhotosNotifier(ref, ref.read(profileRepositoryProvider));
    });

class MyPhotosNotifier
    extends StateNotifier<AsyncValue<PhotoUploadResponseModel?>> {
  final Ref ref;

  final ProfileRepository repository;

  MyPhotosNotifier(this.ref, this.repository)
    : super(const AsyncValue.data(null));

  Future<String> _getToken() async {
    final deviceId = await ref.read(deviceIdProvider.future);

    final token = await AuthStorage.getToken(deviceId);

    if (token == null || token.isEmpty) {
      throw Exception("User not authenticated");
    }

    return token;
  }

  Future<void> getMyPhotos() async {
    try {
      final response = await repository.getMyPhotos(token: await _getToken());

      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// =======================================================
// Delete Photo API
// =======================================================
final deletePhotoProvider =
    StateNotifierProvider<
      DeletePhotoNotifier,
      AsyncValue<DeletePhotoResponseModel?>
    >((ref) {
      return DeletePhotoNotifier(ref, ref.read(profileRepositoryProvider));
    });

class DeletePhotoNotifier
    extends StateNotifier<AsyncValue<DeletePhotoResponseModel?>> {
  final Ref ref;

  final ProfileRepository repository;

  DeletePhotoNotifier(this.ref, this.repository)
    : super(const AsyncValue.data(null));

  Future<String> _getToken() async {
    final deviceId = await ref.read(deviceIdProvider.future);

    final token = await AuthStorage.getToken(deviceId);

    if (token == null || token.isEmpty) {
      throw Exception("User not authenticated");
    }

    return token;
  }

  Future<void> deletePhoto({required String photoId}) async {
    try {
      state = const AsyncValue.loading();

      final response = await repository.deletePhoto(
        token: await _getToken(),
        photoId: photoId,
      );

      state = AsyncValue.data(response);

      // refresh photos after delete

      await ref.read(myPhotosApiProvider.notifier).getMyPhotos();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// =======================================================
// Delete Account
// =======================================================
final deleteAccountProvider = FutureProvider.autoDispose
    .family<DeleteAccountResponse, String>((ref, userId) async {
      return ref.read(profileRepositoryProvider).deleteAccount(userId: userId);
    });

// =======================================================
// Upload My Photos API Provider
// =======================================================
final uploadMyPhotosProvider =
    StateNotifierProvider<
      UploadMyPhotosNotifier,
      AsyncValue<UploadMyPhotosResponseModel?>
    >((ref) {
      final repository = ref.read(profileRepositoryProvider);
      return UploadMyPhotosNotifier(ref, repository);
    });

class UploadMyPhotosNotifier
    extends StateNotifier<AsyncValue<UploadMyPhotosResponseModel?>> {
  final Ref ref;
  final ProfileRepository repository;

  UploadMyPhotosNotifier(this.ref, this.repository)
    : super(const AsyncValue.data(null));

  Future<void> uploadMyPhotos({required List<File> photos}) async {
    try {
      state = const AsyncValue.loading();
      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);
      if (token == null || token.isEmpty) {
        throw Exception("User not authenticated");
      }
      final response = await repository.uploadMyPhotos(
        token: token,
        photos: photos,
      );
      state = AsyncValue.data(response);
      await ref.read(myPhotosApiProvider.notifier).getMyPhotos();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
