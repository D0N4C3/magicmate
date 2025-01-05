// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:magicmate_organizer/Dashboard/Event%20Gallery/Addeventgallery_screen.dart';
import 'package:magicmate_organizer/Getx_controller.dart/gallery_controller.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:magicmate_organizer/utils/Fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Eventgalleryscreen extends StatefulWidget {
  const Eventgalleryscreen({super.key});

  @override
  State<Eventgalleryscreen> createState() => _EventgalleryscreenState();
}

class _EventgalleryscreenState extends State<Eventgalleryscreen> {
  GalleryController galleryController = Get.find();

  @override
  void initState() {
    super.initState();
    // extraimageController.extraimage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: CustomAppbar(
          onTap: () {
            Get.to(() => Addeventgalleryscreen(
                  add: "Add",
                ));
          },
          title: "Event Gallery"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.02),
              GetBuilder<GalleryController>(builder: (context) {
                return galleryController.isLoading
                    ? galleryController.galleryInfo!.gallerydata.isNotEmpty
                        ? ListView.builder(
                            itemCount: galleryController
                                .galleryInfo?.gallerydata.length,
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
                                                    "${AppUrl.imageurl}${galleryController.galleryInfo?.gallerydata[index].image ?? ""}",
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
                                                          galleryController
                                                                  .galleryInfo
                                                                  ?.gallerydata[
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
                                                    galleryController
                                                                .galleryInfo
                                                                ?.gallerydata[
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
                                                              color: greyColor2,
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
                                              () => Addeventgalleryscreen(
                                                add: "edit",
                                                eventName: galleryController
                                                        .galleryInfo
                                                        ?.gallerydata[index]
                                                        .eventTitle ??
                                                    "",
                                                eventId: galleryController
                                                        .galleryInfo
                                                        ?.gallerydata[index]
                                                        .eventId ??
                                                    "",
                                                image: galleryController
                                                        .galleryInfo
                                                        ?.gallerydata[index]
                                                        .image ??
                                                    "",
                                                recordId: galleryController
                                                        .galleryInfo
                                                        ?.gallerydata[index]
                                                        .id ??
                                                    "",
                                              ),
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
                                "Event Gallery is not found",
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
