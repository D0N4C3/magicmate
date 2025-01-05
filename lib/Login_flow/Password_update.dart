// ignore_for_file: file_names, unnecessary_brace_in_string_interps, avoid_print, must_be_immutable, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:magicmate_organizer/Login_flow/Login_screen.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordUpdate extends StatefulWidget {
  PasswordUpdate({super.key});

  @override
  State<PasswordUpdate> createState() => _PasswordUpdateState();
}

class _PasswordUpdateState extends State<PasswordUpdate> {
  String forgotpass = "";
  String Country = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: AppButton(
          buttonColor: BlackColor,
          buttontext: "Back to Login",
          onTap: () {
            Get.to(() => const LoginScreen());
          },
        ),
      ),
      appBar: appbar(title: "Password Update"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Center(
                child: Padding(
              padding: EdgeInsets.only(left: 45, top: Get.height * 0.05),
              child: Image.asset("assets/update.png", height: 200, width: 250),
            )),
            Text(
              "Password updated!",
              style: TextStyle(
                  fontFamily: "Gilroy Bold", color: BlackColor, fontSize: 20),
            ),
            SizedBox(height: Get.height * 0.02),
            SizedBox(
              width: Get.width * 0.70,
              child: Text(
                "Your password has been setup successfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Gilroy Medium  ",
                    color: greycolor,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
