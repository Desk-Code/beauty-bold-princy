import 'package:beauty_master/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/BMColors.dart';

class BMSplashScreen extends StatefulWidget {
  const BMSplashScreen({Key? key}) : super(key: key);

  @override
  _BMSplashScreenState createState() => _BMSplashScreenState();
}

class _BMSplashScreenState extends State<BMSplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
    finish(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Lottie.asset(
              "images/animation_lkece2qv.json",
              controller: _animationController,
              onLoaded: (time) {
                _animationController
                  ..duration = time.duration
                  ..forward()
                      .then((value) => SplashServices().isLogin(context));
              },
            ),
          ),
          Text(
            'Beauty Bold',
            style: boldTextStyle(size: 20, color: bmSpecialColorDark),
          ),
        ],
      ).center(),
    );
  }
}
