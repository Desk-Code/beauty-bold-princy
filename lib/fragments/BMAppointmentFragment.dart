import 'package:beauty_master/common/common_appoiment_tile.dart';
import 'package:beauty_master/network/firebase/firebase_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  String? email = FirebaseAuth.instance.currentUser!.email;
  @override
  void initState() {
    setStatusBarColor(appStore.isDarkModeOn
        ? appStore.scaffoldBackground!
        : bmLightScaffoldBackgroundColor);
    futureAppoimentData = FirebaseApi.selectAppoimentData(email);

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
      backgroundColor: white,
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
                    log("${FirebaseApi.appoimentData}");
                    if (snapshot.hasData) {
                      return Column(
                        children: List.generate(
                          FirebaseApi.dataLength + 1,
                          (index) => Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) async {
                              String selectedKey =
                                  FirebaseApi.appoimentData[index]['key'];
                              log(selectedKey);
                              await FirebaseApi.appoimentDeleteData(
                                      selectedkey: selectedKey)
                                  .then((value) => futureAppoimentData =
                                      FirebaseApi.selectAppoimentData(email));
                              setState(() {});
                            },
                            child: (FirebaseApi.appoimentData.isNotEmpty)
                                ? commonAppoimentTile(context,
                                    isSelected: true,
                                    service:
                                        "${FirebaseApi.appoimentData[index]['name']}",
                                    userName:
                                        "${FirebaseApi.appoimentData[index]['username']}",
                                    cost:
                                        "\$${FirebaseApi.appoimentData[index]['cost']}",
                                    time:
                                        "${FirebaseApi.appoimentData[index]['pickDate']} (${FirebaseApi.appoimentData[index]['pickTime']}) for Timing ${FirebaseApi.appoimentData[index]['time']}")
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.77,
                                    width: SizeConfig.screenWidth,
                                    alignment: Alignment.center,
                                    child: Lottie.asset('images/no_data.json'),
                                  ),
                          ),
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
