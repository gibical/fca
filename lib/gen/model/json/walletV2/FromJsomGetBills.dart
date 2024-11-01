import 'dart:convert';
FromJsomGetBills fromJsomGetBillsFromJson(String str) => FromJsomGetBills.fromJson(json.decode(str));
String fromJsomGetBillsToJson(FromJsomGetBills data) => json.encode(data.toJson());
class FromJsomGetBills {
  FromJsomGetBills({
      List<BilingModel>? data,}){
    _data = data;
}

  FromJsomGetBills.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BilingModel.fromJson(v));
      });
    }
  }
  List<BilingModel>? _data;

  List<BilingModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

BilingModel dataFromJson(String str) => BilingModel.fromJson(json.decode(str));
String dataToJson(BilingModel data) => json.encode(data.toJson());
class BilingModel {
  BilingModel({
      String? id, 
      String? relationType, 
      String? relationId, 
      num? amount, 
      num? discount, 
      String? description, 
      String? createdAt,}){
    _id = id;
    _relationType = relationType;
    _relationId = relationId;
    _amount = amount;
    _discount = discount;
    _description = description;
    _createdAt = createdAt;
}

  BilingModel.fromJson(dynamic json) {
    _id = json['id'];
    _relationType = json['relation_type'];
    _relationId = json['relation_id'];
    _amount = json['amount'];
    _discount = json['discount'];
    _description = json['description'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _relationType;
  String? _relationId;
  num? _amount;
  num? _discount;
  String? _description;
  String? _createdAt;

  String? get id => _id;
  String? get relationType => _relationType;
  String? get relationId => _relationId;
  num? get amount => _amount;
  num? get discount => _discount;
  String? get description => _description;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['relation_type'] = _relationType;
    map['relation_id'] = _relationId;
    map['amount'] = _amount;
    map['discount'] = _discount;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    return map;
  }

}