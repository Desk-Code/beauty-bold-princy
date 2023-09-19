import 'package:beauty_master/main.dart';
import 'package:beauty_master/utils/BMColors.dart';
import 'package:beauty_master/utils/BMWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Widget commonAppoimentTile(
  BuildContext context, {
  required bool isSelected,
}) =>
    Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected
            ? appStore.isDarkModeOn
                ? Colors.white.withAlpha(30)
                : bmSpecialColorDark.withAlpha(30)
            : context.cardColor,
        borderRadius: radius(32),
        border: Border.all(
            color: isSelected
                ? appStore.isDarkModeOn
                    ? Colors.white
                    : bmSpecialColorDark
                : context.cardColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("images/face_two.jpg",
                  height: 50, width: 50, fit: BoxFit.cover)
              .cornerRadiusWithClipRRect(32),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("salonName",
                  style: primaryTextStyle(color: bmPrimaryColor, size: 14)),
              2.height,
              titleText(title: "service", size: 16, maxLines: 2),
              2.height,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.timelapse, color: bmPrimaryColor, size: 16),
                  4.width,
                  Text("time",
                      style: secondaryTextStyle(
                          size: 12,
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmSpecialColorDark))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_bag_rounded,
                      color: bmPrimaryColor, size: 14),
                  4.width,
                  Text("product",
                      style: secondaryTextStyle(
                          size: 12,
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmSpecialColorDark))
                ],
              )
            ],
          ).expand()
        ],
      ),
    ).onTap(() {
      isSelected = !isSelected;
    });
