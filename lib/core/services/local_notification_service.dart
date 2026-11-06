import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService._();

  static final LocalNotificationService instance = LocalNotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _channelId = "test_notification";
  static const _channelName = "Test Notifications";
  static const _channelDescription = "Static notification testing";

  Future<void> initialize() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await android?.requestNotificationsPermission();

    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.high,
      ),
    );
  }

  void _onNotificationTap(NotificationResponse response) {
    debugPrint("Notification Clicked");
    debugPrint("Payload : ${response.payload}");
  }

  Future<void> showTestNotification() async {
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    await _plugin.show(
      100,
      "🎉 Welcome to Oinder",
      "This is a static local notification for testing.",
      const NotificationDetails(android: androidDetails),
      payload: "test_notification",
    );
  }

  Future<void> showBigTextTestNotification() async {
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(
        "This is a very long static notification used only for testing the UI. "
        "You don't need any API or Firebase to show this notification. "
        "Just tap the button and it will appear.",
      ),
    );

    await _plugin.show(
      101,
      "📢 Oinder Notification",
      "Tap to expand this notification.",
      const NotificationDetails(android: androidDetails),
      payload: "big_text",
    );
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
