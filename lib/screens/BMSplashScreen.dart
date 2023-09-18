import 'package:beauty_master/screens/BMDashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/BMColors.dart';
import 'BMWalkThroughScreen.dart';

class BMSplashScreen extends StatefulWidget {
  const BMSplashScreen({Key? key}) : super(key: key);

  @override
  _BMSplashScreenState createState() => _BMSplashScreenState();
}

class _BMSplashScreenState extends State<BMSplashScreen> {
  bool? isShowHome;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    SharedPreferences pref = await SharedPreferences.getInstance();
    isShowHome = pref.getBool('showHome') ?? true;
    await 3.seconds.delay;
    finish(context);
    (!isShowHome!)
        ? BMWalkThroughScreen().launch(context, isNewTask: true)
        : BMDashboardScreen(flag: false).launch(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/beautymaster_logo.png', height: 200),
          Text('Beauty Master',
              style: boldTextStyle(
                  size: 20,
                  color: appStore.isDarkModeOn
                      ? Colors.white
                      : bmSpecialColorDark)),
        ],
      ).center(),
    );
  }
}
