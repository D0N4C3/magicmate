// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_import, file_names

import 'dart:convert';

import 'package:magicmate_organizer/Getx_controller.dart/Extra_image_controller.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/api_screens/data_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddcoverimageController extends GetxController implements GetxService {
  CoverimageController coverimageController = Get.find();

  TextEditingController answer = TextEditingController();
  TextEditingController queation = TextEditingController();

  String? path;
  String? base64Image;

  String countryId = "";

  String pType = "";
  String pbuySell = "";
  String status = "";

  String medicineImage = "";

  bool isLoading = false;

  String recordID = "";
  String mid = "";
  String answerquestion = "";

  getIdAndName({
    String? recId,
    mid1,
  }) {
    recordID = recId ?? "";
    mid = mid1 ?? "";
    update();
  }

  addcoverimage() {
    var data = {
      "orag_id": getData.read("UserLogin")["id"],
      "status": status != "" ? status : "1",
      "event_id": pType,
      "img": base64Image
    };
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!$data");
    ApiWrapper.dataPost(AppUrl.addcoverimage, data).then((val) {
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          coverimageController.coverimagelist();
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        Get.back();
        path = null;
        isLoading = true;
        update();
      }
    });
  }

  editcoverimage() {
    var data = {
      "orag_id": getData.read("UserLogin")["id"],
      "status": status != "" ? status : "1",
      "event_id": pType,
      "img": path != null ? base64Image.toString() : "0",
      "record_id": recordID
    };
    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$data");
    ApiWrapper.dataPost(AppUrl.editcoverimage, data).then((val) {
      print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$data");
      if ((val != null) && (val.isNotEmpty)) {
        if ((val['ResponseCode'] == "200") && (val['Result'] == "true")) {
          coverimageController.coverimagelist();
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        } else {
          ApiWrapper.showToastMessage(val["ResponseMsg"]);
        }
        isLoading = true;
        Get.back();
        update();
      }
    });
  }
}
