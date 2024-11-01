class FromJsonGetSessions {
  FromJsonGetSessions({
      List<SessionsModel>? data,}){
    _data = data;
}

  FromJsonGetSessions.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SessionsModel.fromJson(v));
      });
    }
  }
  List<SessionsModel>? _data;
FromJsonGetSessions copyWith({  List<SessionsModel>? data,
}) => FromJsonGetSessions(  data: data ?? _data,
);
  List<SessionsModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SessionsModel {
  SessionsModel({
    String? id,
      String? token, 
      String? app, 
      List<dynamic>? scopes,
    String? userId,
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _token = token;
    _app = app;
    _scopes = scopes;
    _userId = userId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  SessionsModel.fromJson(dynamic json) {
    _id = json['id'];
    _token = json['token'];
    _app = json['app'];
    if (json['scopes'] != null) {
      _scopes = [];
      json['scopes'].forEach((v) {
        _scopes?.add(v);
      });
    }
    _userId = json['user_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _token;
  String? _app;
  List<dynamic>? _scopes;
  String? _userId;
  String? _createdAt;
  String? _updatedAt;
SessionsModel copyWith({  String? id,
  String? token,
  String? app,
  List<dynamic>? scopes,
  String? userId,
  String? createdAt,
  String? updatedAt,
}) => SessionsModel(  id: id ?? _id,
  token: token ?? _token,
  app: app ?? _app,
  scopes: scopes ?? _scopes,
  userId: userId ?? _userId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get token => _token;
  String? get app => _app;
  List<dynamic>? get scopes => _scopes;
  String? get userId => _userId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['token'] = _token;
    map['app'] = _app;
    if (_scopes != null) {
      map['scopes'] = _scopes?.map((v) => v.toJson()).toList();
    }
    map['user_id'] = _userId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}