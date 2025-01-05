// ignore_for_file: non_constant_identifier_names, avoid_print, file_names, prefer_const_constructors, unnecessary_string_interpolations, unused_element, must_be_immutable, unused_import, prefer_const_constructors_in_immutables, deprecated_member_use, unused_local_variable, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:io';
import 'package:magicmate_organizer/Login_flow/Login_screen.dart';
import 'package:magicmate_organizer/Login_flow/Verify_Account.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/api_screens/data_store.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;

class Singup extends StatefulWidget {
  static String verify = "";
  Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final FullName = TextEditingController();
  final Email = TextEditingController();
  final Password = TextEditingController();
  final Countrycode = TextEditingController();
  final Mobile = TextEditingController();
  String mobilecheck = "";
  String base64Image = "";

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String Country = "";
  String pagerought = "";
  final _formKey = GlobalKey<FormState>();
  String? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SizedBox(
          height: Get.height * 0.12,
          child: Column(
            children: [
              AppButton(
                buttonColor: orangeColor,
                gradientcolor: gradient.btnGradient,
                buttontext: "Sign up",
                textcolor: WhiteColor,
                onTap: () async {
                  if ((_formKey.currentState?.validate() ?? false)) {
                    if (path != null) {
                      checkMobileNumber(Mobile.text, Country);
                    } else {
                      ApiWrapper.showToastMessage("Please Upload Image!");
                    }
                  }
                },
              ),
              SizedBox(height: Get.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account?",
                    style: TextStyle(
                        fontFamily: "Gilroy Medium",
                        color: BlackColor,
                        fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const LoginScreen());
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                          fontFamily: "Gilroy Bold",
                          color: appcolor,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: appbar(title: "Sign Up"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.02),
                InkWell(
                  onTap: () {
                    _openGallery(context);
                  },
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          height: 170,
                          width: 170,
                          alignment: Alignment.center,
                          child: Container(
                            height: 135,
                            width: 135,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: WhiteColor,
                              image: path == null
                                  ? DecorationImage(
                                      image: AssetImage("assets/Ellipse.png"),
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(path ?? ""),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 15,
                          child: Container(
                            height: 45,
                            width: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: appcolor),
                            child: Image.asset("assets/Pen.png",
                                height: 25, width: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // : Center(
                //     child: CircleAvatar(
                //       radius: 40,
                //       backgroundImage: FileImage(
                //         File(path ?? ""),
                //       ),
                //       // child: Image.file(
                //       //   File(),
                //       //   height: 100,
                //       //   width: double.infinity,
                //       // ),
                //     ),
                //   ),
                SizedBox(height: Get.height * 0.02),
                SizedBox(
                  width: Get.width * 0.70,
                  child: Text(
                    "Welcome Back! 👋",
                    style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        color: BlackColor,
                        fontSize: 22),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                SizedBox(
                  width: Get.width * 0.70,
                  child: Text(
                    "Sign up to your account",
                    style: TextStyle(
                        fontFamily: "Gilroy Medium",
                        color: greycolor,
                        fontSize: 16),
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                IntlPhoneField(
                  keyboardType: TextInputType.number,
                  controller: Mobile,
                  cursorColor: const Color(0xff4361EE),
                  disableLengthCheck: true,
                  dropdownTextStyle: TextStyle(color: BlackColor, fontSize: 16),
                  style:
                      TextStyle(fontFamily: "Gilroy Medium", color: BlackColor),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
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
                    Country = phone.countryCode;
                    setState(() {});
                    print(phone.countryCode);
                  },
                ),
                SizedBox(height: Get.height * 0.02),
                passwordtextfield(
                    controller: FullName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Full name';
                      }
                      return null;
                    },
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/phonenum.png",
                          height: 25, width: 25),
                    ),
                    lebaltext: "Full Name",
                    suffixIcon: null,
                    obscureText: false),
                SizedBox(height: Get.height * 0.02),
                passwordtextfield(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    },
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                          Image.asset("assets/mail.png", height: 25, width: 25),
                    ),
                    controller: Email,
                    lebaltext: "Email address",
                    suffixIcon: null,
                    obscureText: false),
                SizedBox(height: Get.height * 0.02),
                passwordtextfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:
                        Image.asset("assets/lock.png", height: 25, width: 25),
                  ),
                  lebaltext: "Password",
                  controller: Password,
                  obscureText: _obscureText,
                  suffixIcon: InkWell(
                      onTap: () {
                        _toggle();
                      },
                      child: !_obscureText
                          ? Icon(
                              Icons.visibility,
                              color: orangeColor,
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
      ),
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
        if (mobilecheck == "true") {
          sendOTP(mobile, country);

          Get.to(() => VerifyAccount(
                ccode: country,
                number: mobile,
                Email: Email.text,
                FullName: FullName.text,
                Password: Password.text,
                Signup: "Signup",
                img: base64Image,
              ));
        }
        ApiWrapper.showToastMessage(result["ResponseMsg"]);
      }
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  void _openGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      path = pickedFile.path;
      setState(() {});
      File imageFile = File(path.toString());
      List<int> imageBytes = imageFile.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      // loginController.updateProfileImage(base64Image);
      setState(() {});
    }
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
}
