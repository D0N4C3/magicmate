// ignore_for_file: file_names, unnecessary_brace_in_string_interps, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:magicmate_organizer/Bottombar_screen.dart';
import 'package:magicmate_organizer/Login_flow/Resend_Code.dart';
import 'package:magicmate_organizer/Login_flow/Sign_up.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/api_screens/data_store.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:magicmate_organizer/utils/Fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String loginpage = "";
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        exit(0);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: WhiteColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: InkWell(
            onTap: () {
              Get.to(() => Singup());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an account?",
                  style: TextStyle(
                      fontFamily: FontFamily.gilroyMedium,
                      color: greycolor,
                      fontSize: 16),
                ),
                SizedBox(width: Get.width * 0.01),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      fontFamily: FontFamily.gilroyBold,
                      color: appcolor,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Positioned(
                  right: 0,
                  child: Image.asset("assets/pattern.png",
                      height: 170, width: 170)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.12),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/Logo1.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    // SizedBox(height: Get.height * 0.015),
                    Text(
                      "Welcome Back! 👋",
                      style: TextStyle(
                          fontFamily: FontFamily.gilroyBold,
                          color: BlackColor,
                          fontSize: 22),
                    ),
                    SizedBox(height: Get.height * 0.005),
                    Text(
                      "Sign in to your account",
                      style: TextStyle(
                          fontFamily: FontFamily.gilroyMedium,
                          color: greycolor,
                          fontSize: 16),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    // Text(
                    //   "Enter Email",
                    //   style: TextStyle(
                    //       fontFamily: FontFamily.gilroyBold,
                    //       color: greycolor,
                    //       fontSize: 16),
                    // ),
                    // SizedBox(height: Get.height * 0.01),
                    passwordtextfield(
                      controller: email,
                      lebaltext: "Email",
                      prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset("assets/mail.png",
                              height: 30, width: 30, color: greycolor)),
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: Get.height * 0.03),
                    // Text(
                    //   "Enter Password",
                    //   style: TextStyle(
                    //       fontFamily: FontFamily.gilroyBold,
                    //       color: greycolor,
                    //       fontSize: 16),
                    // ),
                    // SizedBox(height: Get.height * 0.01),
                    passwordtextfield(
                      lebaltext: "Password",
                      controller: password,
                      obscureText: _obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                      prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset("assets/lock.png",
                              height: 30, width: 30, color: greycolor)),
                      suffixIcon: InkWell(
                          onTap: () {
                            _toggle();
                          },
                          child: !_obscureText
                              ? Icon(
                                  Icons.visibility,
                                  color: appcolor,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: greycolor,
                                )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Theme(
                              data: ThemeData(unselectedWidgetColor: greycolor),
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                value: isChecked,
                                activeColor: appcolor,
                                checkColor: WhiteColor,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value!;
                                    save("Remember", value);
                                  });
                                },
                              ),
                            ),
                            Text(
                              "Remember Me",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Gilroy Bold",
                                  color: BlackColor),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => ResendCode());
                          },
                          child: Center(
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  color: appcolor,
                                  fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.1),
                    AppButton(
                        buttontext: "Login",
                        textcolor: WhiteColor,
                        onTap: () {
                          if ((_formKey.currentState?.validate() ?? false)) {
                            initPlatformState();
                            login(email.text, password.text);
                          }
                        },
                        gradientcolor: gradient.btnGradient),
                    SizedBox(height: Get.height * 0.03),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login(String email, String password) async {
    try {
      Map map = {"email": email, "password": password};
      Uri uri = Uri.parse(AppUrl.login);
      var response = await http.post(uri, body: jsonEncode(map));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        loginpage = result["Result"];
        save("Firstuser", true);
        setState(() {
          save("UserLogin", result["OragnizerLogin"]);
          // currency = result["currency"];
          save("currency", result["currency"]);
        });
        print("*********************${loginpage}");

        if (loginpage == "true") {
          Get.to(() => BottoBarScreen());
          OneSignal.User.addTagWithKey("orag_id", getData.read("UserLogin")["id"]);
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        } else {
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        }
      }
      // update();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> initPlatformState() async {
    OneSignal.initialize(AppUrl.oneSignel);
    OneSignal.Notifications.addPermissionObserver((state) {
      print("Has permission " + state.toString());
    });
    // print("--------------__uID : ${getData.read("UserLogin")["id"]}");
  }
}
