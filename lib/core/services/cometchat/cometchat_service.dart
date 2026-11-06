import 'dart:developer';

import 'package:cometchat_sdk/cometchat_sdk.dart';
import 'package:cometchat_sdk/main/cometchat.dart';

class CometChatService {
  static Future<User?> loginWithToken({required String authToken}) async {
    User? loggedUser;

    await CometChat.loginWithAuthToken(
      authToken,
      onSuccess: (User user) {
        loggedUser = user;

        log("CometChat Login Success: ${user.name}");
      },

      onError: (CometChatException error) {
        log("CometChat Login Error: ${error.message}");
      },
    );

    return loggedUser;
  }

  static Future<void> logout() async {
    await CometChat.logout(
      onSuccess: (message) {
        log("CometChat Logout Success");
      },

      onError: (error) {
        log("CometChat Logout Error: ${error.message}");
      },
    );
  }
}
