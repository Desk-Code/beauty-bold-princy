import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/BMCommonCardComponent.dart';
import '../components/BMHomeFragmentHeadComponent.dart';
import '../components/BMMyMasterComponent.dart';
import '../main.dart';
import '../models/BMCommonCardModel.dart';
import '../utils/BMColors.dart';
import '../utils/BMDataGenerator.dart';
import '../utils/BMWidgets.dart';

class BMHomeFragment extends StatefulWidget {
  const BMHomeFragment({Key? key}) : super(key: key);

  @override
  State<BMHomeFragment> createState() => _BMHomeFragmentState();
}

class _BMHomeFragmentState extends State<BMHomeFragment> {
  List<BMCommonCardModel> specialOffersList = getSpecialOffersList();

  List<BMCommonCardModel> recommendedList = getRecommendedList();

  @override
  void initState() {
    setStatusBarColor(bmSpecialColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeFragmentHeadComponent(),
            lowerContainer(
              screenContext: context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.height,
                  titleText(title: 'My Master')
                      .paddingSymmetric(horizontal: 16),
                  20.height,
                  BMMyMasterComponent(),
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleText(title: 'Special Offers'),
                    ],
                  ).paddingSymmetric(horizontal: 16),
                  20.height,
                  HorizontalList(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    spacing: 16,
                    itemCount: specialOffersList.length,
                    itemBuilder: (context, index) {
                      return BMCommonCardComponent(
                          element: specialOffersList[index],
                          fullScreenComponent: false,
                          isFavList: false);
                    },
                  ),
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleText(title: 'Recommended for You').expand(),
                    ],
                  ).paddingSymmetric(horizontal: 16),
                  20.height,
                  HorizontalList(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    spacing: 16,
                    itemCount: recommendedList.length,
                    itemBuilder: (context, index) {
                      return BMCommonCardComponent(
                          element: recommendedList[index],
                          fullScreenComponent: false,
                          isFavList: false);
                    },
                  ),
                  40.height,
                ],
              ).cornerRadiusWithClipRRectOnly(topRight: 40),
            ),
          ],
        ),
      ),
    );
  }
}
