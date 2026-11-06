import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:oinder/module/profile/provider/profile_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class MyPhotosView extends ConsumerStatefulWidget {
  const MyPhotosView({super.key});

  @override
  ConsumerState<MyPhotosView> createState() => _MyPhotosViewState();
}

class _MyPhotosViewState extends ConsumerState<MyPhotosView> {
  double _uploadProgress = 0;
  File? _uploadingImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (pickedFile == null) {
      return;
    }

    final image = File(pickedFile.path);

    setState(() {
      _uploadingImage = image;

      _uploadProgress = 0;
    });

    await ref
        .read(uploadMyPhotosProvider.notifier)
        .uploadMyPhotos(photos: [image]);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(myPhotosApiProvider.notifier).getMyPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(deletePhotoProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (data != null) {
            AppSnackbar.showSuccess(
              data.message ?? "Photo deleted successfully",
            );
          }
        },
        error: (error, stack) {
          AppSnackbar.showError(error.toString());
        },
      );
    });
    ref.listen(uploadMyPhotosProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (data != null) {
            setState(() {
              _uploadingImage = null;
            });

            ref.read(myPhotosApiProvider.notifier).getMyPhotos();
          }
        },
      );
    });
    final photosState = ref.watch(myPhotosApiProvider);
    final localImages = ref.watch(myPhotosProvider);
    final deleteState = ref.watch(deletePhotoProvider);
    final isDeleting = deleteState.isLoading;
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
      appBar: AppBar(
        backgroundColor: AppColor.bodyColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColor.white),
        ),
        title: const Texts(
          "My Photos",
          color: AppColor.white,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
      body: SafeArea(
        child: photosState.when(
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          error: (error, stack) {
            return Center(
              child: Texts(error.toString(), color: AppColor.white),
            );
          },
          data: (data) {
            final photos = data?.photoList ?? [];
            final currentCount =
                photos.length +
                localImages.length +
                (_uploadingImage != null ? 1 : 0);
            const minRequired = 4;
            const maxPhotos = 5;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Expanded(
                    child: GridView.builder(
                      itemCount: currentCount,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemBuilder: (context, index) {
                        if (index < photos.length) {
                          return _buildNetworkImageCard(
                            photos[index].url ?? "",
                            photos[index].photoId ?? "",
                            isDeleting,
                          );
                        }
                        final localIndex = index - photos.length;
                        if (localIndex < localImages.length) {
                          return _buildLocalImageCard(
                            localImages[localIndex],
                            localIndex,
                          );
                        }
                        return _buildUploadingCard(_uploadingImage!);
                      },
                    ),
                  ),

                  if (currentCount < minRequired)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Texts(
                        "Please upload minimum $minRequired photos",
                        color: Colors.orange,
                        fontSize: 14,
                      ),
                    ),

                  if (currentCount >= maxPhotos)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Texts(
                        "You have reached maximum $maxPhotos photos",
                        color: AppColor.white.withValues(alpha: .6),
                        fontSize: 14,
                      ),
                    ),

                  if (currentCount < maxPhotos)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: InkWell(
                        onTap: _pickImage,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColor.primaryColor,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: AppColor.white),
                              SizedBox(width: 8),
                              Texts(
                                "Add Photo",
                                color: AppColor.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUploadingCard(File image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(image, fit: BoxFit.cover),
          Container(
            color: Colors.black54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  value: _uploadProgress,
                  color: AppColor.primaryColor,
                ),
                const SizedBox(height: 12),

                Texts(
                  "${(_uploadProgress * 100).toInt()}%",
                  color: AppColor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkImageCard(String image, String photoId, bool isDeleting) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) {
              return Container(
                color: Colors.black12,
                child: const Icon(
                  Icons.image_not_supported,
                  color: AppColor.white,
                ),
              );
            },
          ),

          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: isDeleting
                  ? null
                  : () {
                      if (photoId.isEmpty) {
                        return;
                      }
                      ref
                          .read(deletePhotoProvider.notifier)
                          .deletePhoto(photoId: photoId);
                    },
              child: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: isDeleting
                    ? const Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColor.white,
                        ),
                      )
                    : const Icon(Icons.close, color: AppColor.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocalImageCard(File image, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(image, fit: BoxFit.cover),

          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: () {
                ref.read(myPhotosProvider.notifier).removeImage(index);
              },
              child: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: AppColor.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
