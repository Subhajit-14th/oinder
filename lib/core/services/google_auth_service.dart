import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInResult {
  final User user;
  final String idToken;
  final String accessToken;

  const GoogleSignInResult({
    required this.user,
    required this.idToken,
    required this.accessToken,
  });

  factory GoogleSignInResult.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('Firebase User cannot be created from JSON.');
  }

  Map<String, dynamic> toJson() {
    return {
      "idToken": idToken,
      "accessToken": accessToken,
      "user": {
        "uid": user.uid,
        "displayName": user.displayName,
        "email": user.email,
        "photoURL": user.photoURL,
        "phoneNumber": user.phoneNumber,
        "emailVerified": user.emailVerified,
        "isAnonymous": user.isAnonymous,
      },
    };
  }
}

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<GoogleSignInResult?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      log("My google server auth headers is: ${await googleUser.authHeaders}");
      log("My google server authentication is: $googleAuth");

      log("ID TOKEN ===== ${googleAuth.idToken}");
      log("ACCESS TOKEN ===== ${googleAuth.accessToken}");

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      if (user == null) {
        return null;
      }

      return GoogleSignInResult(
        user: user,
        idToken: googleAuth.idToken ?? '',
        accessToken: googleAuth.accessToken ?? '',
      );
    } catch (e, st) {
      log("Google Sign-In Error", error: e, stackTrace: st);
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}

/// =============== Riverpod section ================

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final googleAuthProvider = Provider((ref) {
  return GoogleAuthService();
});
