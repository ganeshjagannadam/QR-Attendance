

import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';


class LocalAuth{
  static final _auth = LocalAuthentication();
  LocalAuthAndroid localAuthAndroid = LocalAuthAndroid();
   static Future<bool> canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    try{
      if(!await canAuthenticate()) return false;
      return await _auth.authenticate(
          authMessages: const[
            AndroidAuthMessages(
              signInTitle: "Authenticate",
              cancelButton: "No Thanks"
            ),
            IOSAuthMessages(
              cancelButton: "No Thanks"
            )
          ],
          localizedReason: "Place your Finger for Authentication",
            options: const AuthenticationOptions(
              useErrorDialogs: true,
              stickyAuth: true,
              biometricOnly: true,
            ));
    } catch (e){
      if (kDebugMode) {
        print("error $e");
      }
      return false;
    }
  }
}