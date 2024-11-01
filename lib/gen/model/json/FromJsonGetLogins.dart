class FromJsonGetLogins {
  FromJsonGetLogins({
      List<LoginModel>? data,}){
    _data = data;
}

  FromJsonGetLogins.fromJson(dynamic json) {
    if (json!= null) {
      _data = [];
      json.forEach((v) {
        _data?.add(LoginModel.fromJson(v));
      });
    }
  }
  List<LoginModel>? _data;
FromJsonGetLogins copyWith({  List<LoginModel>? data,
}) => FromJsonGetLogins(  data: data ?? _data,
);
  List<LoginModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class LoginModel {
  LoginModel({
      num? id, 
      String? ip, 
      String? details, 
      num? userId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _ip = ip;
    _details = details;
    _userId = userId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  LoginModel.fromJson(dynamic json) {
    _id = json['id'];
    _ip = json['ip'];
    _details = json['details'];
    _userId = json['user_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _ip;
  String? _details;
  num? _userId;
  String? _createdAt;
  String? _updatedAt;
LoginModel copyWith({  num? id,
  String? ip,
  String? details,
  num? userId,
  String? createdAt,
  String? updatedAt,
}) => LoginModel(  id: id ?? _id,
  ip: ip ?? _ip,
  details: details ?? _details,
  userId: userId ?? _userId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get ip => _ip;
  String? get details => _details;
  num? get userId => _userId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ip'] = _ip;
    map['details'] = _details;
    map['user_id'] = _userId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}