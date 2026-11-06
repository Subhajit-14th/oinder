import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, Brightness>(
  (ref) => ThemeModeNotifier(),
);

class ThemeModeNotifier extends StateNotifier<Brightness>
    with WidgetsBindingObserver {
  ThemeModeNotifier()
    : super(WidgetsBinding.instance.platformDispatcher.platformBrightness) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    state = brightness;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
