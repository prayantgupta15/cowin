// To parse this JSON data, do
//
//     final CenterModel = CenterModelFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class CenterModel {
  CenterModel({
    @required this.centers,
  });

  List<CenterBlockModel> centers;

  factory CenterModel.fromJson(String str) => CenterModel.fromMap(json.decode(str));

  factory CenterModel.fromMap(Map<String, dynamic> json) => CenterModel(
        centers: json["centers"] == null
            ? null
            : List<CenterBlockModel>.from(json["centers"].map((x) => CenterBlockModel.fromMap(x))),
      );
}

class CenterBlockModel {
  CenterBlockModel({
    @required this.centerId,
    @required this.name,
    @required this.address,
    @required this.stateName,
    @required this.districtName,
    @required this.blockName,
    @required this.pincode,
    // @required this.lat,
    // @required this.long,
    // @required this.from,
    // @required this.to,
    @required this.feeType,
    // @required this.vaccineFees,
    @required this.sessions,
  });

  int centerId;
  String name;
  String address;
  String stateName;
  String districtName;
  String blockName;
  String pincode;
  // double lat;
  // double long;
  // String from;
  // String to;
  String feeType;
  // List<VaccineFee> vaccineFees;
  List<Session> sessions;

  factory CenterBlockModel.fromJson(String str) => CenterBlockModel.fromMap(json.decode(str));

  factory CenterBlockModel.fromMap(Map<String, dynamic> json) => CenterBlockModel(
        centerId: json["center_id"] == null ? null : json["center_id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        stateName: json["state_name"] == null ? null : json["state_name"],
        districtName: json["district_name"] == null ? null : json["district_name"],
        blockName: json["block_name"] == null ? null : json["block_name"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        // lat: json["lat"] == null ? null : json["lat"].toDouble(),
        // long: json["long"] == null ? null : json["long"].toDouble(),
        // from: json["from"] == null ? null : json["from"],
        // to: json["to"] == null ? null : json["to"],
        feeType: json["fee_type"] == null ? null : json["fee_type"],
        sessions: json["sessions"] == null ? null : List<Session>.from(json["sessions"].map((x) => Session.fromMap(x))),
      );
}

class Session {
  Session({
    @required this.sessionId,
    @required this.date,
    @required this.availableCapacity,
    // @required this.availableCapacityDose1,
    // @required this.availableCapacityDose2,
    @required this.minAgeLimit,
    @required this.vaccine,
    @required this.slots,
  });

  String sessionId;
  String date;
  int availableCapacity;
  // int availableCapacityDose1;
  // int availableCapacityDose2;
  int minAgeLimit;
  String vaccine;
  List<String> slots;

  factory Session.fromJson(String str) => Session.fromMap(json.decode(str));

  factory Session.fromMap(Map<String, dynamic> json) => Session(
        sessionId: json["session_id"] == null ? null : json["session_id"],
        date: json["date"] == null ? null : json["date"],
        availableCapacity: json["available_capacity"] == null ? null : json["available_capacity"],
        // availableCapacityDose1: json["available_capacity_dose1"] == null ? null : json["available_capacity_dose1"],
        // availableCapacityDose2: json["available_capacity_dose2"] == null ? null : json["available_capacity_dose2"],
        minAgeLimit: json["min_age_limit"] == null ? null : json["min_age_limit"],
        vaccine: json["vaccine"] == null ? null : json["vaccine"],
        slots: json["slots"] == null ? null : List<String>.from(json["slots"].map((x) => x)),
      );
}
