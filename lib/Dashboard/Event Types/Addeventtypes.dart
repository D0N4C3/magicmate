// ignore_for_file: prefer_const_constructors, sort_child_properties_last, file_names, must_be_immutable, prefer_interpolation_to_compose_strings, avoid_print

import 'package:magicmate_organizer/Getx_controller.dart/Addeventtypeprice_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Listofevent_controller.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:magicmate_organizer/utils/Fontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Addeventtypes extends StatefulWidget {
  String? edit;
  String? recordid;
  String? eventname;
  String? evevtid;
  Addeventtypes(
      {this.edit, this.recordid, this.evevtid, this.eventname, super.key});

  @override
  State<Addeventtypes> createState() => _AddeventtypesState();
}

List<String> propartyStatus = ["Publish", "UnPublish"];

class _AddeventtypesState extends State<Addeventtypes> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ListofeventController listofeventController = Get.find();
  AddeventtypepriceController addeventtypepriceController = Get.find();
  String slectStatus = propartyStatus.first;
  String? selectevent;
  @override
  void initState() {
    if (widget.edit == "edit") {
      setState(() {
        addeventtypepriceController.etype.text =
            addeventtypepriceController.eventtype;
        addeventtypepriceController.price.text =
            addeventtypepriceController.eventprice;
        addeventtypepriceController.tlimit.text =
            addeventtypepriceController.eventtlimit;
        addeventtypepriceController.description.text =
            addeventtypepriceController.eventdescription;
        selectevent = widget.eventname;
        print("-------*******------" + selectevent.toString());
        print("-------*******------" + widget.eventname.toString());
        addeventtypepriceController.pType = widget.evevtid!;
      });
    } else {
      setState(() {
        addeventtypepriceController.etype.text = "";
        addeventtypepriceController.price.text = "";
        addeventtypepriceController.tlimit.text = "";
        addeventtypepriceController.description.text = "";
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: "Add Event Type & Price"),
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
              if (_formKey.currentState?.validate() ?? false) {
                if (widget.edit == "Add") {
                  addeventtypepriceController.eventaddtypeprice(
                      eventid: addeventtypepriceController.pType);
                } else {
                  addeventtypepriceController.eventedittypeprice(
                      recordid: widget.recordid);
                }
              }
            }),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
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
                    value: selectevent,
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
                      addeventtypepriceController.pType = listofeventController
                          .listofeventinfo[listofeventController.selectevent
                              .indexOf(value ?? "")]
                          .eventId;
                      print("+++++++++++++++++++++" +
                          addeventtypepriceController.pType);

                      setState(() {
                        selectevent = value ?? "";
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
                SizedBox(height: Get.height * 0.01),
                textfield(
                  type: "Event Type",
                  controller: addeventtypepriceController.etype,
                  labelText: "Enter Event Type",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Event Type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Get.height * 0.01),
                textfield(
                  type: "Event Ticket Price",
                  controller: addeventtypepriceController.price,
                  labelText: "Enter Event Ticket Price",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Event Ticket Price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Get.height * 0.01),
                textfield(
                  type: "Event Ticket Limit",
                  controller: addeventtypepriceController.tlimit,
                  labelText: "Enter Event Ticket Limit",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Event Ticket Limit';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Get.height * 0.02),
                Text(
                  "Event Type Description".tr,
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyBold,
                    fontSize: 16,
                    color: BlackColor,
                  ),
                ),
                SizedBox(height: Get.height * 0.012),
                Container(
                  child: TextFormField(
                    controller: addeventtypepriceController.description,
                    minLines: 5,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    cursorColor: BlackColor,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        return 'Please Enter Medicine Disclaimer'.tr;
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
                  "Ticket Status".tr,
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyBold,
                    fontSize: 16,
                    color: BlackColor,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Container(
                  height: 60,
                  width: Get.size.width,
                  alignment: Alignment.center,
                  // margin: EdgeInsets.symmetric(horizontal: 10),
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
                        addeventtypepriceController.status = "1";
                      } else if (value == "UnPublish") {
                        addeventtypepriceController.status = "0";
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
                SizedBox(height: Get.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
