class SongsModel {
  SongsModel({
      num? id, 
      num? assetId, 
      String? name, 
      num? type, 
      String? description, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      Asset? asset,}){
    _id = id;
    _assetId = assetId;
    _name = name;
    _type = type;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _asset = asset;
}

  SongsModel.fromJson(dynamic json) {
    _id = json['id'];
    _assetId = json['asset_id'];
    _name = json['name'];
    _type = json['type'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _asset = json['asset'] != null ? Asset.fromJson(json['asset']) : null;
  }
  num? _id;
  num? _assetId;
  String? _name;
  num? _type;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  Asset? _asset;
SongsModel copyWith({  num? id,
  num? assetId,
  String? name,
  num? type,
  String? description,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  Asset? asset,
}) => SongsModel(  id: id ?? _id,
  assetId: assetId ?? _assetId,
  name: name ?? _name,
  type: type ?? _type,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  asset: asset ?? _asset,
);
  num? get id => _id;
  num? get assetId => _assetId;
  String? get name => _name;
  num? get type => _type;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  Asset? get asset => _asset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['asset_id'] = _assetId;
    map['name'] = _name;
    map['type'] = _type;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    if (_asset != null) {
      map['asset'] = _asset?.toJson();
    }
    return map;
  }

}

class Asset {
  Asset({
      num? id, 
      num? userId, 
      num? fileId, 
      dynamic parentId, 
      num? type, 
      num? plan, 
      num? status, 
      num? price, 
      num? subscriptionPeriod, 
      num? source, 
      num? commentingStatus, 
      dynamic lat, 
      dynamic lng, 
      num? forkabilityStatus, 
      Details? details, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      num? salesVolume, 
      num? salesNumber, 
      num? viewsCount, 
      Thumbnails? thumbnails, 
      User? user,}){
    _id = id;
    _userId = userId;
    _fileId = fileId;
    _parentId = parentId;
    _type = type;
    _plan = plan;
    _status = status;
    _price = price;
    _subscriptionPeriod = subscriptionPeriod;
    _source = source;
    _commentingStatus = commentingStatus;
    _lat = lat;
    _lng = lng;
    _forkabilityStatus = forkabilityStatus;
    _details = details;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _salesVolume = salesVolume;
    _salesNumber = salesNumber;
    _viewsCount = viewsCount;
    _thumbnails = thumbnails;
    _user = user;
}

  Asset.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _fileId = json['file_id'];
    _parentId = json['parent_id'];
    _type = json['type'];
    _plan = json['plan'];
    _status = json['status'];
    _price = json['price'];
    _subscriptionPeriod = json['subscription_period'];
    _source = json['source'];
    _commentingStatus = json['commenting_status'];
    _lat = json['lat'];
    _lng = json['lng'];
    _forkabilityStatus = json['forkability_status'];
    _details = json['details'] != null ? Details.fromJson(json['details']) : null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _salesVolume = json['sales_volume'];
    _salesNumber = json['sales_number'];
    _viewsCount = json['views_count'];
    _thumbnails = json['thumbnails'] != null ? Thumbnails.fromJson(json['thumbnails']) : null;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  num? _id;
  num? _userId;
  num? _fileId;
  dynamic _parentId;
  num? _type;
  num? _plan;
  num? _status;
  num? _price;
  num? _subscriptionPeriod;
  num? _source;
  num? _commentingStatus;
  dynamic _lat;
  dynamic _lng;
  num? _forkabilityStatus;
  Details? _details;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  num? _salesVolume;
  num? _salesNumber;
  num? _viewsCount;
  Thumbnails? _thumbnails;
  User? _user;
Asset copyWith({  num? id,
  num? userId,
  num? fileId,
  dynamic parentId,
  num? type,
  num? plan,
  num? status,
  num? price,
  num? subscriptionPeriod,
  num? source,
  num? commentingStatus,
  dynamic lat,
  dynamic lng,
  num? forkabilityStatus,
  Details? details,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  num? salesVolume,
  num? salesNumber,
  num? viewsCount,
  Thumbnails? thumbnails,
  User? user,
}) => Asset(  id: id ?? _id,
  userId: userId ?? _userId,
  fileId: fileId ?? _fileId,
  parentId: parentId ?? _parentId,
  type: type ?? _type,
  plan: plan ?? _plan,
  status: status ?? _status,
  price: price ?? _price,
  subscriptionPeriod: subscriptionPeriod ?? _subscriptionPeriod,
  source: source ?? _source,
  commentingStatus: commentingStatus ?? _commentingStatus,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
  forkabilityStatus: forkabilityStatus ?? _forkabilityStatus,
  details: details ?? _details,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  salesVolume: salesVolume ?? _salesVolume,
  salesNumber: salesNumber ?? _salesNumber,
  viewsCount: viewsCount ?? _viewsCount,
  thumbnails: thumbnails ?? _thumbnails,
  user: user ?? _user,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get fileId => _fileId;
  dynamic get parentId => _parentId;
  num? get type => _type;
  num? get plan => _plan;
  num? get status => _status;
  num? get price => _price;
  num? get subscriptionPeriod => _subscriptionPeriod;
  num? get source => _source;
  num? get commentingStatus => _commentingStatus;
  dynamic get lat => _lat;
  dynamic get lng => _lng;
  num? get forkabilityStatus => _forkabilityStatus;
  Details? get details => _details;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  num? get salesVolume => _salesVolume;
  num? get salesNumber => _salesNumber;
  num? get viewsCount => _viewsCount;
  Thumbnails? get thumbnails => _thumbnails;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['file_id'] = _fileId;
    map['parent_id'] = _parentId;
    map['type'] = _type;
    map['plan'] = _plan;
    map['status'] = _status;
    map['price'] = _price;
    map['subscription_period'] = _subscriptionPeriod;
    map['source'] = _source;
    map['commenting_status'] = _commentingStatus;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['forkability_status'] = _forkabilityStatus;
    if (_details != null) {
      map['details'] = _details?.toJson();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['sales_volume'] = _salesVolume;
    map['sales_number'] = _salesNumber;
    map['views_count'] = _viewsCount;
    if (_thumbnails != null) {
      map['thumbnails'] = _thumbnails?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      num? id, 
      String? username, 
      dynamic imageId, 
      String? imageUrl, 
      dynamic image,}){
    _id = id;
    _username = username;
    _imageId = imageId;
    _imageUrl = imageUrl;
    _image = image;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _imageId = json['image_id'];
    _imageUrl = json['image_url'];
    _image = json['image'];
  }
  num? _id;
  String? _username;
  dynamic _imageId;
  String? _imageUrl;
  dynamic _image;
User copyWith({  num? id,
  String? username,
  dynamic imageId,
  String? imageUrl,
  dynamic image,
}) => User(  id: id ?? _id,
  username: username ?? _username,
  imageId: imageId ?? _imageId,
  imageUrl: imageUrl ?? _imageUrl,
  image: image ?? _image,
);
  num? get id => _id;
  String? get username => _username;
  dynamic get imageId => _imageId;
  String? get imageUrl => _imageUrl;
  dynamic get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['image_id'] = _imageId;
    map['image_url'] = _imageUrl;
    map['image'] = _image;
    return map;
  }

}

class Thumbnails {
  Thumbnails({
      String? x226, 
      String? x366, 
      String? x220, 
      String? x304, 
      String? x525, 
      String? x651, 
      String? x1080,}){
    _x226 = x226;
    _x366 = x366;
    _x220 = x220;
    _x304 = x304;
    _x525 = x525;
    _x651 = x651;
    _x1080 = x1080;
}

  Thumbnails.fromJson(dynamic json) {
    _x226 = json['226x226'];
    _x366 = json['336x366'];
    _x220 = json['340x220'];
    _x304 = json['523x304'];
    _x525 = json['525x525'];
    _x651 = json['648x651'];
    _x1080 = json['1080x1080'];
  }
  String? _x226;
  String? _x366;
  String? _x220;
  String? _x304;
  String? _x525;
  String? _x651;
  String? _x1080;
Thumbnails copyWith({  String? x226,
  String? x366,
  String? x220,
  String? x304,
  String? x525,
  String? x651,
  String? x1080,
}) => Thumbnails(  x226: x226 ?? _x226,
  x366: x366 ?? _x366,
  x220: x220 ?? _x220,
  x304: x304 ?? _x304,
  x525: x525 ?? _x525,
  x651: x651 ?? _x651,
  x1080: x1080 ?? _x1080,
);
  String? get x226 => _x226;
  String? get x366 => _x366;
  String? get x220 => _x220;
  String? get x304 => _x304;
  String? get x525 => _x525;
  String? get x651 => _x651;
  String? get x1080 => _x1080;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['226x226'] = _x226;
    map['336x366'] = _x366;
    map['340x220'] = _x220;
    map['523x304'] = _x304;
    map['525x525'] = _x525;
    map['648x651'] = _x651;
    map['1080x1080'] = _x1080;
    return map;
  }

}

class Details {
  Details({
      Thumbnails? thumbnails,}){
    _thumbnails = thumbnails;
}

  Details.fromJson(dynamic json) {
    _thumbnails = json['thumbnails'] != null ? Thumbnails.fromJson(json['thumbnails']) : null;
  }
  Thumbnails? _thumbnails;
Details copyWith({  Thumbnails? thumbnails,
}) => Details(  thumbnails: thumbnails ?? _thumbnails,
);
  Thumbnails? get thumbnails => _thumbnails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_thumbnails != null) {
      map['thumbnails'] = _thumbnails?.toJson();
    }
    return map;
  }

}

