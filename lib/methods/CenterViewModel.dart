import 'dart:convert';

import 'package:cowin/Models/CenterModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CenterViewModel {
  static List<CenterBlockModel> centres = [];
  static Future getCentresByDistrict({@required String distId}) async {
    String url = 'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict'
        '?district_id=${distId}&date=31-05-2021';
    print(url);
    http.Response res = await http.get(url);
    switch (res.statusCode) {
      case 200:
        CentresModel cm = CentresModel.fromJson(jsonDecode(res.body));
        print("length" + cm.centers.length.toString());
        for (int i = 0; i < cm.centers.length; i++) centres.add(cm.centers[i]);

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
