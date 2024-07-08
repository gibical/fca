class ProfileModel {
  ProfileModel({
      num? id, 
      String? firstName, 
      String? lastName, 
      String? username, 
      String? cellphone, 
      String? cellphoneVerifiedAt, 
      String? email, 
      dynamic emailVerifiedAt, 
      dynamic imageId, 
      num? status, 
      num? source, 
      dynamic referrerId, 
      String? createdAt, 
      String? updatedAt, 
      String? imageUrl, 
      dynamic referrer, 
      List<dynamic>? financialRecords, 
      dynamic address, 
      Operator? operator, 
      dynamic image,}){
    _id = id;
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
    _imageUrl = imageUrl;
    _referrer = referrer;
    _financialRecords = financialRecords;
    _address = address;
    _operator = operator;
    _image = image;
}

  ProfileModel.fromJson(dynamic jsons) {
    var json = jsons['data'];
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _username = json['username'];
    _cellphone = json['cellphone'];
    _cellphoneVerifiedAt = json['cellphone_verified_at'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _imageId = json['image_url'];
    _status = json['status'];
    _source = json['source'];
    _referrerId = json['referrer_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imageUrl = json['image_url'];
    _referrer = json['referrer'];
    if (json['financial_records'] != null) {
      _financialRecords = [];
      json['financial_records'].forEach((v) {
        _financialRecords?.add(v);
      });
    }
    _address = json['address'];
    _operator = json['operator'] != null ? Operator.fromJson(json['operator']) : null;
    _image = json['image'];
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _username;
  String? _cellphone;
  String? _cellphoneVerifiedAt;
  String? _email;
  dynamic _emailVerifiedAt;
  dynamic _imageId;
  num? _status;
  num? _source;
  dynamic _referrerId;
  String? _createdAt;
  String? _updatedAt;
  String? _imageUrl;
  dynamic _referrer;
  List<dynamic>? _financialRecords;
  dynamic _address;
  Operator? _operator;
  dynamic _image;
ProfileModel copyWith({  num? id,
  String? firstName,
  String? lastName,
  String? username,
  String? cellphone,
  String? cellphoneVerifiedAt,
  String? email,
  dynamic emailVerifiedAt,
  dynamic imageId,
  num? status,
  num? source,
  dynamic referrerId,
  String? createdAt,
  String? updatedAt,
  String? imageUrl,
  dynamic referrer,
  List<dynamic>? financialRecords,
  dynamic address,
  Operator? operator,
  dynamic image,
}) => ProfileModel(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  username: username ?? _username,
  cellphone: cellphone ?? _cellphone,
  cellphoneVerifiedAt: cellphoneVerifiedAt ?? _cellphoneVerifiedAt,
  email: email ?? _email,
  emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
  imageId: imageId ?? _imageId,
  status: status ?? _status,
  source: source ?? _source,
  referrerId: referrerId ?? _referrerId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  imageUrl: imageUrl ?? _imageUrl,
  referrer: referrer ?? _referrer,
  financialRecords: financialRecords ?? _financialRecords,
  address: address ?? _address,
  operator: operator ?? _operator,
  image: image ?? _image,
);
  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get username => _username;
  String? get cellphone => _cellphone;
  String? get cellphoneVerifiedAt => _cellphoneVerifiedAt;
  String? get email => _email;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  dynamic get imageId => _imageId;
  num? get status => _status;
  num? get source => _source;
  dynamic get referrerId => _referrerId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get imageUrl => _imageUrl;
  dynamic get referrer => _referrer;
  List<dynamic>? get financialRecords => _financialRecords;
  dynamic get address => _address;
  Operator? get operator => _operator;
  dynamic get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
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
    map['image_url'] = _imageUrl;
    map['referrer'] = _referrer;
    if (_financialRecords != null) {
      map['financial_records'] = _financialRecords?.map((v) => v.toJson()).toList();
    }
    map['address'] = _address;
    if (_operator != null) {
      map['operator'] = _operator?.toJson();
    }
    map['image'] = _image;
    return map;
  }

}

class Operator {
  Operator({
      num? id, 
      num? userId, 
      List<String>? permissions, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _permissions = permissions;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Operator.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _permissions = json['permissions'] != null ? json['permissions'].cast<String>() : [];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _userId;
  List<String>? _permissions;
  String? _createdAt;
  String? _updatedAt;
Operator copyWith({  num? id,
  num? userId,
  List<String>? permissions,
  String? createdAt,
  String? updatedAt,
}) => Operator(  id: id ?? _id,
  userId: userId ?? _userId,
  permissions: permissions ?? _permissions,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get userId => _userId;
  List<String>? get permissions => _permissions;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['permissions'] = _permissions;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}