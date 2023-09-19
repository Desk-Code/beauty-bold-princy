import 'package:beauty_master/common/common_toast.dart';
import 'package:beauty_master/main.dart';
import 'package:beauty_master/models/BMServiceListModel.dart';
import 'package:beauty_master/network/firebase/firebase_api.dart';
import 'package:beauty_master/screens/BMDashboardScreen.dart';
import 'package:beauty_master/utils/BMColors.dart';
import 'package:beauty_master/utils/BMWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:nb_utils/nb_utils.dart';

class BMAddAppoimentFragment extends StatefulWidget {
  const BMAddAppoimentFragment({Key? key, this.element}) : super(key: key);
  final BMServiceListModel? element;
  @override
  State<BMAddAppoimentFragment> createState() => _BMAddAppoimentFragmentState();
}

class _BMAddAppoimentFragmentState extends State<BMAddAppoimentFragment> {
  GlobalKey<FormState> globalkey = GlobalKey<FormState>();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  TextEditingController _txtnameController = TextEditingController();
  @override
  void initState() {
    print("${widget.element!.name}");
    print("${widget.element!.time}");
    print("${widget.element!.cost}");
    setStatusBarColor(bmSpecialColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: Form(
        key: globalkey,
        child: Column(
          children: [
            upperContainer(
              screenContext: context,
              child: headerText(title: 'Appoiment'),
            ),
            lowerContainer(
              screenContext: context,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    Text('Enter your Nick Name',
                        style: primaryTextStyle(
                            color: appStore.isDarkModeOn
                                ? bmTextColorDarkMode
                                : bmSpecialColor,
                            size: 14)),
                    AppTextField(
                      controller: _txtnameController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "please input name first"),
                      ]),
                      keyboardType: TextInputType.name,
                      textFieldType: TextFieldType.NAME,
                      autoFocus: true,
                      cursorColor: bmPrimaryColor,
                      textStyle: boldTextStyle(
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmPrimaryColor),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: appStore.isDarkModeOn
                                    ? bmTextColorDarkMode
                                    : bmPrimaryColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: appStore.isDarkModeOn
                                    ? bmTextColorDarkMode
                                    : bmPrimaryColor)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: appStore.isDarkModeOn
                                    ? bmTextColorDarkMode
                                    : bmPrimaryColor)),
                      ),
                    ),
                    20.height,
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2050),
                            ).then((value) {
                              setState(() {});
                              return value;
                            });
                          },
                          color: bmPrimaryColor,
                          child: const Text("Pick Date"),
                        ),
                        20.width,
                        if (selectedDate != null)
                          Text(
                              "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                              style: primaryTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? bmTextColorDarkMode
                                      : bmSpecialColor,
                                  size: 14)),
                      ],
                    ),
                    20.height,
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              setState(() {});
                              return value;
                            });
                          },
                          color: bmPrimaryColor,
                          child: const Text("Pick Time"),
                        ),
                        20.width,
                        if (selectedTime != null)
                          Text(selectedTime!.format(context),
                              style: primaryTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? bmTextColorDarkMode
                                      : bmSpecialColor,
                                  size: 14)),
                      ],
                    ),
                    30.height,
                    Row(
                      children: [
                        AppButton(
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          child: Text('Book & Pay',
                              style: boldTextStyle(color: Colors.white)),
                          padding: EdgeInsets.all(16),
                          color: bmPrimaryColor,
                          onTap: () async {
                            if (globalkey.currentState!.validate()) {
                              FirebaseApi.setAppoimentData(
                                      email:
                                          "${FirebaseAuth.instance.currentUser!.email}",
                                      userName: _txtnameController.text,
                                      pickDate:
                                          "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                      pickTime: selectedTime!.format(context),
                                      cost: widget.element!.cost,
                                      name: widget.element!.name,
                                      time: widget.element!.time)
                                  .then((value) => FlutterToast().showMessage(
                                      "Your Appoiment is takken Successfully"))
                                  .then((value) => BMDashboardScreen(
                                        flag: false,
                                      ).launch(context));
                            }
                          },
                        ).expand(),
                      ],
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16),
              ),
            ).expand()
          ],
        ),
      ),
    );
  }
}
