class FromJsonGetCalender {
  FromJsonGetCalender({
      List<CalenderModel>? data,}){
    _data = data;
}

  FromJsonGetCalender.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CalenderModel.fromJson(v));
      });
    }
  }
  List<CalenderModel>? _data;
FromJsonGetCalender copyWith({  List<CalenderModel>? data,
}) => FromJsonGetCalender(  data: data ?? _data,
);
  List<CalenderModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CalenderModel {
  CalenderModel({
      num? id, 
      num? assetId, 
      num? externalAccountId, 
      num? userId, 
      String? type, 
      dynamic details, 
      String? time, 
      num? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _assetId = assetId;
    _externalAccountId = externalAccountId;
    _userId = userId;
    _type = type;
    _details = details;
    _time = time;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  CalenderModel.fromJson(dynamic json) {
    _id = json['id'];
    _assetId = json['asset_id'];
    _externalAccountId = json['external_account_id'];
    _userId = json['user_id'];
    _type = json['type'];
    _details = json['details'];
    _time = json['time'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _assetId;
  num? _externalAccountId;
  num? _userId;
  String? _type;
  dynamic _details;
  String? _time;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
CalenderModel copyWith({  num? id,
  num? assetId,
  num? externalAccountId,
  num? userId,
  String? type,
  dynamic details,
  String? time,
  num? status,
  String? createdAt,
  String? updatedAt,
}) => CalenderModel(  id: id ?? _id,
  assetId: assetId ?? _assetId,
  externalAccountId: externalAccountId ?? _externalAccountId,
  userId: userId ?? _userId,
  type: type ?? _type,
  details: details ?? _details,
  time: time ?? _time,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get assetId => _assetId;
  num? get externalAccountId => _externalAccountId;
  num? get userId => _userId;
  String? get type => _type;
  dynamic get details => _details;
  String? get time => _time;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['asset_id'] = _assetId;
    map['external_account_id'] = _externalAccountId;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['details'] = _details;
    map['time'] = _time;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}