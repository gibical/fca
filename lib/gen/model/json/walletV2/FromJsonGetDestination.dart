import 'dart:convert';
FromJsonGetDestination fromJsonGetDestinationFromJson(String str) => FromJsonGetDestination.fromJson(json.decode(str));
String fromJsonGetDestinationToJson(FromJsonGetDestination data) => json.encode(data.toJson());
class FromJsonGetDestination {
  FromJsonGetDestination({
      List<DestinationModel>? data,}){
    _data = data;
}

  FromJsonGetDestination.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DestinationModel.fromJson(v));
      });
    }
  }
  List<DestinationModel>? _data;

  List<DestinationModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

DestinationModel dataFromJson(String str) => DestinationModel.fromJson(json.decode(str));
String dataToJson(DestinationModel data) => json.encode(data.toJson());
class DestinationModel {
  DestinationModel({
      String? id, 
      String? name, 
      String? userId, 
      String? type,
      String? details,
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _userId = userId;
    _type = type;
    _details = details;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  DestinationModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _userId = json['user_id'];
    _type = json['type'];
    _details = json['details'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _name;
  String? _userId;
  String? _type;
  String? _details;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get name => _name;
  String? get userId => _userId;
  String? get type => _type;
  String? get details => _details;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['details'] = _details;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}