import 'dart:convert';

import 'package:cowin/Models/CenterModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DistrictViewModel {
  static List<CenterBlockModel> centers = [];

  static Future getDistricts(
      {@required int districtId, @required String date}) async {
    // TODO: setting body for get api from below link
    // https://apisetu.gov.in/public/marketplace/api/cowin/cowin-public-v2#/Appointment%20Availability%20APIs/calendarByDistrict
    var body = {};
    String url =
        'https://cdn-api.co-vin.in/api/v2/admin/location/districts/}';
    http.Response res = await http.get(url);
    print(res.body);
    switch (res.statusCode) {
      case 200:
        CenterModel cm = CenterModel.fromJson(jsonDecode(res.body));
        for (int i = 0; i < cm.centers.length; i++) centers.add(cm.centers[i]);
        return;
        break;
      case 401:
        print("Auth Error");
        break;
      case 500:
        print("Auth Error");
        break;
    }
  }
}
