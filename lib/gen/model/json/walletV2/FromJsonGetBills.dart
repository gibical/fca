import 'dart:convert';
FromJsonGetBills fromJsonGetBillsFromJson(String str) => FromJsonGetBills.fromJson(json.decode(str));
String fromJsonGetBillsToJson(FromJsonGetBills data) => json.encode(data.toJson());
class FromJsonGetBills {
  FromJsonGetBills({
      List<BillsModel>? data,
      Links? links, 
      Meta? meta,}){
    _data = data;
    _links = links;
    _meta = meta;
}

  FromJsonGetBills.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BillsModel.fromJson(v));
      });
    }
    _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<BillsModel>? _data;
  Links? _links;
  Meta? _meta;

  List<BillsModel>? get data => _data;
  Links? get links => _links;
  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_links != null) {
      map['links'] = _links?.toJson();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }

}

Meta metaFromJson(String str) => Meta.fromJson(json.decode(str));
String metaToJson(Meta data) => json.encode(data.toJson());
class Meta {
  Meta({
      String? path, 
      num? perPage, 
      dynamic nextCursor, 
      dynamic prevCursor,}){
    _path = path;
    _perPage = perPage;
    _nextCursor = nextCursor;
    _prevCursor = prevCursor;
}

  Meta.fromJson(dynamic json) {
    _path = json['path'];
    _perPage = json['per_page'];
    _nextCursor = json['next_cursor'];
    _prevCursor = json['prev_cursor'];
  }
  String? _path;
  num? _perPage;
  dynamic _nextCursor;
  dynamic _prevCursor;

  String? get path => _path;
  num? get perPage => _perPage;
  dynamic get nextCursor => _nextCursor;
  dynamic get prevCursor => _prevCursor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['next_cursor'] = _nextCursor;
    map['prev_cursor'] = _prevCursor;
    return map;
  }

}

Links linksFromJson(String str) => Links.fromJson(json.decode(str));
String linksToJson(Links data) => json.encode(data.toJson());
class Links {
  Links({
      dynamic first, 
      dynamic last, 
      dynamic prev, 
      dynamic next,}){
    _first = first;
    _last = last;
    _prev = prev;
    _next = next;
}

  Links.fromJson(dynamic json) {
    _first = json['first'];
    _last = json['last'];
    _prev = json['prev'];
    _next = json['next'];
  }
  dynamic _first;
  dynamic _last;
  dynamic _prev;
  dynamic _next;

  dynamic get first => _first;
  dynamic get last => _last;
  dynamic get prev => _prev;
  dynamic get next => _next;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first'] = _first;
    map['last'] = _last;
    map['prev'] = _prev;
    map['next'] = _next;
    return map;
  }

}

BillsModel dataFromJson(String str) => BillsModel.fromJson(json.decode(str));
String dataToJson(BillsModel data) => json.encode(data.toJson());
class BillsModel {
  BillsModel({
      String? id, 
      String? relationType, 
      String? relationId, 
      num? amount, 
      num? discount, 
      dynamic description, 
      String? createdAt, 
      User? user,}){
    _id = id;
    _relationType = relationType;
    _relationId = relationId;
    _amount = amount;
    _discount = discount;
    _description = description;
    _createdAt = createdAt;
    _user = user;
}

  BillsModel.fromJson(dynamic json) {
    _id = json['id'];
    _relationType = json['relation_type'];
    _relationId = json['relation_id'];
    _amount = json['amount'];
    _discount = json['discount'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _id;
  String? _relationType;
  String? _relationId;
  num? _amount;
  num? _discount;
  dynamic _description;
  String? _createdAt;
  User? _user;

  String? get id => _id;
  String? get relationType => _relationType;
  String? get relationId => _relationId;
  num? get amount => _amount;
  num? get discount => _discount;
  dynamic get description => _description;
  String? get createdAt => _createdAt;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['relation_type'] = _relationType;
    map['relation_id'] = _relationId;
    map['amount'] = _amount;
    map['discount'] = _discount;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? id, 
      String? code, 
      String? firstName, 
      dynamic lastName, 
      String? fullName, 
      String? username, 
      String? cellphone, 
      String? cellphoneVerifiedAt, 
      dynamic email, 
      dynamic emailVerifiedAt, 
      String? imageUrl, 
      num? status, 
      num? source, 
      dynamic referrerId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _code = code;
    _firstName = firstName;
    _lastName = lastName;
    _fullName = fullName;
    _username = username;
    _cellphone = cellphone;
    _cellphoneVerifiedAt = cellphoneVerifiedAt;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _imageUrl = imageUrl;
    _status = status;
    _source = source;
    _referrerId = referrerId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _fullName = json['full_name'];
    _username = json['username'];
    _cellphone = json['cellphone'];
    _cellphoneVerifiedAt = json['cellphone_verified_at'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _imageUrl = json['image_url'];
    _status = json['status'];
    _source = json['source'];
    _referrerId = json['referrer_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _code;
  String? _firstName;
  dynamic _lastName;
  String? _fullName;
  String? _username;
  String? _cellphone;
  String? _cellphoneVerifiedAt;
  dynamic _email;
  dynamic _emailVerifiedAt;
  String? _imageUrl;
  num? _status;
  num? _source;
  dynamic _referrerId;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get code => _code;
  String? get firstName => _firstName;
  dynamic get lastName => _lastName;
  String? get fullName => _fullName;
  String? get username => _username;
  String? get cellphone => _cellphone;
  String? get cellphoneVerifiedAt => _cellphoneVerifiedAt;
  dynamic get email => _email;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String? get imageUrl => _imageUrl;
  num? get status => _status;
  num? get source => _source;
  dynamic get referrerId => _referrerId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['full_name'] = _fullName;
    map['username'] = _username;
    map['cellphone'] = _cellphone;
    map['cellphone_verified_at'] = _cellphoneVerifiedAt;
    map['email'] = _email;
    map['email_verified_at'] = _emailVerifiedAt;
    map['image_url'] = _imageUrl;
    map['status'] = _status;
    map['source'] = _source;
    map['referrer_id'] = _referrerId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}