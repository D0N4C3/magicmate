// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_element, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, avoid_print, deprecated_member_use, unused_field, file_names, must_be_immutable

import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Add_extra_image_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Category_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Listofevent_controller.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:magicmate_organizer/utils/Fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddcoverimageScreen extends StatefulWidget {
  String? add;
  String? eventId;
  String? eventName;
  AddcoverimageScreen({this.add, this.eventId, this.eventName, super.key});

  @override
  State<AddcoverimageScreen> createState() => _AddcoverimageScreenState();
}

List<String> propartyStatus = ["Publish", "UnPublish"];

class _AddcoverimageScreenState extends State<AddcoverimageScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddcoverimageController addcoverimageController = Get.find();
  CategoryController categoryController = Get.find();
  ListofeventController listofeventController = Get.find();

  String? selectProperty;
  String slectStatus = propartyStatus.first;

  bool carCheck = false;
  bool sportCheck = false;
  bool laundaryCheck = false;

  @override
  void initState() {
    categoryController.categorylist();
    super.initState();
    if (widget.add == "edit") {
      setState(() {
        addcoverimageController.medicineImage = "";
        addcoverimageController.medicineImage = addcoverimageController.mid;
        selectProperty = widget.eventName;
        addcoverimageController.pType = widget.eventId ?? "";
      });
    } else if (widget.add == "Add") {
      setState(() {
        addcoverimageController.pType = "";
        addcoverimageController.mid = "";
        addcoverimageController.medicineImage = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      appBar: appbar(title: "Add Cover images"),
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
              print(">>>>>>>>>>>>>selectProperty<<<<<<<<<<<<<<$selectProperty");
              if (addcoverimageController.pType != "") {
                if (addcoverimageController.path != null ||
                    addcoverimageController.medicineImage != "") {
                  if (widget.add == "Add") {
                    addcoverimageController.addcoverimage();
                  }
                  if (widget.add == "edit") {
                    addcoverimageController.editcoverimage();
                  }
                } else {
                  ApiWrapper.showToastMessage("Please Upload Image");
                }
              } else {
                ApiWrapper.showToastMessage("Please Select Category");
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
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Select Event".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                            color: BlackColor,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.012),
                        GetBuilder<CategoryController>(builder: (context) {
                          return Container(
                            height: 60,
                            width: Get.size.width,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: DropdownButton(
                              hint: Text(
                                "Select Category",
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyMedium,
                                  color: BlackColor,
                                  fontSize: 14,
                                ),
                              ),
                              value: selectProperty,
                              icon: Image.asset(
                                'assets/Arrowdown.png',
                                height: 20,
                                width: 20,
                              ),
                              isExpanded: true,
                              underline: SizedBox.shrink(),
                              items: listofeventController.selectevent
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                                addcoverimageController.pType =
                                    listofeventController
                                        .listofeventinfo[listofeventController
                                            .selectevent
                                            .indexOf(value ?? "")]
                                        .eventId;
                                // for (var i = 0;
                                //     i <
                                //         categoryController
                                //             .categoryinfo!.categorydata.length;
                                //     i++) {
                                //   if (value ==
                                //       categoryController.categoryinfo!
                                //           .categorydata[i].title) {
                                //     addcoverimageController.pType =
                                //         categoryController
                                //             .categoryinfo!.categorydata[i].id;

                                //     //   print(
                                //     //       "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${categoryController.categoryinfo?.categorydata[i].id}");
                                //   }
                                // }
                                setState(() {
                                  selectProperty = value;
                                  // listOfUser.add(selectValue);
                                });
                              },
                            ),
                            decoration: BoxDecoration(
                              color: WhiteColor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                          );
                        }),
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
                                      child:
                                          addcoverimageController.path == null
                                              ? Image.asset(
                                                  "assets/uplodeimage.png",
                                                  height: 40,
                                                  width: 42,
                                                )
                                              : Image.file(
                                                  File(
                                                    addcoverimageController.path
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
                                      child: addcoverimageController
                                                  .medicineImage ==
                                              ""
                                          ? Image.asset(
                                              "assets/uplodeimage.png",
                                              height: 40,
                                              width: 42,
                                            )
                                          : addcoverimageController.path == null
                                              ? Image.network(
                                                  "${AppUrl.imageurl}${addcoverimageController.medicineImage}",
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  File(
                                                    addcoverimageController.path
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
                                addcoverimageController.status = "1";
                              } else if (value == "UnPublish") {
                                addcoverimageController.status = "0";
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
      addcoverimageController.path = pickedFile.path;
      setState(() {});
      File imageFile = File(addcoverimageController.path.toString());
      List<int> imageBytes = imageFile.readAsBytesSync();
      addcoverimageController.base64Image = base64Encode(imageBytes);
      print("!!!!!!!!!++++++++++++${addcoverimageController.base64Image}");
      setState(() {});
    }
  }
}
