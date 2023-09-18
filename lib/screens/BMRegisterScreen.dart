import 'package:beauty_master/common/common_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/BMSocialIconsLoginComponents.dart';
import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';
import 'BMEnableLocationScreen.dart';
import 'BMLoginScreen.dart';

class BMRegisterScreen extends StatefulWidget {
  const BMRegisterScreen({Key? key}) : super(key: key);

  @override
  _BMRegisterScreenState createState() => _BMRegisterScreenState();
}

class _BMRegisterScreenState extends State<BMRegisterScreen> {
  TextEditingController _txtEmailController = TextEditingController();
  TextEditingController _txtPassController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  FocusNode password = FocusNode();

  @override
  void initState() {
    setStatusBarColor(bmSpecialColor);
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent);
    super.dispose();
  }

  Future<void> signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _txtEmailController.text.trim(),
      password: _txtPassController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn
          ? appStore.scaffoldBackground!
          : bmLightScaffoldBackgroundColor,
      body: Form(
        key: globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            upperContainer(
              screenContext: context,
              child: headerText(title: 'Register'),
            ),
            lowerContainer(
                screenContext: context,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      Row(
                        children: [
                          Text('Are you a member?',
                              style: boldTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? Colors.white
                                      : bmSpecialColorDark)),
                          TextButton(
                            onPressed: () {
                              BMLoginScreen().launch(context);
                            },
                            child: Text('Login Now',
                                style: boldTextStyle(
                                    color: appStore.isDarkModeOn
                                        ? bmPrimaryColor
                                        : Colors.grey)),
                          )
                        ],
                      ),
                      30.height,
                      Text('Enter your email',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        controller: _txtEmailController,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "please first input a email"),
                          EmailValidator(errorText: "input valid email"),
                        ]),
                        keyboardType: TextInputType.emailAddress,
                        nextFocus: password,
                        textFieldType: TextFieldType.EMAIL,
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
                      Text('Password',
                          style: primaryTextStyle(
                              color: appStore.isDarkModeOn
                                  ? bmTextColorDarkMode
                                  : bmSpecialColor,
                              size: 14)),
                      AppTextField(
                        controller: _txtPassController,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "please input password first"),
                          MinLengthValidator(6,
                              errorText:
                                  "please inter minimum 6 character password"),
                        ]),
                        focus: password,
                        textFieldType: TextFieldType.PASSWORD,
                        autoFocus: true,
                        cursorColor: bmPrimaryColor,
                        textStyle: boldTextStyle(
                            color: appStore.isDarkModeOn
                                ? bmTextColorDarkMode
                                : bmPrimaryColor),
                        suffixIconColor: bmPrimaryColor,
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
                      30.height,
                      AppButton(
                        width: context.width() - 32,
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        child: Text('Join Now',
                            style: boldTextStyle(color: Colors.white)),
                        padding: EdgeInsets.all(16),
                        color: bmPrimaryColor,
                        onTap: () async {
                          if (globalKey.currentState!.validate()) {
                            await signUp();
                            BMEnableLocationScreen().launch(context);
                          }
                        },
                      ),
                      30.height,
                      Text(
                        'or register with',
                        style: secondaryTextStyle(
                            color: appStore.isDarkModeOn
                                ? bmTextColorDarkMode
                                : bmSpecialColorDark),
                      ).center(),
                      30.height,
                      BMSocialIconsLoginComponents().center().onTap(() {
                        FlutterToast()
                            .showMessage("It's Implementing in Future Update.");
                      }),
                      30.height,
                      Text(
                        'By clicking Join Beauty Master, you agreeing to',
                        style: secondaryTextStyle(
                            color: appStore.isDarkModeOn
                                ? Colors.white
                                : bmSpecialColorDark,
                            size: 12),
                      ).center(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('the ',
                              style: secondaryTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? Colors.white
                                      : bmSpecialColorDark,
                                  size: 12)),
                          Text('Terms of Use',
                              style: secondaryTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? bmPrimaryColor
                                      : Colors.grey,
                                  decoration: TextDecoration.underline)),
                          Text(' and the ',
                              style: secondaryTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? Colors.white
                                      : bmSpecialColorDark,
                                  size: 12)),
                          Text('Privacy Policy',
                              style: secondaryTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? bmPrimaryColor
                                      : Colors.grey,
                                  decoration: TextDecoration.underline)),
                        ],
                      )
                    ],
                  ).paddingSymmetric(horizontal: 16),
                )).expand()
          ],
        ),
      ),
    );
  }
}
