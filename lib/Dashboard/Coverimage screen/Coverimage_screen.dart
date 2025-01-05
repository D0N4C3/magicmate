// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:magicmate_organizer/Dashboard/Coverimage%20screen/Addcoverimage_screen.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Add_extra_image_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Extra_image_controller.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:magicmate_organizer/utils/Fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api_screens/confrigation.dart';

class Coverimagescreen extends StatefulWidget {
  const Coverimagescreen({super.key});

  @override
  State<Coverimagescreen> createState() => _CoverimagescreenState();
}

class _CoverimagescreenState extends State<Coverimagescreen> {
  CoverimageController coverimageController = Get.find();
  AddcoverimageController addcoverimageController = Get.find();
  @override
  void initState() {
    super.initState();
    // coverimageController.coverimagelist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: CustomAppbar(
          onTap: () {
            Get.to(() => AddcoverimageScreen(
                  add: "Add",
                ));
          },
          title: "Cover Image"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.02),
              GetBuilder<CoverimageController>(builder: (context) {
                return coverimageController.isLoading
                    ? coverimageController.coverimageinfo!.extralist.isNotEmpty
                        ? ListView.builder(
                            itemCount: coverimageController
                                .coverimageinfo?.extralist.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 125,
                                      width: Get.size.width,
                                      margin: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 125,
                                                width: 110,
                                                margin: EdgeInsets.all(10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.network(
                                                    "${AppUrl.imageurl}${coverimageController.coverimageinfo?.extralist[index].image ?? ""}",
                                                    height: 140,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 30),
                                                        child: Text(
                                                          coverimageController
                                                                  .coverimageinfo
                                                                  ?.extralist[
                                                                      index]
                                                                  .eventTitle ??
                                                              "",
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                FontFamily
                                                                    .gilroyBold,
                                                            color: BlackColor,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height: Get.height * 0.015),
                                                Row(
                                                  children: [
                                                    coverimageController
                                                                .coverimageinfo
                                                                ?.extralist[
                                                                    index]
                                                                .status ==
                                                            "0"
                                                        ? Text(
                                                            "UnPublish",
                                                            style: TextStyle(
                                                              color: greycolor,
                                                              fontFamily: FontFamily
                                                                  .gilroyMedium,
                                                            ),
                                                          )
                                                        : Text(
                                                            "Publish",
                                                            style: TextStyle(
                                                              color: greycolor,
                                                              fontFamily: FontFamily
                                                                  .gilroyMedium,
                                                            ),
                                                          ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8),
                                                      child: Column(
                                                        children: [],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade200),
                                        color: WhiteColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => AddcoverimageScreen(
                                                add: "edit",
                                                eventId: coverimageController
                                                    .coverimageinfo
                                                    ?.extralist[index]
                                                    .eventId,
                                                eventName: coverimageController
                                                        .coverimageinfo
                                                        ?.extralist[index]
                                                        .eventTitle ??
                                                    "",
                                              ),
                                            );
                                            addcoverimageController
                                                .getIdAndName(
                                              mid1: coverimageController
                                                  .coverimageinfo
                                                  ?.extralist[index]
                                                  .image,
                                              recId: coverimageController
                                                  .coverimageinfo
                                                  ?.extralist[index]
                                                  .id,
                                            );
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            padding: EdgeInsets.all(9),
                                            alignment: Alignment.center,
                                            child:
                                                Image.asset("assets/Pen.png"),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: gradient.btnGradient,
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.35),
                            child: Center(
                              child: Text(
                                "Extra image is not found",
                                style: TextStyle(
                                    color: greycolor,
                                    fontFamily: FontFamily.gilroyBold,
                                    fontSize: 16),
                              ),
                            ),
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
    );
  }
}
