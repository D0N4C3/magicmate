// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, unused_field, unused_import, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_final_fields

import 'dart:convert';

import 'package:magicmate_organizer/Login_flow/Sign_up.dart';
import 'package:magicmate_organizer/Login_flow/Verify_Account.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;

class ResendCode extends StatefulWidget {
  const ResendCode({super.key});

  @override
  State<ResendCode> createState() => _ResendCodeState();
}

class _ResendCodeState extends State<ResendCode> {
  final Email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final Mobile = TextEditingController();
  String mobilecheck = "";
  String Country = "";
  String _verificationId = "";
  int? _resendToken;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: AppButton(
          gradientcolor: gradient.btnGradient,
          buttontext: "Send OTP",
          textcolor: WhiteColor,
          onTap: () {
            checkMobileNumber(Mobile.text, Country);
            setState(() {
              // verifyotp = true;
            });
          },
        ),
      ),
      appBar: appbar(title: "Resend Code"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.05),
            Text(
              "Phone Number",
              style: TextStyle(
                  fontFamily: "Gilroy Bold", color: BlackColor, fontSize: 22),
            ),
            SizedBox(height: Get.height * 0.02),
            SizedBox(
              width: Get.width * 0.80,
              child: Text(
                "We will call or send SMS to confirm your number.",
                style: TextStyle(
                    fontFamily: "Gilroy Medium",
                    color: greycolor,
                    fontSize: 16),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            IntlPhoneField(
              keyboardType: TextInputType.number,
              controller: Mobile,
              dropdownTextStyle: TextStyle(color: BlackColor, fontSize: 16),
              style: TextStyle(fontFamily: "Gilroy Medium", color: BlackColor),
              cursorColor: const Color(0xff4361EE),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                fillColor: transparent,
                filled: true,
                hintText: 'Enter your Phone',
                hintStyle: const TextStyle(
                  fontFamily: 'Gilroy Medium',
                  // fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xffAAACAE),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffF3F3FA)),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: orangeColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: greycolor,
                    ),
                    borderRadius: BorderRadius.circular(15)),
              ),
              initialCountryCode: 'IN',
              invalidNumberMessage: 'please enter your phone number ',
              onChanged: (phone) {
                setState(() {
                  Country = phone.countryCode;
                  print(phone.countryCode);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendOTP(
    String phonNumber,
    String cuntryCode,
  ) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${cuntryCode + phonNumber}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + e.toString());
      },
      timeout: Duration(seconds: 60),
      codeSent: (String verificationId, int? resendToken) {
        Singup.verify = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  checkMobileNumber(String mobile, String country) async {
    try {
      Map map = {
        "ccode": country,
        "mobile": mobile,
      };
      print("-----------------==============" + map.toString());
      Uri uri = Uri.parse(AppUrl.baseUrl + AppUrl.mobilecheck);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        // userMessage = result["ResponseMsg"];
        mobilecheck = result["Result"];
        // print("MMMMMMMMMMMMMMMMMM" + userMessage);
        if (mobilecheck == "false") {
          sendOTP(mobile, country);

          Get.to(() => VerifyAccount(
                ccode: country,
                number: mobile,
                Email: Email.text,
                Signup: "ResendCode",
              ));
        }
        ApiWrapper.showToastMessage(result["ResponseMsg"]);
      }
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }
}
