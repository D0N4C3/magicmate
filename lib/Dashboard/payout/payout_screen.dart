// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps, sort_child_properties_last, non_constant_identifier_names, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:magicmate_organizer/Getx_controller.dart/Dashboard_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/payout_controller.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:magicmate_organizer/utils/Fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPayoutScreen extends StatefulWidget {
  String? status;
  MyPayoutScreen({super.key, this.status});

  @override
  State<MyPayoutScreen> createState() => _MyPayoutScreenState();
}

List<String> payType = ["UPI", "BANK Transfer", "Paypal"];

class _MyPayoutScreenState extends State<MyPayoutScreen> {
  // DashBoardController dashBoardController = Get.find();
  DashboardController dashboardController = Get.find();
  PayOutController payOutController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectType;

  @override
  void initState() {
    super.initState();
    payOutController.getPayOutList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: AppBar(
        backgroundColor: WhiteColor,
        elevation: 0,
        centerTitle: widget.status == "1" ? false : true,
        leading: widget.status == "1"
            ? BackButton(
                color: BlackColor,
                onPressed: () {
                  Get.back();
                },
              )
            : SizedBox(),
        title: Text(
          "Payout".tr,
          style: TextStyle(
            color: BlackColor,
            fontFamily: FontFamily.gilroyBold,
            fontSize: 17,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 2),
            () {
              payOutController.getPayOutList();
            },
          );
        },
        child: SizedBox(
          height: Get.size.height,
          width: Get.size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height * 0.28,
                width: Get.size.width,
                margin: EdgeInsets.only(left: 15, top: 15, right: 15),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 15),
                      child: Text(
                        "Payout".tr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: FontFamily.gilroyBold,
                          color: WhiteColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Text(
                        "${currency}${dashboardController.payOut}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 45,
                          fontFamily: FontFamily.gilroyBold,
                          color: WhiteColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 15),
                      child: Text(
                        "Your total earning".tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: FontFamily.gilroyBold,
                          color: WhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/Card.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 25),
                child: Text(
                  "History".tr,
                  style: TextStyle(
                    fontSize: 17,
                    color: BlackColor,
                    fontFamily: FontFamily.gilroyMedium,
                  ),
                ),
              ),
              Expanded(
                child: GetBuilder<PayOutController>(builder: (context) {
                  return payOutController.isLoading
                      ? payOutController.payoutInfo!.payoutlist.isNotEmpty
                          ? ListView.builder(
                              itemCount: payOutController
                                  .payoutInfo?.payoutlist.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.bottomSheet(
                                      Container(
                                        height: Get.size.height * 0.5,
                                        width: Get.size.width,
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Payout Request".tr,
                                                style: TextStyle(
                                                  color: BlackColor,
                                                  fontFamily:
                                                      FontFamily.gilroyBold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              detailsRow(
                                                detailsName: "Status",
                                                value: payOutController
                                                    .payoutInfo
                                                    ?.payoutlist[index]
                                                    .status,
                                                color: payOutController
                                                            .payoutInfo
                                                            ?.payoutlist[index]
                                                            .status ==
                                                        "pending"
                                                    ? Colors.red
                                                    : Color(0xFF398B2B),
                                              ),
                                              detailsRow(
                                                detailsName:
                                                    "Transaction Date".tr,
                                                value: payOutController
                                                    .payoutInfo
                                                    ?.payoutlist[index]
                                                    .rDate
                                                    .toString(),
                                                color: BlackColor,
                                              ),
                                              payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .upiId !=
                                                      ""
                                                  ? detailsRow(
                                                      detailsName:
                                                          "Payment Method".tr,
                                                      value: payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .upiId,
                                                      color: BlackColor,
                                                    )
                                                  : SizedBox(),
                                              payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .accNumber !=
                                                      ""
                                                  ? detailsRow(
                                                      detailsName:
                                                          "Account Number".tr,
                                                      value: payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .accNumber,
                                                      color: BlackColor,
                                                    )
                                                  : SizedBox(),
                                              payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .accName !=
                                                      ""
                                                  ? detailsRow(
                                                      detailsName:
                                                          "Account holder name"
                                                              .tr,
                                                      value: payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .accName,
                                                      color: BlackColor,
                                                    )
                                                  : SizedBox(),
                                              payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .bankName !=
                                                      ""
                                                  ? detailsRow(
                                                      detailsName:
                                                          "Bank Name".tr,
                                                      value: payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .bankName,
                                                      color: BlackColor,
                                                    )
                                                  : SizedBox(),
                                              payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .ifscCode !=
                                                      ""
                                                  ? detailsRow(
                                                      detailsName:
                                                          "Bank IFSC".tr,
                                                      value: payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .ifscCode,
                                                      color: BlackColor,
                                                    )
                                                  : SizedBox(),
                                              payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .paypalId !=
                                                      ""
                                                  ? detailsRow(
                                                      detailsName:
                                                          "Payment Method",
                                                      value: payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .paypalId,
                                                      color: BlackColor,
                                                    )
                                                  : SizedBox(),
                                              Container(
                                                height: 40,
                                                width: Get.size.width,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Total".tr,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF808080),
                                                        fontFamily: FontFamily
                                                            .gilroyBold,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      "${currency}${payOutController.payoutInfo?.payoutlist[index].amt}",
                                                      style: TextStyle(
                                                        color: BlackColor,
                                                        fontFamily: FontFamily
                                                            .gilroyBold,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    )
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade200),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .proof !=
                                                      null
                                                  ? Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      margin: EdgeInsets.only(
                                                          left: 15),
                                                      child: Text(
                                                        "Payout Proof".tr,
                                                        style: TextStyle(
                                                          color: BlackColor,
                                                          fontFamily: FontFamily
                                                              .gilroyBold,
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .proof !=
                                                      null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Image.network(
                                                        "${AppUrl.imageurl}${payOutController.payoutInfo?.payoutlist[index].proof}",
                                                        width: Get.size.width,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: WhiteColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: ListTile(
                                      leading: Container(
                                        height: 70,
                                        width: 60,
                                        padding: EdgeInsets.all(12),
                                        child: Image.asset(
                                          "assets/Wallet.png",
                                          color: appcolor,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xFFf6f7f9),
                                        ),
                                      ),
                                      title: Text(
                                        payOutController.payoutInfo
                                                ?.payoutlist[index].rDate
                                                .toString() ??
                                            "",
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: BlackColor,
                                          fontFamily: FontFamily.gilroyBold,
                                          // fontSize: 16,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            payOutController.payoutInfo
                                                    ?.payoutlist[index].rType
                                                    .toString() ??
                                                "",
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: BlackColor,
                                              fontFamily:
                                                  FontFamily.gilroyMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            payOutController
                                                    .payoutInfo
                                                    ?.payoutlist[index]
                                                    .status ??
                                                "",
                                            style: TextStyle(
                                              color: payOutController
                                                          .payoutInfo
                                                          ?.payoutlist[index]
                                                          .status ==
                                                      "pending"
                                                  ? Colors.red
                                                  : Color(0xFF398B2B),
                                              fontFamily:
                                                  FontFamily.gilroyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "${payOutController.payoutInfo?.payoutlist[index].amt}${currency}",
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            color: payOutController
                                                        .payoutInfo
                                                        ?.payoutlist[index]
                                                        .status ==
                                                    "pending"
                                                ? Colors.red
                                                : Color(0xFF398B2B),
                                          ),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade200),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/28.png",
                                    height: 110,
                                    width: 100,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Go & Request your Payout".tr,
                                    style: TextStyle(
                                      color: greycolor,
                                      fontFamily: FontFamily.gilroyBold,
                                    ),
                                  )
                                ],
                              ),
                            )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                }),
              ),
              GestButton(
                Width: Get.size.width,
                height: 50,
                // buttoncolor: appcolor,
                margin: EdgeInsets.only(top: 15, left: 35, right: 35),
                buttontext: "Request".tr,
                gradient: gradient.btnGradient,
                style: TextStyle(
                  fontFamily: FontFamily.gilroyBold,
                  color: WhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                onclick: () {
                  requestSheet();
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailsRow({String? detailsName, value, Color? color}) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Text(
              detailsName ?? "",
              style: TextStyle(
                color: Color(0xFF808080),
                fontFamily: FontFamily.gilroyMedium,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            Spacer(),
            Text(
              value ?? "",
              style: TextStyle(
                color: color,
                fontFamily: FontFamily.gilroyBold,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Future<void> requestSheet() {
    return Get.bottomSheet(
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Form(
          key: _formKey,
          child: Container(
            height: Get.size.height * 0.6,
            width: Get.size.width,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Payout Request".tr,
                    style: TextStyle(
                      color: BlackColor,
                      fontFamily: FontFamily.gilroyBold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${"Minimum amount:".tr} ${dashboardController.dashboardinfo?.withdrawLimit}${currency}",
                    style: TextStyle(
                      color: BlackColor,
                      fontFamily: FontFamily.gilroyMedium,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  textfield(
                    controller: payOutController.amount,
                    labelText: "Amount".tr,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Amount'.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      "Select Type".tr,
                      style: TextStyle(
                        fontFamily: FontFamily.gilroyBold,
                        fontSize: 16,
                        color: BlackColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 60,
                    width: Get.size.width,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: DropdownButton(
                      dropdownColor: WhiteColor,
                      hint: Text(
                        "Select Type".tr,
                        style: TextStyle(color: Colors.grey),
                      ),
                      value: selectType,
                      icon: Image.asset(
                        'assets/Arrowdown.png',
                        height: 20,
                        width: 20,
                        color: BlackColor,
                      ),
                      isExpanded: true,
                      underline: SizedBox.shrink(),
                      items:
                          payType.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: BlackColor,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectType = value ?? "";
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      color: WhiteColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  selectType == "UPI"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                "UPI".tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  fontSize: 16,
                                  color: BlackColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            textfield(
                              controller: payOutController.upi,
                              labelText: "UPI".tr,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter UPI'.tr;
                                }
                                return null;
                              },
                            )
                          ],
                        )
                      : selectType == "BANK Transfer"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Account Number".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      fontSize: 16,
                                      color: BlackColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                textfield(
                                  controller: payOutController.accountNumber,
                                  labelText: "Account Number".tr,
                                  textInputType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Account Number'.tr;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Bank Name".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      fontSize: 16,
                                      color: BlackColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                textfield(
                                  controller: payOutController.bankName,
                                  labelText: "Bank Name".tr,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Bank Name'.tr;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Account Holder Name".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      fontSize: 16,
                                      color: BlackColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                textfield(
                                  controller:
                                      payOutController.accountHolderName,
                                  labelText: "Account Holder Name".tr,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Account Holder Name'
                                          .tr;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "IFSC Code".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      fontSize: 16,
                                      color: BlackColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                textfield(
                                  controller: payOutController.ifscCode,
                                  labelText: "IFSC Code".tr,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter IFSC Code'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )
                          : selectType == "Paypal"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Email ID".tr,
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          fontSize: 16,
                                          color: BlackColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    textfield(
                                      controller: payOutController.ifscCode,
                                      labelText: "Email Id".tr,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Paypal id'.tr;
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                )
                              : Container(),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            payOutController.emptyDetails();
                            Get.back();
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.all(15),
                            alignment: Alignment.center,
                            child: Text(
                              "Cancel".tr,
                              style: TextStyle(
                                color: blueColor,
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 16,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFeef4ff),
                              borderRadius: BorderRadius.circular(45),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (selectType != null) {
                                payOutController.requestWithdraweApi(
                                  rType: selectType,
                                );
                              } else {
                                ApiWrapper.showToastMessage(
                                    "Please Select Type".tr);
                              }
                            }
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.all(15),
                            alignment: Alignment.center,
                            child: Text(
                              "Proceed".tr,
                              style: TextStyle(
                                color: WhiteColor,
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 16,
                              ),
                            ),
                            decoration: BoxDecoration(
                              // color: appcolor,
                              gradient: gradient.btnGradient,
                              borderRadius: BorderRadius.circular(45),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: WhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        );
      }),
    );
  }

  textfield(
      {String? type,
      labelText,
      prefixtext,
      suffix,
      Color? labelcolor,
      prefixcolor,
      floatingLabelColor,
      focusedBorderColor,
      TextDecoration? decoration,
      bool? readOnly,
      double? Width,
      int? max,
      TextEditingController? controller,
      TextInputType? textInputType,
      Function(String)? onChanged,
      String? Function(String?)? validator,
      Height}) {
    return Container(
      height: Height,
      width: Width,
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: WhiteColor),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: BlackColor,
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: max,
        readOnly: readOnly ?? false,
        style: TextStyle(
            color: BlackColor,
            fontFamily: FontFamily.gilroyMedium,
            fontSize: 18),
        decoration: InputDecoration(
          hintText: labelText,
          hintStyle: TextStyle(
              color: Colors.grey, fontFamily: "Gilroy Medium", fontSize: 16),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: blueColor),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
