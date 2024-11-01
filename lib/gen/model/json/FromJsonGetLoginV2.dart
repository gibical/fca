import 'dart:convert';
FromJsonGetLoginV2 fromJsonGetLoginV2FromJson(String str) => FromJsonGetLoginV2.fromJson(json.decode(str));
String fromJsonGetLoginV2ToJson(FromJsonGetLoginV2 data) => json.encode(data.toJson());
class FromJsonGetLoginV2 {
  FromJsonGetLoginV2({
      User? user, 
      String? token,}){
    _user = user;
    _token = token;
}

  FromJsonGetLoginV2.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    return map;
  }

}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? id, 
      String? code, 
      dynamic firstName, 
      dynamic lastName, 
      dynamic username, 
      String? cellphone, 
      String? cellphoneVerifiedAt, 
      dynamic email, 
      dynamic emailVerifiedAt, 
      dynamic imageId, 
      num? status, 
      num? source, 
      dynamic referrerId, 
      String? createdAt, 
      String? updatedAt, 
      dynamic referrer, 
      Address? address, 
      dynamic operator,}){
    _id = id;
    _code = code;
    _firstName = firstName;
    _lastName = lastName;
    _username = username;
    _cellphone = cellphone;
    _cellphoneVerifiedAt = cellphoneVerifiedAt;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _imageId = imageId;
    _status = status;
    _source = source;
    _referrerId = referrerId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _referrer = referrer;
    _address = address;
    _operator = operator;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _username = json['username'];
    _cellphone = json['cellphone'];
    _cellphoneVerifiedAt = json['cellphone_verified_at'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _imageId = json['image_id'];
    _status = json['status'];
    _source = json['source'];
    _referrerId = json['referrer_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _referrer = json['referrer'];
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _operator = json['operator'];
  }
  String? _id;
  String? _code;
  dynamic _firstName;
  dynamic _lastName;
  dynamic _username;
  String? _cellphone;
  String? _cellphoneVerifiedAt;
  dynamic _email;
  dynamic _emailVerifiedAt;
  dynamic _imageId;
  num? _status;
  num? _source;
  dynamic _referrerId;
  String? _createdAt;
  String? _updatedAt;
  dynamic _referrer;
  Address? _address;
  dynamic _operator;

  String? get id => _id;
  String? get code => _code;
  dynamic get firstName => _firstName;
  dynamic get lastName => _lastName;
  dynamic get username => _username;
  String? get cellphone => _cellphone;
  String? get cellphoneVerifiedAt => _cellphoneVerifiedAt;
  dynamic get email => _email;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  dynamic get imageId => _imageId;
  num? get status => _status;
  num? get source => _source;
  dynamic get referrerId => _referrerId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get referrer => _referrer;
  Address? get address => _address;
  dynamic get operator => _operator;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['username'] = _username;
    map['cellphone'] = _cellphone;
    map['cellphone_verified_at'] = _cellphoneVerifiedAt;
    map['email'] = _email;
    map['email_verified_at'] = _emailVerifiedAt;
    map['image_id'] = _imageId;
    map['status'] = _status;
    map['source'] = _source;
    map['referrer_id'] = _referrerId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['referrer'] = _referrer;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['operator'] = _operator;
    return map;
  }

}

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());
class Address {
  Address({
      String? id, 
      String? userId, 
      String? countryIso, 
      dynamic cityId, 
      dynamic postalCode, 
      dynamic line1, 
      dynamic line2, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _countryIso = countryIso;
    _cityId = cityId;
    _postalCode = postalCode;
    _line1 = line1;
    _line2 = line2;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Address.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _countryIso = json['country_iso'];
    _cityId = json['city_id'];
    _postalCode = json['postal_code'];
    _line1 = json['line1'];
    _line2 = json['line2'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userId;
  String? _countryIso;
  dynamic _cityId;
  dynamic _postalCode;
  dynamic _line1;
  dynamic _line2;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get userId => _userId;
  String? get countryIso => _countryIso;
  dynamic get cityId => _cityId;
  dynamic get postalCode => _postalCode;
  dynamic get line1 => _line1;
  dynamic get line2 => _line2;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['country_iso'] = _countryIso;
    map['city_id'] = _cityId;
    map['postal_code'] = _postalCode;
    map['line1'] = _line1;
    map['line2'] = _line2;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}