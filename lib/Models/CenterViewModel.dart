// To parse this JSON data, do
//
//     final centerViewModel = centerViewModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CenterViewModel {
  CenterViewModel({
    @required this.centers,
  });

  List<Center> centers;

  factory CenterViewModel.fromJson(String str) => CenterViewModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CenterViewModel.fromMap(Map<String, dynamic> json) => CenterViewModel(
    centers: json["centers"] == null ? null : List<Center>.from(json["centers"].map((x) => Center.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "centers": centers == null ? null : List<dynamic>.from(centers.map((x) => x.toMap())),
  };
}

class Center {
  Center({
    @required this.centerId,
    @required this.name,
    @required this.address,
    @required this.stateName,
    @required this.districtName,
    @required this.blockName,
    @required this.pincode,
    @required this.lat,
    @required this.long,
    @required this.from,
    @required this.to,
    @required this.feeType,
    @required this.vaccineFees,
    @required this.sessions,
  });

  int centerId;
  String name;
  String address;
  String stateName;
  String districtName;
  String blockName;
  String pincode;
  double lat;
  double long;
  String from;
  String to;
  String feeType;
  List<VaccineFee> vaccineFees;
  List<Session> sessions;

  factory Center.fromJson(String str) => Center.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Center.fromMap(Map<String, dynamic> json) => Center(
    centerId: json["center_id"] == null ? null : json["center_id"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    stateName: json["state_name"] == null ? null : json["state_name"],
    districtName: json["district_name"] == null ? null : json["district_name"],
    blockName: json["block_name"] == null ? null : json["block_name"],
    pincode: json["pincode"] == null ? null : json["pincode"],
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    long: json["long"] == null ? null : json["long"].toDouble(),
    from: json["from"] == null ? null : json["from"],
    to: json["to"] == null ? null : json["to"],
    feeType: json["fee_type"] == null ? null : json["fee_type"],
    vaccineFees: json["vaccine_fees"] == null ? null : List<VaccineFee>.from(json["vaccine_fees"].map((x) => VaccineFee.fromMap(x))),
    sessions: json["sessions"] == null ? null : List<Session>.from(json["sessions"].map((x) => Session.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "center_id": centerId == null ? null : centerId,
    "name": name == null ? null : name,
    "address": address == null ? null : address,
    "state_name": stateName == null ? null : stateName,
    "district_name": districtName == null ? null : districtName,
    "block_name": blockName == null ? null : blockName,
    "pincode": pincode == null ? null : pincode,
    "lat": lat == null ? null : lat,
    "long": long == null ? null : long,
    "from": from == null ? null : from,
    "to": to == null ? null : to,
    "fee_type": feeType == null ? null : feeType,
    "vaccine_fees": vaccineFees == null ? null : List<dynamic>.from(vaccineFees.map((x) => x.toMap())),
    "sessions": sessions == null ? null : List<dynamic>.from(sessions.map((x) => x.toMap())),
  };
}

class Session {
  Session({
    @required this.sessionId,
    @required this.date,
    @required this.availableCapacity,
    @required this.availableCapacityDose1,
    @required this.availableCapacityDose2,
    @required this.minAgeLimit,
    @required this.vaccine,
    @required this.slots,
  });

  String sessionId;
  String date;
  int availableCapacity;
  int availableCapacityDose1;
  int availableCapacityDose2;
  int minAgeLimit;
  String vaccine;
  List<String> slots;

  factory Session.fromJson(String str) => Session.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Session.fromMap(Map<String, dynamic> json) => Session(
    sessionId: json["session_id"] == null ? null : json["session_id"],
    date: json["date"] == null ? null : json["date"],
    availableCapacity: json["available_capacity"] == null ? null : json["available_capacity"],
    availableCapacityDose1: json["available_capacity_dose1"] == null ? null : json["available_capacity_dose1"],
    availableCapacityDose2: json["available_capacity_dose2"] == null ? null : json["available_capacity_dose2"],
    minAgeLimit: json["min_age_limit"] == null ? null : json["min_age_limit"],
    vaccine: json["vaccine"] == null ? null : json["vaccine"],
    slots: json["slots"] == null ? null : List<String>.from(json["slots"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "session_id": sessionId == null ? null : sessionId,
    "date": date == null ? null : date,
    "available_capacity": availableCapacity == null ? null : availableCapacity,
    "available_capacity_dose1": availableCapacityDose1 == null ? null : availableCapacityDose1,
    "available_capacity_dose2": availableCapacityDose2 == null ? null : availableCapacityDose2,
    "min_age_limit": minAgeLimit == null ? null : minAgeLimit,
    "vaccine": vaccine == null ? null : vaccine,
    "slots": slots == null ? null : List<dynamic>.from(slots.map((x) => x)),
  };
}

class VaccineFee {
  VaccineFee({
    @required this.vaccine,
    @required this.fee,
  });

  String vaccine;
  String fee;

  factory VaccineFee.fromJson(String str) => VaccineFee.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VaccineFee.fromMap(Map<String, dynamic> json) => VaccineFee(
    vaccine: json["vaccine"] == null ? null : json["vaccine"],
    fee: json["fee"] == null ? null : json["fee"],
  );

  Map<String, dynamic> toMap() => {
    "vaccine": vaccine == null ? null : vaccine,
    "fee": fee == null ? null : fee,
  };
}
