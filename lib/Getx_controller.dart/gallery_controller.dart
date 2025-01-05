// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:magicmate_organizer/Model%20class/galley_info.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/api_screens/data_store.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GalleryController extends GetxController implements GetxService {
  GalleryInfo? galleryInfo;
  bool isLoading = false;

  String galleyImage = "";
  String pType = "";
  String status = "";

  String? path;
  String? base64Image;

  GalleryController() {
    getGalleryList();
  }

  getGalleryList() async {
    try {
      isLoading = false;
      Map map = {
        "orag_id": getData.read("UserLogin")["id"],
      };
      Uri uri = Uri.parse(AppUrl.baseUrl + AppUrl.galleryList);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        galleryInfo = GalleryInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  editGallery({String? recordId}) async {
    try {
      isLoading = false;
      Map map = {
        "orag_id": getData.read("UserLogin")["id"],
        "status": status != "" ? status : "1",
        "img": path != null ? base64Image : "0",
        "record_id": recordId,
        "event_id": pType,
      };
      print(".-.-.-.-.-..-.-.-.-..-.-.-." + map.toString());
      Uri uri = Uri.parse(AppUrl.baseUrl + AppUrl.updategallery);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result["Result"] == "true") {
          getGalleryList();
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
          Get.back();
        } else {
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        }
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  addGallery() async {
    try {
      isLoading = false;
      Map map = {
        "orag_id": getData.read("UserLogin")["id"],
        "status": status != "" ? status : "1",
        "event_id": pType,
        "img": path != null ? base64Image : "0",
      };
      print(".-.-.-.-.-..-.-.-.-..-.-.-." + map.toString());
      Uri uri = Uri.parse(AppUrl.baseUrl + AppUrl.addGallery);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result["Result"] == "true") {
          getGalleryList();
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
          Get.back();
        } else {
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        }
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
