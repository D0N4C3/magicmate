// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_element, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, avoid_print, deprecated_member_use, unused_field, file_names, must_be_immutable, unused_local_variable, use_build_context_synchronously, unnecessary_brace_in_string_interps, prefer_final_fields, body_might_complete_normally_nullable, unnecessary_null_comparison, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Addeventlist_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Category_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Dashboard_controller.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:magicmate_organizer/utils/Fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

class Addeventlistscreen extends StatefulWidget {
  String? add;
  String? recordid;
  String? categoryname;
  String? categoryid;
  Addeventlistscreen(
      {this.add, this.recordid, this.categoryid, this.categoryname, super.key});

  @override
  State<Addeventlistscreen> createState() => _AddeventlistscreenState();
}

CategoryController categoryController = Get.put(CategoryController());

List<String> propartyStatus = ["Publish", "UnPublish"];

class _AddeventlistscreenState extends State<Addeventlistscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddlistofeventController addlistofeventController =
      Get.put(AddlistofeventController());
  DashboardController dashboardController = Get.find();
  // CategoryController categoryController = Get.put(CategoryController());

  String? categorylist;

  String? selectProperty;
  String? selectCountry;
  String slectStatus = propartyStatus.first;

  bool carCheck = false;
  bool sportCheck = false;
  bool laundaryCheck = false;
  String? path;
  String? eventcover;
  String eventdescription = "";
  String eventdisclaimer = "";

  @override
  void initState() {
    // dashboardController.getFacilityList();
    // dashboardController.getRestrictionList();
    super.initState();
    if (widget.add == "edit") {
      print(
          "++++++++++++++++++++++++++++++${addlistofeventController.eventdescription}");

      var description = parse(addlistofeventController.eventdescription);
      if (description.documentElement != null) {
        eventdescription = description.documentElement!.text;
        print("333333333333333333333333" + eventdescription);
        //output without space: HelloThis is fluttercampus.com,Bye!
      }
      var disclaimer = parse(addlistofeventController.eventdisclaimer);
      if (disclaimer.documentElement != null) {
        eventdisclaimer = disclaimer.documentElement!.text;
        print("333333333333333333333333" + eventdisclaimer);
        //output without space: HelloThis is fluttercampus.com,Bye!
      }
      setState(() {
        addlistofeventController.emptyAllDetails();
        addlistofeventController.eventimage =
            addlistofeventController.eventimage;
        addlistofeventController.eventcoverimage =
            addlistofeventController.eventcoverimage;
        addlistofeventController.eventTitle.text =
            addlistofeventController.eventname;
        addlistofeventController.address.text =
            addlistofeventController.eventaddress;
        addlistofeventController.eventdate.text =
            addlistofeventController.dateevent;
        addlistofeventController.placename.text =
            addlistofeventController.eventplace;
        addlistofeventController.description.text = eventdescription;
        addlistofeventController.disclaimer.text = eventdisclaimer;
        addlistofeventController.starttime.text =
            addlistofeventController.eventstarttime;
        addlistofeventController.endtime.text =
            addlistofeventController.eventendtime;
        addlistofeventController.youtubeurl =
            addlistofeventController.youtubeurl;
        addlistofeventController.tegs = addlistofeventController.tegs;
        addlistofeventController.long = addlistofeventController.longitude;
        addlistofeventController.lat = addlistofeventController.latitude;
        addlistofeventController.pType = widget.categoryid!;
        categorylist = widget.categoryname;
      });
    } else {
      addlistofeventController.lat = "";
      addlistofeventController.long = "";
      addlistofeventController.emptyAllDetails();
      setState(() {});
    }
    // addlistofeventController.youtubeurl = TextfieldTagsController();
  }

  TextfieldTagsController _controller = TextfieldTagsController();
  double _distanceToField = 0.0;

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: "Add Event"),
      backgroundColor: WhiteColor,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: GestButton(
            Width: Get.size.width,
            height: 55,
            gradient: gradient.btnGradient,
            buttontext: "Update".tr,
            style: TextStyle(
              fontFamily: FontFamily.gilroyBold,
              color: WhiteColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            onclick: () {
              if (widget.add == "Add") {
                if (_formKey.currentState?.validate() ?? false) {
                  if (addlistofeventController.base64Image != null) {
                    if (addlistofeventController.coverimagebase64Image !=
                        null) {
                      if (addlistofeventController.lat != "" &&
                          addlistofeventController.long != "") {
                        if (categorylist != null) {
                          if (widget.add == "Add") {
                            addlistofeventController.eventadd();
                          }
                        } else {
                          ApiWrapper.showToastMessage("Please Select Category");
                        }
                      } else {
                        ApiWrapper.showToastMessage(
                            "Please Add Your Current Location");
                      }
                    } else {
                      ApiWrapper.showToastMessage(
                          "Please Upload Event Cover Image");
                    }
                  } else {
                    ApiWrapper.showToastMessage("Please Upload Event Image");
                  }
                }
              } else if (widget.add == "edit") {
                addlistofeventController.eventedit(recordid: widget.recordid);
              }
            }),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height * 0.01),
                        textfield(
                          type: "Event Name".tr,
                          controller: addlistofeventController.eventTitle,
                          labelText: "Enter Event Name".tr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Event Name'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Event Image".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                            color: BlackColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.015),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          color: appcolor,
                          radius: Radius.circular(15),
                          // borderPadding: EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: _openGallery,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: widget.add == "Add"
                                  ? Container(
                                      height: 80,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      width: Get.size.width,
                                      alignment: Alignment.center,
                                      child: addlistofeventController.path ==
                                              null
                                          ? Image.asset(
                                              "assets/uplodeimage.png",
                                              height: 40,
                                              width: 42,
                                            )
                                          : Image.file(
                                              File(
                                                addlistofeventController.path
                                                    .toString(),
                                              ),
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    )
                                  : Container(
                                      height: 80,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      width: Get.size.width,
                                      alignment: Alignment.center,
                                      child:
                                          addlistofeventController.eventimage ==
                                                  ""
                                              ? Image.asset(
                                                  "assets/uplodeimage.png",
                                                  height: 40,
                                                  width: 42,
                                                )
                                              : addlistofeventController.path ==
                                                      null
                                                  ? Image.network(
                                                      "${AppUrl.imageurl}${addlistofeventController.eventimage}",
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.file(
                                                      File(
                                                        addlistofeventController
                                                            .path
                                                            .toString(),
                                                      ),
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.cover,
                                                    ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Event Cover".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                            color: BlackColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.015),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          color: appcolor,
                          radius: Radius.circular(15),
                          // borderPadding: EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: Eventcover,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: widget.add == "Add"
                                  ? Container(
                                      height: 80,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      width: Get.size.width,
                                      alignment: Alignment.center,
                                      child: addlistofeventController
                                                  .coverimagepath ==
                                              null
                                          ? Image.asset(
                                              "assets/uplodeimage.png",
                                              height: 40,
                                              width: 42,
                                            )
                                          : Image.file(
                                              File(
                                                addlistofeventController
                                                    .coverimagepath
                                                    .toString(),
                                              ),
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    )
                                  : Container(
                                      height: 80,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      width: Get.size.width,
                                      alignment: Alignment.center,
                                      child: addlistofeventController
                                                  .eventcoverimage ==
                                              ""
                                          ? Image.asset(
                                              "assets/uplodeimage.png",
                                              height: 40,
                                              width: 42,
                                            )
                                          : addlistofeventController
                                                      .coverimagepath ==
                                                  null
                                              ? Image.network(
                                                  "${AppUrl.imageurl}${addlistofeventController.eventcoverimage}",
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  File(
                                                    addlistofeventController
                                                        .coverimagepath
                                                        .toString(),
                                                  ),
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        textfield(
                          type: "Event Date".tr,
                          controller: addlistofeventController.eventdate,
                          labelText: "yyyy-mm-dd".tr,
                          textInputType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Event Date'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Event Start time".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                            color: BlackColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        TextFormField(
                          // controller: addTimeSlotController.mintime,
                          controller: addlistofeventController.starttime,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: "Event Start time",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Gilroy Medium",
                                fontSize: 16),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: appcolor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );
                            print("-----======" + pickedTime.toString());
                            if (pickedTime != null) {
                              print(pickedTime.format(context));

                              addlistofeventController.starttime.text =
                                  pickedTime.format(context);
                            } else {
                              print("Time is not selected");
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Event Start time'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.025),
                        Text(
                          "Event End time",
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                            color: BlackColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.015),
                        TextFormField(
                          // controller: addTimeSlotController.maxtime,
                          controller: addlistofeventController.endtime,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: "Event End time",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Gilroy Medium",
                                fontSize: 16),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: appcolor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              print(pickedTime.format(context));

                              addlistofeventController.endtime.text =
                                  pickedTime.format(context);
                            } else {
                              print("Time is not selected");
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Event End time'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.02),
                        GetBuilder<AddlistofeventController>(
                            builder: (context) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Text(
                                      "Latitude".tr,
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyBold,
                                        fontSize: 16,
                                        color: BlackColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 60,
                                    width: Get.width * 0.43,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    alignment: Alignment.center,
                                    child: Text(
                                      // addlistofeventController.latitude,
                                      addlistofeventController.lat != null
                                          ? addlistofeventController.lat
                                              .toString()
                                          : "",
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyMedium,
                                        color: BlackColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Text(
                                      "Longitude".tr,
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyBold,
                                        fontSize: 16,
                                        color: BlackColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 60,
                                    width: Get.width * 0.43,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    alignment: Alignment.center,
                                    child: Text(
                                      // addlistofeventController.longitude,
                                      addlistofeventController.long != null
                                          ? addlistofeventController.long
                                              .toString()
                                          : "",
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyMedium,
                                        color: BlackColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                        SizedBox(height: Get.height * 0.02),
                        InkWell(
                          onTap: () async {
                            LocationPermission permission;
                            permission = await Geolocator.checkPermission();
                            permission = await Geolocator.requestPermission();
                            if (permission == LocationPermission.denied) {}
                            var currentLocation = await locateUser();
                            debugPrint('location: ${currentLocation.latitude}');
                            addlistofeventController.getCurrentLatAndLong(
                              currentLocation.latitude,
                              currentLocation.longitude,
                            );
                            print("????????????" +
                                currentLocation.latitude.toString());
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/Navigation.png",
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Click for Current Location".tr,
                                style: TextStyle(
                                  color: BlackColor,
                                  fontFamily: FontFamily.gilroyMedium,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Event Address".tr,
                          style: TextStyle(
                              fontFamily: FontFamily.gilroyBold,
                              fontSize: 16,
                              color: BlackColor),
                        ),
                        SizedBox(height: Get.height * 0.012),
                        Container(
                          child: TextFormField(
                            controller: addlistofeventController.address,
                            minLines: 5,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            cursorColor: BlackColor,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: appcolor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                              hintText: "Enter Event Address".tr,
                              hintStyle: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                fontSize: 15,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              fontSize: 16,
                              color: BlackColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Event Address'.tr;
                              }
                              return null;
                            },
                          ),
                          decoration: BoxDecoration(
                            color: WhiteColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        textfield(
                          type: "Event Place Name".tr,
                          controller: addlistofeventController.placename,
                          labelText: "Enter Event Place Name".tr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Event Place Name'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Event Category".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                            color: BlackColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.012),
                        Container(
                          height: 60,
                          width: Get.size.width,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: DropdownButton(
                            hint: Text(
                              "Select Category".tr,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 16,
                                color: BlackColor,
                              ),
                            ),
                            value: categorylist,
                            icon: Image.asset(
                              'assets/Arrowdown.png',
                              height: 20,
                              width: 20,
                            ),
                            isExpanded: true,
                            underline: SizedBox.shrink(),
                            items: categoryController.categorytext
                                .map<DropdownMenuItem<String>>((String value) {
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
                              for (var i = 0;
                                  i <
                                      categoryController
                                          .categoryinfo!.categorydata.length;
                                  i++) {
                                if (value ==
                                    categoryController
                                        .categoryinfo!.categorydata[i].title) {
                                  addlistofeventController.pType =
                                      categoryController
                                          .categoryinfo!.categorydata[i].id;
                                }
                              }
                              setState(() {
                                categorylist = value ?? "";
                                // listOfUser.add(selectValue);
                              });
                            },
                          ),
                          decoration: BoxDecoration(
                            color: WhiteColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Multiple Youtube URL".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                            color: BlackColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        youtubeurl(),
                        SizedBox(height: Get.height * 0.02),
                        tegs(),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Select Facility".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                            color: BlackColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        GetBuilder<AddlistofeventController>(
                            builder: (context) {
                          return GetBuilder<DashboardController>(
                              builder: (context) {
                            return dashboardController.isLoading
                                ? ListView.builder(
                                    itemCount: dashboardController
                                        .facilityInfo?.facilitydata.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Transform.scale(
                                                scale: 1,
                                                child: Checkbox(
                                                  value: addlistofeventController
                                                      .selectedIndexes
                                                      .contains(
                                                          dashboardController
                                                              .facilityInfo
                                                              ?.facilitydata[
                                                                  index]
                                                              .id),
                                                  side: const BorderSide(
                                                      color: Color(0xffC5CAD4)),
                                                  activeColor: blueColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  onChanged: (_) {
                                                    if (addlistofeventController
                                                        .selectedIndexes
                                                        .contains(
                                                            dashboardController
                                                                .facilityInfo
                                                                ?.facilitydata[
                                                                    index]
                                                                .id)) {
                                                      addlistofeventController
                                                          .selectedIndexes
                                                          .remove(dashboardController
                                                              .facilityInfo
                                                              ?.facilitydata[
                                                                  index]
                                                              .id); // unselect
                                                      setState(() {});
                                                    } else {
                                                      addlistofeventController
                                                          .selectedIndexes
                                                          .add(dashboardController
                                                              .facilityInfo
                                                              ?.facilitydata[
                                                                  index]
                                                              .id);
                                                      setState(() {}); // select
                                                    }
                                                  },
                                                ),
                                              ),
                                              Text(
                                                dashboardController
                                                        .facilityInfo
                                                        ?.facilitydata[index]
                                                        .title ??
                                                    "",
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.gilroyMedium,
                                                  fontSize: 17,
                                                  color: BlackColor,
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                height: 40,
                                                width: 40,
                                                child: Image.network(
                                                  "${AppUrl.imageurl}${dashboardController.facilityInfo?.facilitydata[index].img ?? ""}",
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFeef4ff),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Divider(thickness: 1),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  );
                          });
                        }),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Select Restriction".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                            color: BlackColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        GetBuilder<AddlistofeventController>(
                            builder: (context) {
                          return GetBuilder<DashboardController>(
                              builder: (context) {
                            return dashboardController.isLoading
                                ? ListView.builder(
                                    itemCount: dashboardController
                                        .restrictioninfo
                                        ?.restrictiondata
                                        .length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Transform.scale(
                                                scale: 1,
                                                child: Checkbox(
                                                  value: addlistofeventController
                                                      .restirectedindex
                                                      .contains(
                                                          dashboardController
                                                              .restrictioninfo
                                                              ?.restrictiondata[
                                                                  index]
                                                              .id),
                                                  side: const BorderSide(
                                                      color: Color(0xffC5CAD4)),
                                                  activeColor: blueColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  onChanged: (_) {
                                                    if (addlistofeventController
                                                        .restirectedindex
                                                        .contains(
                                                            dashboardController
                                                                .restrictioninfo
                                                                ?.restrictiondata[
                                                                    index]
                                                                .id)) {
                                                      addlistofeventController
                                                          .restirectedindex
                                                          .remove(dashboardController
                                                              .restrictioninfo
                                                              ?.restrictiondata[
                                                                  index]
                                                              .id); // unselect
                                                      setState(() {});
                                                    } else {
                                                      addlistofeventController
                                                          .restirectedindex
                                                          .add(dashboardController
                                                              .restrictioninfo
                                                              ?.restrictiondata[
                                                                  index]
                                                              .id);
                                                      setState(() {}); // select
                                                    }
                                                  },
                                                ),
                                              ),
                                              Text(
                                                dashboardController
                                                        .restrictioninfo
                                                        ?.restrictiondata[index]
                                                        .title ??
                                                    "",
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.gilroyMedium,
                                                  fontSize: 17,
                                                  color: BlackColor,
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                height: 40,
                                                width: 40,
                                                child: Image.network(
                                                  "${AppUrl.imageurl}${dashboardController.restrictioninfo?.restrictiondata[index].img ?? ""}",
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFeef4ff),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Divider(thickness: 1),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  );
                          });
                        }),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Event Description".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                            color: BlackColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.012),
                        Container(
                          child: TextFormField(
                            controller: addlistofeventController.description,
                            minLines: 5,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            cursorColor: BlackColor,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: appcolor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              fontSize: 16,
                              color: BlackColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Event Description'.tr;
                              }
                              return null;
                            },
                          ),
                          decoration: BoxDecoration(
                            color: WhiteColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Event Disclaimer".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                            color: BlackColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.012),
                        Container(
                          child: TextFormField(
                            controller: addlistofeventController.disclaimer,
                            minLines: 5,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            cursorColor: BlackColor,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: appcolor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              fontSize: 16,
                              color: BlackColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Event Disclaimer'.tr;
                              }
                              return null;
                            },
                          ),
                          decoration: BoxDecoration(
                            color: WhiteColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.012),
                        Text(
                          "Event Status".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                            color: BlackColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.012),
                        Container(
                          height: 60,
                          width: Get.size.width,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: DropdownButton(
                            value: slectStatus,
                            icon: Image.asset(
                              'assets/Arrowdown.png',
                              height: 20,
                              width: 20,
                            ),
                            isExpanded: true,
                            underline: SizedBox.shrink(),
                            items: propartyStatus
                                .map<DropdownMenuItem<String>>((String value) {
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
                              if (value == "Publish") {
                                addlistofeventController.status = "1";
                              } else if (value == "UnPublish") {
                                addlistofeventController.status = "0";
                              }
                              setState(() {
                                slectStatus = value ?? "";
                                // listOfUser.add(selectValue);
                              });
                            },
                          ),
                          decoration: BoxDecoration(
                            color: WhiteColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: WhiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      addlistofeventController.path = pickedFile.path;
      setState(() {});
      File imageFile = File(addlistofeventController.path.toString());
      List<int> imageBytes = imageFile.readAsBytesSync();
      addlistofeventController.base64Image = base64Encode(imageBytes);
      print("!!!!!!!!!++++++++++++${addlistofeventController.base64Image}");
      setState(() {});
    }
  }

  void Eventcover() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      addlistofeventController.coverimagepath = pickedFile.path;
      setState(() {});
      File imageFile = File(addlistofeventController.coverimagepath.toString());
      List<int> imageBytes = imageFile.readAsBytesSync();
      addlistofeventController.coverimagebase64Image = base64Encode(imageBytes);
      print(
          "!!!!!!!!!++++++++++++${addlistofeventController.coverimagebase64Image}");
      setState(() {});
    }
  }

  youtubeurl() {
    return TextFieldTags(
      textfieldTagsController: addlistofeventController.youtubeurl,
      initialTags: addlistofeventController.youtube,
      textSeparators: const [' ', ','],
      letterCase: LetterCase.normal,
      validator: (String tag) {
        // if (tag == 'php') {
        //   return 'No, please just no';
        // } else if (_controller.getTags?.contains(tag)) {
        //   return 'you already entered that';
        // }
        // return null;
      },
      inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
        return ((context, sc, tags, onTagDelete) {
          return TextField(
            controller: tec,
            focusNode: fn,
            decoration: InputDecoration(
              // isDense: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: appcolor),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: addlistofeventController.youtubeurl.hasTags
                  ? ''
                  : "Enter https://youtu.be/1s62eem-24A",
              errorText: error,
              prefixIconConstraints:
                  BoxConstraints(maxWidth: _distanceToField * 0.8),
              prefixIcon: tags.isNotEmpty
                  ? SingleChildScrollView(
                      controller: sc,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: tags.map((String tag) {
                        return InkWell(
                          onTap: () {
                            onTagDelete(tag);
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              gradient: gradient.btnGradient,
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Text(
                                    '$tag',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    //print("$tag selected");
                                  },
                                ),
                                const SizedBox(width: 4.0),
                                InkWell(
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 14.0,
                                    color: Color.fromARGB(255, 233, 233, 233),
                                  ),
                                  onTap: () {
                                    onTagDelete(tag);
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList()),
                    )
                  : null,
            ),
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          );
        });
      },
    );
  }

  tegs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add Tag".tr,
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            fontSize: 16,
            color: BlackColor,
          ),
        ),
        SizedBox(height: Get.height * 0.02),
        TextFieldTags(
          textfieldTagsController: addlistofeventController.tegs,
          initialTags: addlistofeventController.urltag,
          textSeparators: const [' ', ','],
          letterCase: LetterCase.normal,
          validator: (String tag) {
            // if (tag == 'php') {
            //   return 'No, please just no';
            // } else if (_controller.getTags?.contains(tag)) {
            //   return 'you already entered that';
            // }
            // return null;
          },
          inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
            return ((context, sc, tags, onTagDelete) {
              return TextField(
                controller: tec,
                focusNode: fn,
                decoration: InputDecoration(
                  // isDense: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: appcolor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: addlistofeventController.tegs.hasTags
                      ? ''
                      : "Enter tag..",
                  errorText: error,
                  prefixIconConstraints:
                      BoxConstraints(maxWidth: _distanceToField * 0.8),
                  prefixIcon: tags.isNotEmpty
                      ? SingleChildScrollView(
                          controller: sc,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: tags.map((String tag) {
                            return InkWell(
                              onTap: () {
                                onTagDelete(tag);
                              },
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  gradient: gradient.btnGradient,
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        '$tag',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      onTap: () {
                                        //print("$tag selected");
                                      },
                                    ),
                                    const SizedBox(width: 4.0),
                                    InkWell(
                                      child: const Icon(
                                        Icons.cancel,
                                        size: 14.0,
                                        color:
                                            Color.fromARGB(255, 233, 233, 233),
                                      ),
                                      onTap: () {
                                        onTagDelete(tag);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList()),
                        )
                      : null,
                ),
                onChanged: onChanged,
                onSubmitted: onSubmitted,
              );
            });
          },
        ),
      ],
    );
  }
}
