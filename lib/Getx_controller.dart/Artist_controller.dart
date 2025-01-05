// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_import, file_names, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:convert';

import 'package:magicmate_organizer/Getx_controller.dart/Eventtypeprice_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Listofevent_controller.dart';
import 'package:magicmate_organizer/Model%20class/Artist_model.dart';
import 'package:magicmate_organizer/Model%20class/Coupon_model.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/confrigation.dart';
import 'package:magicmate_organizer/api_screens/data_store.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ArtistController extends GetxController implements GetxService {
  bool isLoading = false;
  Artistinfo? artistinfo;

  artistlist() async {
    try {
      isLoading = false;
      Map data = {
        "orag_id": getData.read("UserLogin")["id"],
      };
      print(data.toString());
      Uri uri = Uri.parse(AppUrl.baseUrl + AppUrl.artistlist);
      var response = await http.post(
        uri,
        body: jsonEncode(data),
      );
      print("-------------Response=========" + response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result["Result"] == "true") {
          artistinfo = Artistinfo.fromJson(result);
        } else {
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        }
        // print(result.toString());
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
