import 'dart:convert';
FromJsonGetProgramSchedules fromJsonGetProgramSchedulesFromJson(String str) => FromJsonGetProgramSchedules.fromJson(json.decode(str));
String fromJsonGetProgramSchedulesToJson(FromJsonGetProgramSchedules data) => json.encode(data.toJson());
class FromJsonGetProgramSchedules {
  FromJsonGetProgramSchedules({
      List<ProgramSchedulesModel>? data,}){
    _data = data;
}

  FromJsonGetProgramSchedules.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProgramSchedulesModel.fromJson(v));
      });
    }
  }
  List<ProgramSchedulesModel>? _data;

  List<ProgramSchedulesModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

ProgramSchedulesModel dataFromJson(String str) => ProgramSchedulesModel.fromJson(json.decode(str));
String dataToJson(ProgramSchedulesModel data) => json.encode(data.toJson());
class ProgramSchedulesModel {
  ProgramSchedulesModel({
      String? id, 
      String? programId, 
      num? status, 
      String? startsAt, 
      String? createdAt,}){
    _id = id;
    _programId = programId;
    _status = status;
    _startsAt = startsAt;
    _createdAt = createdAt;
}

  ProgramSchedulesModel.fromJson(dynamic json) {
    _id = json['id'];
    _programId = json['program_id'];
    _status = json['status'];
    _startsAt = json['starts_at'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _programId;
  num? _status;
  String? _startsAt;
  String? _createdAt;

  String? get id => _id;
  String? get programId => _programId;
  num? get status => _status;
  String? get startsAt => _startsAt;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['program_id'] = _programId;
    map['status'] = _status;
    map['starts_at'] = _startsAt;
    map['created_at'] = _createdAt;
    return map;
  }

}