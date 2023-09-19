import 'package:beauty_master/screens/BMDashboardScreen.dart';
import 'package:beauty_master/screens/BMWalkThroughScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      BMDashboardScreen(flag: false).launch(context);
    } else {
      BMWalkThroughScreen().launch(context, isNewTask: true);
    }
  }
}
