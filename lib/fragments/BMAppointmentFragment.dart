import 'package:beauty_master/common/common_appoiment_tile.dart';
import 'package:beauty_master/network/firebase/firebase_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';

class BMAppointmentFragment extends StatefulWidget {
  const BMAppointmentFragment({Key? key}) : super(key: key);

  @override
  State<BMAppointmentFragment> createState() => _BMAppointmentFragmentState();
}

class _BMAppointmentFragmentState extends State<BMAppointmentFragment> {
  late Future<List<Map>> futureAppoimentData;

  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);

    futureAppoimentData = FirebaseApi.selectAppoimentData(
        FirebaseAuth.instance.currentUser!.email);
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: appStore.isDarkModeOn
            ? appStore.scaffoldBackground!
            : bmLightScaffoldBackgroundColor,
        elevation: 0,
        leading: SizedBox(),
        leadingWidth: 16,
        title: titleText(title: 'Appointments'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: appStore.isDarkModeOn
                ? bmSecondBackgroundColorDark
                : bmSecondBackgroundColorLight,
            borderRadius: radiusOnly(topLeft: 32, topRight: 32),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: futureAppoimentData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: List.generate(
                          FirebaseApi.dataLength,
                          (index) =>
                              commonAppoimentTile(context, isSelected: true),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
