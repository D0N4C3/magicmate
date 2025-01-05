// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_element, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, avoid_print, deprecated_member_use, unused_field, file_names, must_be_immutable, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Listofevent_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/gallery_controller.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:magicmate_organizer/utils/Fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Addeventgalleryscreen extends StatefulWidget {
  String? add;
  String? eventName;
  String? eventId;
  String? image;
  String? recordId;
  Addeventgalleryscreen(
      {this.add,
      this.eventName,
      this.eventId,
      this.image,
      this.recordId,
      super.key});

  @override
  State<Addeventgalleryscreen> createState() => _AddeventgalleryscreenState();
}

List<String> propartyStatus = ["Publish", "UnPublish"];

class _AddeventgalleryscreenState extends State<Addeventgalleryscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GalleryController galleryController = Get.find();
  ListofeventController listofeventController = Get.find();

  String slectStatus = propartyStatus.first;
  String? event;

  bool carCheck = false;
  bool sportCheck = false;
  bool laundaryCheck = false;

  @override
  void initState() {
    super.initState();
    if (widget.add == "edit") {
      galleryController.galleyImage = "";
      galleryController.pType = "";
      galleryController.path = null;
      setState(() {
        // event = widget.eventName;
        galleryController.pType = widget.eventId ?? "";
        galleryController.galleyImage = widget.image ?? "";
      });
    } else if (widget.add == "Add") {
      setState(() {
        galleryController.path = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      appBar: appbar(title: "Add Event Gallery"),
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
                if (galleryController.path != null) {
                  if (event != null) {
                    galleryController.addGallery();
                  } else {
                    ApiWrapper.showToastMessage("Please Select Event");
                  }
                } else {
                  ApiWrapper.showToastMessage(
                      "Please Upload Event Cover Image");
                }
              } else if (widget.add == "edit") {
                galleryController.editGallery(recordId: widget.recordId);
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
                        Container(
                          height: 60,
                          width: Get.size.width,
                          alignment: Alignment.center,
                          // margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: DropdownButton(
                            hint: Text(
                              "Select Event",
                              style: TextStyle(
                                  fontFamily: FontFamily.gilroyMedium,
                                  fontSize: 15,
                                  color: BlackColor),
                            ),
                            value: event,
                            icon: Image.asset(
                              'assets/Arrowdown.png',
                              height: 20,
                              width: 20,
                            ),
                            isExpanded: true,
                            underline: SizedBox.shrink(),
                            items: listofeventController.selectevent
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
                              galleryController.pType = listofeventController
                                  .listofeventinfo[listofeventController
                                      .selectevent
                                      .indexOf(value ?? "")]
                                  .eventId;
                              print("+++++++++++++++++++++" +
                                  galleryController.pType);

                              setState(() {
                                event = value ?? "";
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
                          "Event Cover Image".tr,
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
                            onTap: () {
                              eventimage(context);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: widget.add == "Add"
                                  ? Container(
                                      height: 80,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      width: Get.size.width,
                                      alignment: Alignment.center,
                                      child: galleryController.path == null
                                          ? Image.asset(
                                              "assets/uplodeimage.png",
                                              height: 40,
                                              width: 42,
                                            )
                                          : Image.file(
                                              File(
                                                galleryController.path ??
                                                    "".toString(),
                                              ),
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.cover,
                                            ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    )
                                  : galleryController.galleyImage == ""
                                      ? Container(
                                          height: 80,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          width: Get.size.width,
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            "assets/uplodeimage.png",
                                            height: 40,
                                            width: 42,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        )
                                      : galleryController.path == null
                                          ? Container(
                                              height: 80,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              width: Get.size.width,
                                              alignment: Alignment.center,
                                              child: Image.network(
                                                AppUrl.imageurl +
                                                    galleryController
                                                        .galleyImage,
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.fill,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            )
                                          : Container(
                                              height: 80,
                                              width: Get.size.width,
                                              alignment: Alignment.center,
                                              child: Image.file(
                                                File(
                                                  galleryController.path
                                                      .toString(),
                                                ),
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Event Cover Image Status".tr,
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
                                galleryController.status = "1";
                              } else if (value == "UnPublish") {
                                galleryController.status = "0";
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

  void eventimage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      galleryController.path = pickedFile.path;
      setState(() {});
      File imageFile = File(galleryController.path.toString());
      List<int> imageBytes = imageFile.readAsBytesSync();
      galleryController.base64Image = base64Encode(imageBytes);

      setState(() {});
    }
  }
}
