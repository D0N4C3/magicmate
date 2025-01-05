// ignore_for_file: file_names, unused_catch_clause, non_constant_identifier_names, avoid_print, unused_import, unused_field, prefer_final_fields, prefer_const_constructors, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:magicmate_organizer/Bottombar_screen.dart';
import 'package:magicmate_organizer/Login_flow/Forgot_Password.dart';
import 'package:magicmate_organizer/Login_flow/Sign_up.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/api_screens/data_store.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class VerifyAccount extends StatefulWidget {
  String? ccode;
  String? number;
  String? FullName;
  String? Email;
  String? Password;
  String? Signup;
  String? img;

  VerifyAccount(
      {this.FullName,
        this.Email,
        this.Password,
        this.ccode,
        this.number,
        this.Signup,
        this.img,
        super.key});

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final pinController = TextEditingController();
  String code = "";

  String Country = "";
  String pagerought = "";
  String _verificationId = "";
  int? _resendToken;
  String verrification = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      verrification = widget.Signup ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: AppButton(
          gradientcolor: gradient.btnGradient,
          buttontext: "Verify Account",
          textcolor: WhiteColor,
          onTap: () async {
            try {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: Singup.verify, smsCode: code);
              await auth.signInWithCredential(credential);
              print("&&&&&&&&&&&&&&&&&&&&&&&&&&&${verrification}");
              if (verrification == "Signup") {
                Register(
                    widget.FullName ?? "",
                    widget.Email ?? "",
                    widget.number ?? "",
                    widget.ccode ?? "",
                    widget.img ?? "",
                    widget.Password ?? "");

                initPlatformState();
              } else {
                Get.to(() => ForgotPassword(
                  ccode: widget.ccode,
                  mobileNo: widget.number,
                ));
              }

              ApiWrapper.showToastMessage("Verification successfull");
            } catch (e) {
              ApiWrapper.showToastMessage("Please Enter Valid OTP");
            }
            // Get.to(() => ForgotPassword(
            //       ccode: widget.ccode,
            //       mobileNo: widget.number,
            //     ));
          },
        ),
      ),
      appBar: appbar(title: "Verify Otp"),
      backgroundColor: WhiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.05),
            Text(
              "Verify Account",
              style: TextStyle(
                  fontFamily: "Gilroy Bold", color: BlackColor, fontSize: 22),
            ),
            SizedBox(height: Get.height * 0.02),
            SizedBox(
              width: Get.width * 0.80,
              child: RichText(
                text: TextSpan(
                  text:
                  "Please, enter the verification code we send to your mobile",
                  style: TextStyle(
                      fontFamily: "Gilroy Medium",
                      color: greycolor,
                      fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                        text: "  ${widget.ccode} ${widget.number}",
                        style: TextStyle(
                            fontFamily: "Gilroy Bold",
                            fontSize: 16,
                            color: BlackColor)),
                  ],
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                cursorColor: appcolor,
                cursorHeight: 18,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 45,
                  fieldWidth: 45,
                  inactiveColor: appcolor,
                  activeColor: appcolor,
                  selectedColor: appcolor,
                  activeFillColor: Colors.white,
                  inactiveFillColor: WhiteColor,
                  selectedFillColor: WhiteColor,
                  borderWidth: 1,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: WhiteColor,
                enableActiveFill: true,
                controller: pinController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your otp'.tr;
                  }
                  return null;
                },
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  code = value;
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  return true;
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 4),
            //   child: Pinput(
            //     length: 6,
            //     controller: pinController,
            //     submittedPinTheme: PinTheme(
            //         width: 56,
            //         height: 56,
            //         textStyle: TextStyle(
            //             fontSize: 20,
            //             color: BlackColor,
            //             fontFamily: "Gilroy Bold"),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             border: Border.all(color: appcolor))),
            //     defaultPinTheme: PinTheme(
            //       width: 56,
            //       height: 56,
            //       textStyle: TextStyle(
            //           fontSize: 20,
            //           color: BlackColor,
            //           fontFamily: "Gilroy Bold"),
            //       decoration: BoxDecoration(
            //           color: WhiteColor,
            //           borderRadius: BorderRadius.circular(10),
            //           border: Border.all(color: greycolor.withOpacity(0.5))),
            //     ),
            //     errorText: 'Wrong otp',
            //     onChanged: (value) {
            //       code = value;
            //     },
            //   ),
            // ),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () {
                sendOTP(phone: widget.number ?? "", Countrycode: widget.ccode);
                // print("########################${widget.number}");
                // print("########################${widget.ccode}");
              },
              child: Text(
                "Resend code?",
                style: TextStyle(
                    fontFamily: "Gilroy Bold", color: BlackColor, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Register(String fullname, String email, String mobile, String Country,
      String img, String password) async {
    try {
      Map map = {
        "name": fullname,
        "email": email,
        "mobile": mobile,
        "ccode": Country,
        "password": password,
        "img": img
      };
      print("perametter${map.toString()}");
      Uri uri = Uri.parse(AppUrl.baseUrl + AppUrl.userregister);
      print("url====-----$uri");
      var response = await http.post(uri, body: jsonEncode(map));
      print("************response*********${response.body.toString()}");
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("************response200*********${result.toString()}");
        pagerought = result["Result"];
        save("UserLogin", result["OragnizerLogin"]);

        if (pagerought == "true") {
          Get.to(() => BottoBarScreen());
          OneSignal.User.addTagWithKey("orag_id", getData.read("UserLogin")["id"]);
        } else {
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        }
      }
      // update();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> sendOTP({required String phone, Countrycode}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: Countrycode + phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
        _resendToken = resendToken;
      },
      timeout: const Duration(seconds: 60),
      forceResendingToken: _resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = _verificationId;
      },
    );
    debugPrint("_verificationId: $_verificationId");
    return true;
  }

  Future<void> initPlatformState() async {
    OneSignal.initialize(AppUrl.oneSignel);
    OneSignal.Notifications.addPermissionObserver((state) {
      print("Has permission " + state.toString());
    });

    // OneSignal.shared
    //     .promptUserForPushNotificationPermission()
    //     .then((accepted) {});
    // OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    //   print("Accepted OSPermissionStateChanges : $changes");
    // });
    // print("--------------__uID : ${getData.read("UserLogin")["id"]}");

    await OneSignal.User.addTagWithKey("user_id", getData.read("UserLogin")["id"]);
  }
}
