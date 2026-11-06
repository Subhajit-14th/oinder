import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oinder/core/services/get_device_id.dart';
import 'package:oinder/core/services/locationUpdate/api/location_update_repository.dart';
import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/utils/utils.dart';

final locationUpdateRepositoryProvider = Provider<LocationUpdateRepository>((
  ref,
) {
  return LocationUpdateRepository(ref.read(apiServiceProvider));
});

final locationUpdateProvider =
    NotifierProvider<LocationUpdateNotifier, AsyncValue<bool>>(
      LocationUpdateNotifier.new,
    );

class LocationUpdateNotifier extends Notifier<AsyncValue<bool>> {
  @override
  AsyncValue<bool> build() {
    return const AsyncData(false);
  }

  Future<void> updateLocation(BuildContext context) async {
    try {
      state = const AsyncLoading();

      /// 1. Permission Check
      bool permissionGranted = await _checkPermission();

      if (!permissionGranted) {
        state = const AsyncData(false);
        return;
      }

      /// 2. GPS Check
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        state = const AsyncData(false);
        return;
      }

      /// 3. Get Current Location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final lat = position.latitude.toString();

      final lng = position.longitude.toString();

      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);

      if (token == null || token.isEmpty) {
        throw Exception("User not authenticated");
      }

      /// 5. API Call
      final response = await ref
          .read(locationUpdateRepositoryProvider)
          .getLocationUpdate(token: token, lat: lat, lng: lng);

      if (response.success == true) {
        state = const AsyncData(true);

        AppSnackbar.showSuccess(
          response.message ?? "Location updated successfully",
        );
      } else {
        state = const AsyncData(false);

        AppSnackbar.showError(response.message ?? "Location update failed");
      }
    } catch (e, st) {
      log("Location Update Error $e", stackTrace: st);

      state = AsyncError(e, st);

      AppSnackbar.showError("Something went wrong");
    }
  }

  /// Permission Handler

  Future<bool> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      return false;
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();

      return false;
    }

    return true;
  }
}
