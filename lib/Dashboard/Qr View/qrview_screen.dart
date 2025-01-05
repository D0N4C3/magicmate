// ignore_for_file: unnecessary_this, prefer_interpolation_to_compose_strings, avoid_print, sort_child_properties_last, prefer_const_constructors, unnecessary_null_comparison, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:magicmate_organizer/Getx_controller.dart/eventdetails_controller.dart';
import 'package:magicmate_organizer/Model%20class/ticket_info.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/data_store.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:magicmate_organizer/utils/Fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrViewScreen extends StatefulWidget {
  const QrViewScreen({super.key});

  @override
  State<QrViewScreen> createState() => _QrViewScreenState();
}

class _QrViewScreenState extends State<QrViewScreen> {
  EventDetailsController eventDetailsController = Get.find();
  TextEditingController bookingId = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Barcode? result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  TicketInfo? ticketInfo;
  QRViewController? controller;
  int currentIndex = 0;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 1),
      () {
        if (getData.read("openCamera") == true) {
          print("::::::::::--------");
          controller?.resumeCamera();
          save("openCamera", false);
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: Get.size.height,
              width: Get.size.width,
              child: QRView(
                key: qrKey,
                onQRViewCreated: (QRViewController controller) {
                  setState(() {
                    this.controller = controller;
                  });
                  controller.scannedDataStream.listen((scanData) {
                    if (scanData.rawBytes!.isNotEmpty) {
                      controller.pauseCamera();
                      setState(() {
                        result = scanData;
                        var res1 = jsonDecode(result!.code.toString());
                        print(":::::::::::::::::" + res1.toString());
                        ticketInfo = TicketInfo.fromJson(res1);
                        eventDetailsController.qrCheckApi(
                          eventId: ticketInfo?.eventId,
                          oragId: ticketInfo?.orgnizerId,
                          ticketId: ticketInfo?.ticketId,
                          uId: ticketInfo?.uid,
                        );
                        print("..............." +
                            ticketInfo!.ticketId.toString());
                      });
                      controller.resumeCamera();
                    } else {
                      controller.resumeCamera();
                    }
                  });
                },
                overlay: QrScannerOverlayShape(
                  borderColor: appcolor,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 5,
                  cutOutSize: 200,
                ),
                onPermissionSet: (ctrl, p) =>
                    _onPermissionSet(context, ctrl, p),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                child: BackButton(
                  onPressed: () {
                    Get.back();
                  },
                  color: WhiteColor,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 10,
              right: 10,
              child: Container(
                height: 50,
                width: Get.size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                            controller?.resumeCamera();
                          });
                        },
                        child: Container(
                          height: 45,
                          margin: EdgeInsets.only(top: 4, bottom: 4, left: 4),
                          alignment: Alignment.center,
                          child: Text(
                            "Scan Code",
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: BlackColor,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: currentIndex == 0 ? WhiteColor : transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                            controller!.pauseCamera();
                            Get.defaultDialog(
                              backgroundColor: WhiteColor.withOpacity(0.5),
                              onWillPop: () async {
                                setState(() {
                                  currentIndex = 0;
                                  controller?.resumeCamera();
                                });
                                return Future.value(true);
                              },
                              contentPadding: EdgeInsets.only(
                                  left: 15, right: 15, bottom: 0),
                              title: "Enter booking ID",
                              titleStyle: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                letterSpacing: 2,
                              ),
                              content: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Text(
                                      "Enter the booking number from your \n booked e-ticket or scan the OR code",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyMedium,
                                        fontSize: 12,
                                        height: 1.2,
                                      ),
                                    ),
                                    textfield1(
                                      controller: bookingId,
                                      labelText: "Enter Booking ID".tr,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Booking ID'.tr;
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          Get.back();
                                          eventDetailsController
                                              .bookingIdVerifyApi(
                                                  bookingID: bookingId.text);
                                        }
                                      },
                                      child: Container(
                                        height: 45,
                                        width: Get.size.width,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                            left: 8, right: 8, top: 8),
                                        child: Text(
                                          "Verify",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            color: WhiteColor,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: appcolor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                        },
                        child: Container(
                          height: 45,
                          margin: EdgeInsets.only(top: 4, bottom: 4, right: 4),
                          alignment: Alignment.center,
                          child: Text(
                            "Enter Code",
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: BlackColor,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: currentIndex == 1 ? WhiteColor : transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ApiWrapper.showToastMessage("No Permissiom");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('no Permission')),
      // );
    }
  }
}
