// ignore_for_file: prefer_const_constructors, file_names, unnecessary_brace_in_string_interps, sort_child_properties_last

import 'package:magicmate_organizer/Dashboard/Artist%20List/Artistlist_screen.dart';
import 'package:magicmate_organizer/Dashboard/Coupons/Coupon_screen.dart';
import 'package:magicmate_organizer/Dashboard/Coverimage%20screen/Coverimage_screen.dart';
import 'package:magicmate_organizer/Dashboard/Event%20Gallery/Eventgallery_screen.dart';
import 'package:magicmate_organizer/Dashboard/Event%20Types/Event_type.dart';
import 'package:magicmate_organizer/Dashboard/Today_event/Todayevent_screen.dart';
import 'package:magicmate_organizer/Dashboard/Event%20list/Eventlist_screen.dart';
import 'package:magicmate_organizer/Dashboard/notificatin_screen.dart';
import 'package:magicmate_organizer/Dashboard/payout/payout_screen.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Category_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Dashboard_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Eventtypeprice_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Extra_image_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Listofevent_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Todayevent_controller.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/api_screens/data_store.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:magicmate_organizer/utils/Fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController dashboardController = Get.find();
  StatuswiseeventController statuswiseeventController = Get.find();
  ListofeventController listofeventController = Get.find();
  CategoryController categoryController = Get.find();
  EventtypepriceController eventtypepriceController = Get.find();
  CoverimageController coverimageController = Get.find();

  @override
  void initState() {
    super.initState();
    dashboardController.dashboard();
    listofeventController.listofevent();
    categoryController.categorylist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: AppBar(
            // automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: WhiteColor,
            leading: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 15, right: 5),
              child: Image.asset("assets/Logo1.png", height: 40, width: 40),
            ),
            title: Text(
              "Hello, ${getData.read("UserLogin")["title"]}",
              maxLines: 1,
              style: TextStyle(
                fontFamily: FontFamily.gilroyExtraBold,
                color: appcolor,
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Get.to(NotificationScreen(status: "1"));
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Image.asset(
                    "assets/Notification.png",
                  ),
                ),
              )
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 2),
              () {
                setState(() {
                  dashboardController.dashboard();
                });
              },
            );
          },
          child: GetBuilder<DashboardController>(builder: (context) {
            return dashboardController.isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 25, top: 10),
                          child: Column(
                            children: [
                              GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.5,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 100,
                                ),
                                itemCount: dashboardController
                                    .dashboardinfo?.reportData.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      switch (index) {
                                        case 0:
                                          setState(() {});
                                          listofeventController.listofevent();
                                          Get.to(() => Eventlistscreen());
                                          break;
                                        case 1:
                                          setState(() {});
                                          await statuswiseeventController
                                              .statuswiseevent(status: "Today");
                                          Get.to(() => Todayeventscreen(
                                                status: "Today event",
                                                hideStatus: "1",
                                              ));

                                          break;
                                        case 2:
                                          setState(() {});
                                          await statuswiseeventController
                                              .statuswiseevent(
                                                  status: "Upcoming");
                                          Get.to(() => Todayeventscreen(
                                                status: "Upcoming event",
                                                hideStatus: "1",
                                              ));

                                          break;
                                        case 3:
                                          setState(() {});
                                          await statuswiseeventController
                                              .statuswiseevent(status: "Past");
                                          Get.to(() => Todayeventscreen(
                                                status: "Past event",
                                                hideStatus: "1",
                                              ));

                                          break;
                                        case 4:
                                          eventtypepriceController
                                              .eventtypeprice();

                                          Get.to(() => Eventtypescreen());
                                          // Get.to(
                                          //     () => Artistlistscreen());
                                          break;
                                        case 5:
                                          setState(() {});
                                          Get.to(() => Couponscreen());
                                          break;
                                        case 6:
                                          coverimageController.coverimagelist();
                                          Get.to(() => Coverimagescreen());
                                          break;
                                        case 7:
                                          setState(() {});

                                          Get.to(() => Artistlistscreen());
                                          break;
                                        case 8:
                                          setState(() {});
                                          Get.to(() => Eventgalleryscreen());
                                          break;
                                        case 9:
                                          setState(() {});
                                          // Get.to(() => AcademicYear());
                                          break;
                                        case 10:
                                          // Get.to(() => AcademicYear());
                                          break;
                                        case 11:
                                          Get.to(MyPayoutScreen(status: "1"));
                                          // Get.to(() => AcademicYear());
                                          break;
                                        default:
                                      }
                                    },
                                    child: Container(
                                      height: 100,
                                      width: Get.size.width,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: WhiteColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: Get.size.width * 0.25,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                index / 10 == 1 ||
                                                        index / 11 == 1 ||
                                                        index / 12 == 1
                                                    ? Text(
                                                        "${currency}${dashboardController.dashboardinfo?.reportData[index].reportData ?? ""}",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontFamily: FontFamily
                                                              .gilroyExtraBold,
                                                          color: BlackColor,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 24,
                                                        ),
                                                      )
                                                    : Text(
                                                        "${dashboardController.dashboardinfo?.reportData[index].reportData ?? ""}",
                                                        style: TextStyle(
                                                            fontFamily: FontFamily
                                                                .gilroyExtraBold,
                                                            color: BlackColor,
                                                            fontSize: 24),
                                                      ),
                                                SizedBox(
                                                    height: Get.height * 0.010),
                                                Text(
                                                  dashboardController
                                                          .dashboardinfo
                                                          ?.reportData[index]
                                                          .title ??
                                                      "",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.gilroyBold,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "${AppUrl.imageurl}${dashboardController.dashboardinfo?.reportData[index].url ?? ""}"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
        ));
  }
}
