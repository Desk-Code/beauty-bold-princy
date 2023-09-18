import 'package:beauty_master/utils/BMColors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FutureUpdateScreen extends StatelessWidget {
  final bool? enableAppbar;

  FutureUpdateScreen({this.enableAppbar = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bmLightScaffoldBackgroundColor,
        body: Stack(
          children: [
            Icon(Icons.arrow_back, size: 24).paddingAll(16).onTap(() {
              finish(context);
            }).visible(enableAppbar!),
            SizedBox(
              width: context.width(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: boxDecorationDefault(),
                    padding: EdgeInsets.all(16),
                    child: Image.asset("images/beautymaster_logo.png",
                        height: 100),
                  ),
                  22.height,
                  Text(
                    'This Feature is Under Development',
                    style: boldTextStyle(size: 22),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ).paddingAll(16),
          ],
        ),
      ),
    );
  }
}
