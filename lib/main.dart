import 'package:cometchat_sdk/builders/app_settings_request.dart';
import 'package:cometchat_sdk/exception/cometchat_exception.dart';
import 'package:cometchat_sdk/main/cometchat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/services/Hive/hive_database.dart';
import 'package:oinder/core/services/local_notification_service.dart';
import 'package:oinder/module/splash/view/splash_view.dart';
import 'package:oinder/utils/utils.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  debugPrint("Background Message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Hive Initialize
  await HiveDataBase.initializeHive();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await LocalNotificationService.instance.initialize();

  await dotenv.load(fileName: ".env");

  final appId = dotenv.env['COMETCHAT_APP_ID'];
  final region = dotenv.env['COMETCHAT_REGION'];

  if (appId == null || region == null) {
    throw Exception("CometChat configuration missing");
  }

  AppSettings appSettings =
      (AppSettingsBuilder()
            ..subscribePresenceForAllUsers()
            ..setRegion(region))
          .build();

  await CometChat.init(
    appId,
    appSettings,
    onSuccess: (String successMessage) {
      debugPrint("CometChat Initialized");
    },
    onError: (CometChatException e) {
      debugPrint(e.message);
    },
  );

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oinder',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: AppSnackbar.messengerKey,
      theme: ThemeData(
        primaryColor: AppColor.primaryColor,
        scaffoldBackgroundColor: AppColor.lightBackground,
        colorScheme: ColorScheme.light(
          primary: AppColor.primaryColor,
          secondary: AppColor.secondaryColor,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
