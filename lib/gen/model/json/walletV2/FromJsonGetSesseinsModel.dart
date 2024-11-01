import 'dart:convert';
FromJsonGetSesseinsModel fromJsonGetSesseinsModelFromJson(String str) => FromJsonGetSesseinsModel.fromJson(json.decode(str));
String fromJsonGetSesseinsModelToJson(FromJsonGetSesseinsModel data) => json.encode(data.toJson());
class FromJsonGetSesseinsModel {
  FromJsonGetSesseinsModel({
      List<SessionsModels>? data,}){
    _data = data;
}

  FromJsonGetSesseinsModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SessionsModels.fromJson(v));
      });
    }
  }
  List<SessionsModels>? _data;

  List<SessionsModels>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

SessionsModels dataFromJson(String str) => SessionsModels.fromJson(json.decode(str));
String dataToJson(SessionsModels data) => json.encode(data.toJson());
class SessionsModels {
  SessionsModels({
      String? id, 
      String? userId, 
      String? clientId, 
      String? name, 
      List<String>? scopes, 
      bool? revoked, 
      String? details, 
      String? createdAt, 
      String? updatedAt, 
      String? expiresAt,}){
    _id = id;
    _userId = userId;
    _clientId = clientId;
    _name = name;
    _scopes = scopes;
    _revoked = revoked;
    _details = details;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _expiresAt = expiresAt;
}

  SessionsModels.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _clientId = json['client_id'];
    _name = json['name'];
    _scopes = json['scopes'] != null ? json['scopes'].cast<String>() : [];
    _revoked = json['revoked'];
    _details = json['details'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _expiresAt = json['expires_at'];
  }
  String? _id;
  String? _userId;
  String? _clientId;
  String? _name;
  List<String>? _scopes;
  bool? _revoked;
  String? _details;
  String? _createdAt;
  String? _updatedAt;
  String? _expiresAt;

  String? get id => _id;
  String? get userId => _userId;
  String? get clientId => _clientId;
  String? get name => _name;
  List<String>? get scopes => _scopes;
  bool? get revoked => _revoked;
  String? get details => _details;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get expiresAt => _expiresAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['client_id'] = _clientId;
    map['name'] = _name;
    map['scopes'] = _scopes;
    map['revoked'] = _revoked;
    map['details'] = _details;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['expires_at'] = _expiresAt;
    return map;
  }

}