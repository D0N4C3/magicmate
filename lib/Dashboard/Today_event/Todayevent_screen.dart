// ignore_for_file: sort_child_properties_last, prefer_const_constructors, file_names, must_be_immutable

import 'package:magicmate_organizer/Dashboard/Today_event/event_details.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Todayevent_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/eventdetails_controller.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Todayeventscreen extends StatefulWidget {
  String? status;
  String? hideStatus;
  Todayeventscreen({this.status, this.hideStatus, super.key});

  @override
  State<Todayeventscreen> createState() => _TodayeventscreenState();
}

class _TodayeventscreenState extends State<Todayeventscreen> {
  StatuswiseeventController statuswiseeventController = Get.find();
  EventDetailsController eventDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.hideStatus == "1"
            ? InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    "assets/arrowleft.png",
                    color: BlackColor,
                  ),
                ),
              )
            : SizedBox(),
        centerTitle: widget.hideStatus == "1" ? false : true,
        elevation: 0,
        backgroundColor: WhiteColor,
        title: Text(
          "${widget.status}",
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            fontSize: 16,
            color: BlackColor,
          ),
        ),
      ),
      backgroundColor: bgcolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: GetBuilder<StatuswiseeventController>(builder: (context) {
            return statuswiseeventController.isLoading
                ? statuswiseeventController.todayeventinfo!.orderData.isNotEmpty
                    ? ListView.builder(
                        itemCount: statuswiseeventController
                            .todayeventinfo!.orderData.length,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              if (widget.status == "Today event") {
                                await eventDetailsController.getEventDetailsApi(
                                  eventId: statuswiseeventController
                                          .todayeventinfo
                                          ?.orderData[index]
                                          .eventId ??
                                      "",
                                );
                                Get.to(
                                  EventDetailsScreen(
                                    status: widget.status,
                                  ),
                                );
                              } else if (widget.status == "Past event") {
                                await eventDetailsController.getEventDetailsApi(
                                  eventId: statuswiseeventController
                                          .todayeventinfo
                                          ?.orderData[index]
                                          .eventId ??
                                      "",
                                );
                                Get.to(
                                  EventDetailsScreen(
                                    status: widget.status,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              margin: EdgeInsets.only(bottom: 8),
                              width: Get.size.width,
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        "${AppUrl.imageurl}${statuswiseeventController.todayeventinfo?.orderData[index].eventImg}",
                                        height: 140,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.56,
                                              child: Text(
                                                statuswiseeventController
                                                        .todayeventinfo
                                                        ?.orderData[index]
                                                        .eventTitle ??
                                                    "",
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily:
                                                      FontFamily.gilroyBold,
                                                  color: BlackColor,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        statuswiseeventController.todayeventinfo
                                                ?.orderData[index].eventSdate ??
                                            "",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: greycolor,
                                            fontFamily: FontFamily.gilroyMedium,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/mappin.png",
                                            height: 20,
                                            width: 20,
                                            color: appcolor,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          SizedBox(
                                            width: Get.size.width * 0.49,
                                            child: Text(
                                              "${statuswiseeventController.todayeventinfo?.orderData[index].eventPlaceName}",
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily:
                                                    FontFamily.gilroyMedium,
                                                color: greycolor,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                color: WhiteColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.37),
                          child: Text(
                            "No Event Available",
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyBold,
                              fontSize: 16,
                              color: BlackColor,
                            ),
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
          }),
        ),
      ),
    );
  }
}
