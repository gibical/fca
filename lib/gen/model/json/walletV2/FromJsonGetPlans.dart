import 'dart:convert';
FromJsonGetPlans fromJsonGetPlansFromJson(String str) => FromJsonGetPlans.fromJson(json.decode(str));
String fromJsonGetPlansToJson(FromJsonGetPlans data) => json.encode(data.toJson());
class FromJsonGetPlans {
  FromJsonGetPlans({
      List<PlansModel>? data,}){
    _data = data;
}

  FromJsonGetPlans.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PlansModel.fromJson(v));
      });
    }
  }
  List<PlansModel>? _data;

  List<PlansModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

PlansModel dataFromJson(String str) => PlansModel.fromJson(json.decode(str));
String dataToJson(PlansModel data) => json.encode(data.toJson());
class PlansModel {
  PlansModel({
      String? id, 
      String? name, 
      String? description, 
      num? price,}){
    _id = id;
    _name = name;
    _description = description;
    _price = price;
}

  PlansModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
  }
  String? _id;
  String? _name;
  String? _description;
  num? _price;

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  num? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['price'] = _price;
    return map;
  }

}