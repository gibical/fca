import 'dart:convert';

import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:mediaverse/gen/model/json/v2/FromJsonGetContentFromExplore.dart';
FromJsonGetSchedules fromJsonGetSchedulesFromJson(String str) => FromJsonGetSchedules.fromJson(json.decode(str));
String fromJsonGetSchedulesToJson(FromJsonGetSchedules data) => json.encode(data.toJson());
class FromJsonGetSchedules {
  FromJsonGetSchedules({
      List<SchedulesModel>? data,}){
    _data = data;
}

  FromJsonGetSchedules.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SchedulesModel.fromJson(v));
      });
    }
  }
  List<SchedulesModel>? _data;

  List<SchedulesModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

SchedulesModel dataFromJson(String str) => SchedulesModel.fromJson(json.decode(str));
String dataToJson(SchedulesModel data) => json.encode(data.toJson());
class SchedulesModel {
  SchedulesModel({
      String? id, 
      String? programId, 
      num? status, 
      String? startsAt, 
      String? createdAt,
    Programs? program,}){
    _id = id;
    _programId = programId;
    _status = status;
    _startsAt = startsAt;
    _createdAt = createdAt;
    _program = program;
}

  SchedulesModel.fromJson(dynamic json) {
    _id = json['id'];
    _programId = json['program_id'];
    _status = json['status'];
    _startsAt = json['starts_at'];
    _createdAt = json['created_at'];
    _program = json['program'] != null ? Programs.fromJson(json['program']) : null;
  }
  String? _id;
  String? _programId;
  num? _status;
  String? _startsAt;
  String? _createdAt;
  Programs? _program;

  String? get id => _id;
  String? get programId => _programId;
  num? get status => _status;
  String? get startsAt => _startsAt;
  String? get createdAt => _createdAt;
  Programs? get program => _program;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['program_id'] = _programId;
    map['status'] = _status;
    map['starts_at'] = _startsAt;
    map['created_at'] = _createdAt;
    if (_program != null) {
      map['program'] = _program?.toJson();
    }
    return map;
  }

}

Programs programFromJson(String str) => Programs.fromJson(json.decode(str));
String programToJson(Programs data) => json.encode(data.toJson());

ContentModel assetFromJson(String str) => ContentModel.fromJson(json.decode(str));
String assetToJson(ContentModel data) => json.encode(data.toJson());
