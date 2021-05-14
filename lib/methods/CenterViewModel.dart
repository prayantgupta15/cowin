import 'dart:convert';

import 'package:cowin/Models/CenterModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CenterViewModel {
  static List<CenterBlockModel> centres = [];
  static Future getCentresByDistrict({@required String distId}) async {
    String url = 'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict'
        '?district_id=${distId}&date=31-05-2021';
    http.Response res = await http.get(url);
    switch (res.statusCode) {
      case 200:
        print((jsonDecode(res.body)).toString().split('}, ')[0]);
        print((jsonDecode(res.body)['centers']).toString().split('}, ')[0]);
        String str = (jsonDecode(res.body)['centers']).toString().split('}, ')[0];
        CenterBlockModel.fromJson(str);
        // CenterModel cm = CenterModel.fromJson((jsonDecode(res.body)).toString().split('}, ')[0]);
        // CenterModel cm = CenterModel.fromJson(jsonDecode(res.body));
        // print("length" + cm.centers.length.toString());
        // for (int i = 0; i < cm.centers.length; i++) centres.add(cm.centers[i]);

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
