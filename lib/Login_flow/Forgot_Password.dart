// ignore_for_file: file_names, non_constant_identifier_names, unused_element, must_be_immutable, unused_field, unnecessary_brace_in_string_interps, avoid_print, unused_import

import 'dart:convert';

import 'package:magicmate_organizer/Login_flow/Login_screen.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  String? mobileNo;
  String? ccode;
  ForgotPassword({this.mobileNo, this.ccode, super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final Newpassword = TextEditingController();
  final password = TextEditingController();
  final Mobile = TextEditingController();
  final Email = TextEditingController();
  final Password = TextEditingController();
  bool _obscureText = true;
  bool _obscureText1 = true;
  String mobilecheck = "";
  String forgotpass = "";
  String Country = "";
  final _formKey = GlobalKey<FormState>();
  String forgetPasswprdResult = "";
  String forgetMsg = "";
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: AppButton(
          gradientcolor: gradient.btnGradient,
          buttontext: "Reset Password",
          textcolor: WhiteColor,
          onTap: () {
            if ((_formKey.currentState?.validate() ?? false)) {
              if (Newpassword.text == password.text) {
                ForgetPasswordApi(ccode: widget.ccode, mobile: widget.mobileNo);
              } else {
                ApiWrapper.showToastMessage("please valid password");
              }
            }
          },
        ),
      ),
      appBar: appbar(title: "Forgot Password"),
      backgroundColor: WhiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.05),
              SizedBox(
                width: Get.width * 0.70,
                child: Text(
                  "Create Your New Password",
                  style: TextStyle(
                      fontFamily: "Gilroy Bold",
                      color: BlackColor,
                      fontSize: 22),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              SizedBox(
                width: Get.width * 0.80,
                child: Text(
                  "Your new password must be different from previous password.",
                  style: TextStyle(
                      fontFamily: "Gilroy Medium",
                      color: greycolor,
                      fontSize: 16),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              passwordtextfield(
                lebaltext: "New Password",
                controller: Newpassword,
                obscureText: _obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Password';
                  }
                  return null;
                },
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset("assets/lock.png", height: 25, width: 25),
                ),
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
              SizedBox(height: Get.height * 0.03),
              passwordtextfield(
                lebaltext: "Password",
                controller: password,
                obscureText: _obscureText1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Password';
                  }
                  return null;
                },
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset("assets/lock.png", height: 25, width: 25),
                ),
                suffixIcon: InkWell(
                    onTap: () {
                      _toggle1();
                    },
                    child: !_obscureText1
                        ? Icon(
                            Icons.visibility,
                            color: appcolor,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: greycolor,
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ForgetPasswordApi({
    String? mobile,
    String? ccode,
  }) async {
    try {
      Map map = {
        "mobile": mobile,
        "ccode": ccode,
        "password": Newpassword.text,
      };
      Uri uri = Uri.parse(AppUrl.baseUrl + AppUrl.forgotpassword);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        forgetPasswprdResult = result["Result"];
        forgetMsg = result["ResponseMsg"];
        if (forgetPasswprdResult == "true") {
          Get.to(() => const LoginScreen());
          ApiWrapper.showToastMessage(forgetMsg);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
