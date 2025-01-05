// ignore_for_file: sort_child_properties_last, prefer_const_constructors, file_names

import 'package:magicmate_organizer/Getx_controller.dart/Addeventtypeprice_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Eventtypeprice_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Listofevent_controller.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:magicmate_organizer/utils/Fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Addeventtypes.dart';

class Eventtypescreen extends StatefulWidget {
  const Eventtypescreen({super.key});

  @override
  State<Eventtypescreen> createState() => _EventtypescreenState();
}

class _EventtypescreenState extends State<Eventtypescreen> {
  EventtypepriceController eventtypepriceController = Get.find();
  AddeventtypepriceController addeventtypepriceController = Get.find();
  ListofeventController listofeventController = Get.find();

  @override
  void initState() {
    super.initState();
    // eventtypepriceController.eventtypeprice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Event Type & Price",
        onTap: () {
          listofeventController.listofevent();
          Get.to(() => Addeventtypes(
                edit: "Add",
              ));
        },
      ),
      backgroundColor: bgcolor,
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 2),
            () {
              setState(() {
                eventtypepriceController.eventtypeprice();
              });
            },
          );
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.02),
                GetBuilder<EventtypepriceController>(builder: (context) {
                  return eventtypepriceController.isLoading
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: eventtypepriceController
                              .eventtypepriceinfo?.typePricedata.length,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  // height: 70,
                                  width: Get.size.width,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        padding: EdgeInsets.all(13),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                            "assets/documentlist.png"),
                                        decoration: BoxDecoration(
                                            gradient: gradient.btnGradient,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.6,
                                              child: Text(
                                                eventtypepriceController
                                                        .eventtypepriceinfo
                                                        ?.typePricedata[index]
                                                        .eventTitle ??
                                                    "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                // faqsController
                                                //         .faqinfo?.faQdata[index].question ??
                                                //     "",
                                                style: TextStyle(
                                                  color: BlackColor,
                                                  fontFamily:
                                                      FontFamily.gilroyBold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height: Get.height * 0.005),
                                            Row(
                                              children: [
                                                Text(
                                                  "Type:",
                                                  // faqsController
                                                  //         .faqinfo?.faQdata[index].answer ??
                                                  //     "",
                                                  style: TextStyle(
                                                      color: BlackColor,
                                                      fontFamily:
                                                          FontFamily.gilroyBold,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                    width: Get.width * 0.02),
                                                Text(
                                                  eventtypepriceController
                                                          .eventtypepriceinfo
                                                          ?.typePricedata[index]
                                                          .type ??
                                                      "",
                                                  style: TextStyle(
                                                      color: BlackColor,
                                                      fontFamily: FontFamily
                                                          .gilroyMedium,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: Get.height * 0.007),
                                            Row(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Price:",
                                                        // faqsController
                                                        //         .faqinfo?.faQdata[index].answer ??
                                                        //     "",
                                                        style: TextStyle(
                                                            color: BlackColor,
                                                            fontFamily:
                                                                FontFamily
                                                                    .gilroyBold,
                                                            fontSize: 15),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              Get.width * 0.02),
                                                      Text(
                                                        eventtypepriceController
                                                                .eventtypepriceinfo
                                                                ?.typePricedata[
                                                                    index]
                                                                .price ??
                                                            "",
                                                        style: TextStyle(
                                                            color: BlackColor,
                                                            fontFamily: FontFamily
                                                                .gilroyMedium,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // SizedBox(width: Get.width * 0.25),
                                                SizedBox(
                                                  width: 70,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      eventtypepriceController
                                                                  .eventtypepriceinfo
                                                                  ?.typePricedata[
                                                                      index]
                                                                  .status ==
                                                              "1"
                                                          ? Text(
                                                              "Publish",
                                                              // faqsController
                                                              //         .faqinfo?.faQdata[index].answer ??
                                                              //     "",
                                                              style: TextStyle(
                                                                  color:
                                                                      appcolor,
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .gilroyMedium,
                                                                  fontSize: 15),
                                                            )
                                                          : Text(
                                                              "UnPublish",
                                                              // faqsController
                                                              //         .faqinfo?.faQdata[index].answer ??
                                                              //     "",
                                                              style: TextStyle(
                                                                  color:
                                                                      appcolor,
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .gilroyMedium,
                                                                  fontSize: 15),
                                                            ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade200),
                                      borderRadius: BorderRadius.circular(15),
                                      color: WhiteColor),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      addeventtypepriceController
                                          .getEditDetails(
                                        edescription: eventtypepriceController
                                            .eventtypepriceinfo
                                            ?.typePricedata[index]
                                            .description,
                                        eprice: eventtypepriceController
                                            .eventtypepriceinfo
                                            ?.typePricedata[index]
                                            .price,
                                        estatus: eventtypepriceController
                                            .eventtypepriceinfo
                                            ?.typePricedata[index]
                                            .status,
                                        etlimit: eventtypepriceController
                                            .eventtypepriceinfo
                                            ?.typePricedata[index]
                                            .tlimit,
                                        etype: eventtypepriceController
                                            .eventtypepriceinfo
                                            ?.typePricedata[index]
                                            .type,
                                        eventid: eventtypepriceController
                                            .eventtypepriceinfo
                                            ?.typePricedata[index]
                                            .id,
                                      );
                                      Get.to(
                                        () => Addeventtypes(
                                          edit: "edit",
                                          recordid: eventtypepriceController
                                              .eventtypepriceinfo
                                              ?.typePricedata[index]
                                              .id,
                                          eventname: eventtypepriceController
                                              .eventtypepriceinfo
                                              ?.typePricedata[index]
                                              .eventTitle,
                                          evevtid: eventtypepriceController
                                              .eventtypepriceinfo
                                              ?.typePricedata[index]
                                              .eventId,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      padding: EdgeInsets.all(9),
                                      alignment: Alignment.center,
                                      child: Image.asset("assets/Pen.png"),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: gradient.btnGradient,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        )
                      : SizedBox(
                          height: Get.size.height,
                          width: Get.size.width,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
