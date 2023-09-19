import 'package:beauty_master/common/common_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/BMSocialIconsLoginComponents.dart';
import '../main.dart';
import '../utils/BMColors.dart';
import '../utils/BMWidgets.dart';
import 'BMDashboardScreen.dart';
import 'BMForgetPasswordScreen.dart';
import 'BMRegisterScreen.dart';

class BMLoginScreen extends StatefulWidget {
  const BMLoginScreen({Key? key}) : super(key: key);

  @override
  State<BMLoginScreen> createState() => _BMLoginScreenState();
}

class _BMLoginScreenState extends State<BMLoginScreen> {
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

  Future<void> signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
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
              child: headerText(title: 'Login'),
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
                        Text('Not a member yet?',
                            style: boldTextStyle(
                                color: appStore.isDarkModeOn
                                    ? bmTextColorDarkMode
                                    : bmSpecialColorDark)),
                        TextButton(
                          onPressed: () {
                            BMRegisterScreen().launch(context);
                          },
                          child: Text(
                            'Register Now',
                            style: boldTextStyle(
                                color: appStore.isDarkModeOn
                                    ? bmPrimaryColor
                                    : bmGreyColor),
                          ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Password',
                            style: primaryTextStyle(
                                color: appStore.isDarkModeOn
                                    ? bmTextColorDarkMode
                                    : bmSpecialColor,
                                size: 14)),
                        TextButton(
                          onPressed: () {
                            BMForgetPasswordScreen().launch(context);
                          },
                          child: Text('Forgot Password',
                              style: boldTextStyle(
                                  color: appStore.isDarkModeOn
                                      ? bmPrimaryColor
                                      : bmGreyColor,
                                  size: 14)),
                        )
                      ],
                    ),
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
                    Row(
                      children: [
                        AppButton(
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          child: Text('Login',
                              style: boldTextStyle(color: Colors.white)),
                          padding: EdgeInsets.all(16),
                          color: bmPrimaryColor,
                          onTap: () async {
                            if (globalKey.currentState!.validate()) {
                              try {
                                await signIn();
                                BMDashboardScreen(flag: false).launch(context);
                              } catch (e) {
                                FlutterToast().showMessage(
                                    "please input valid email or password");
                              }
                            }
                          },
                        ).expand(),
                        16.width,
                        AppButton(
                          height: 40,
                          width: 40,
                          child:
                              Icon(Icons.qr_code_scanner_rounded, color: white),
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          padding: EdgeInsets.all(16),
                          color: Colors.grey,
                          onTap: () {
                            FlutterToast().showMessage(
                                "This Feature is Under Development");
                          },
                        ),
                      ],
                    ),
                    30.height,
                    Text(
                      'or login with',
                      style: secondaryTextStyle(
                          color: appStore.isDarkModeOn
                              ? bmTextColorDarkMode
                              : bmSpecialColorDark),
                    ).center(),
                    30.height,
                    BMSocialIconsLoginComponents().center(),
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
