// ignore_for_file: avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:magicmate_organizer/Model%20class/Pagelist_model.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/api_screens/data_store.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PageListController extends GetxController implements GetxService {
  DynamicPageData? dynamicPageData;
  bool isLodding = false;

  PageListController() {
    getPageListData();
  }

  getPageListData() async {
    try {
      Uri uri = Uri.parse(AppUrl.baseUrl + AppUrl.pagelist);
      var response = await http.post(uri);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result.toString());
        dynamicPageData = DynamicPageData.fromJson(result);
        isLodding = true;
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  updateProfileImage(String? base64image) async {
    try {
      Map map = {
        "orag_id": getData.read("UserLogin")["id"].toString(),
        "img": base64image,
      };
      print(".:.:.:.:.:.:.:.:.:..." + map.toString());
      Uri uri = Uri.parse(AppUrl.baseUrl + AppUrl.profileUpdate);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print(".:.:.:.:.:.:.:.:.:..." + response.body.toString());
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        save("UserLogin", result["OragnizerLogin"]);
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  deletAccount() async {
    try {
      Map map = {
        "orag_id": getData.read("UserLogin")["id"],
      };
      print(map.toString());
      Uri uri = Uri.parse(AppUrl.baseUrl + AppUrl.deletAccount);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        Get.back();
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  editProfileApi({
    String? email,
    String? name,
    String? password,
  }) async {
    try {
      Map map = {
        "email": email,
        "password": password,
        "orag_id": getData.read("UserLogin")["id"].toString(),
        "name": name,
      };
      Uri uri = Uri.parse(AppUrl.baseUrl + AppUrl.editProfile);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print(":::::::::|||||||||||::::::::::" + response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        ApiWrapper.showToastMessage(result["ResponseMsg"]);
        save("UserLogin", result["OragnizerLogin"]);
      }
      Get.back();
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
