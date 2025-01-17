import 'dart:convert';
import 'dart:developer';

import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
FromJsonGetContentFromExplore fromJsonGetContentFromExploreFromJson(String str) => FromJsonGetContentFromExplore.fromJson(json.decode(str));
String fromJsonGetContentFromExploreToJson(FromJsonGetContentFromExplore data) => json.encode(data.toJson());
class FromJsonGetContentFromExplore {
  FromJsonGetContentFromExplore({
      List<ContentModel>? data,
      Links? links, 
      Meta? meta,}){
    _data = data;
    _links = links;
    _meta = meta;
}

  FromJsonGetContentFromExplore.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ContentModel.fromJson(v));
      });
    }
    _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<ContentModel>? _data;
  Links? _links;
  Meta? _meta;

  List<ContentModel>? get data => _data;
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
      String? nextCursor, 
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
  String? _nextCursor;
  dynamic _prevCursor;

  String? get path => _path;
  num? get perPage => _perPage;
  String? get nextCursor => _nextCursor;
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
      String? next,}){
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
  String? _next;

  dynamic get first => _first;
  dynamic get last => _last;
  dynamic get prev => _prev;
  String? get next => _next;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first'] = _first;
    map['last'] = _last;
    map['prev'] = _prev;
    map['next'] = _next;
    return map;
  }

}

ContentModel dataFromJson(String str) => ContentModel.fromJson(json.decode(str));
String dataToJson(ContentModel data) => json.encode(data.toJson());
class ContentModel {
  ContentModel({
      String? id, 
      String? name, 
      String? slug, 
      String? description, 
      dynamic language, 
      dynamic countryIso, 
      String? mediaType, 
      num? licenseType, 
      num? status, 
      num? price, 
      dynamic subscriptionPeriod, 
      String? subscriptionPeriodForHumans, 
      num? source, 
      num? commentingStatus, 
      dynamic lat, 
      dynamic lng, 
      Thumbnails? thumbnails, 
      num? viewsCount, 
      num? salesCount, 
      num? salesNumber, 
      num? salesVolume, 
      String? userId, 
      String? fileId, 
      dynamic parentId, 
      bool? isPrivate, 
      bool? isOwned, 
      String? createdAt, 
      List<String>? tags, 
      User? user, 
      dynamic country, 
      File? file,}){
    _id = id;
    _name = name;
    _slug = slug;
    _description = description;
    _language = language;
    _countryIso = countryIso;
    _mediaType = mediaType;
    _licenseType = licenseType;
    _status = status;
    _price = price;
    _subscriptionPeriod = subscriptionPeriod;
    _subscriptionPeriodForHumans = subscriptionPeriodForHumans;
    _source = source;
    _commentingStatus = commentingStatus;
    _lat = lat;
    _lng = lng;
    _thumbnails = thumbnails;
    _viewsCount = viewsCount;
    _salesCount = salesCount;
    _salesNumber = salesNumber;
    _salesVolume = salesVolume;
    _userId = userId;
    _fileId = fileId;
    _parentId = parentId;
    _isPrivate = isPrivate;
    _isOwned = isOwned;
    _createdAt = createdAt;
    _tags = tags;
    _user = user;
    _country = country;
    _file = file;
}

  ContentModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _description = json['description'];
    _language = json['language'];
    _countryIso = json['country_iso'];
    _mediaType = json['media_type'];
    postType = _getPostTypeByMediaType(_mediaType);
    _licenseType = json['license_type'];
    _status = json['status'];
    _price = json['price'];
    _subscriptionPeriod = json['subscription_period'];
    _subscriptionPeriodForHumans = json['subscription_period_for_humans'];
    _source = json['source'];
    _commentingStatus = json['commenting_status'];
    _lat = json['lat'];
    _lng = json['lng'];
   // debugger();
    _thumbnails = json['thumbnails'] != null ? Thumbnails.fromJson(json['thumbnails']) : null;
    _viewsCount = json['views_count'];
    _salesCount = json['sales_count'];
    _salesNumber = json['sales_number'];
    _salesVolume = json['sales_volume'];
    _userId = json['user_id'];
    _fileId = json['file_id'];
    _parentId = json['parent_id'];
    _isPrivate = json['is_private'];
    _isOwned = json['is_owned'];
    _createdAt = json['created_at'];
    _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _country = json['country'];
    _file = json['file'] != null ? File.fromJson(json['file']) : null;
  }
  String? _id;
  String? _name;
  String? _slug;
  String? _description;
  dynamic _language;
  dynamic _countryIso;
  String? _mediaType;
  num? _licenseType;
  num? _status;
  num? _price;
  dynamic _subscriptionPeriod;
  String? _subscriptionPeriodForHumans;
  num? _source;
  num? _commentingStatus;
  dynamic _lat;
  dynamic _lng;
  Thumbnails? _thumbnails;
  num? _viewsCount;
  num? _salesCount;
  num? _salesNumber;
  num? _salesVolume;
  String? _userId;
  String? _fileId;
  dynamic _parentId;
  bool? _isPrivate;
  bool? _isOwned;
  String? _createdAt;
  List<String>? _tags;
  User? _user;
  dynamic _country;
  File? _file;

  PostType  postType = PostType.video;
  String? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get description => _description;
  dynamic get language => _language;
  dynamic get countryIso => _countryIso;
  String? get mediaType => _mediaType;
  num? get licenseType => _licenseType;
  num? get status => _status;
  num? get price => _price;
  dynamic get subscriptionPeriod => _subscriptionPeriod;
  String? get subscriptionPeriodForHumans => _subscriptionPeriodForHumans;
  num? get source => _source;
  num? get commentingStatus => _commentingStatus;
  dynamic get lat => _lat;
  dynamic get lng => _lng;
  Thumbnails? get thumbnails => _thumbnails;
  num? get viewsCount => _viewsCount;
  num? get salesCount => _salesCount;
  num? get salesNumber => _salesNumber;
  num? get salesVolume => _salesVolume;
  String? get userId => _userId;
  String? get fileId => _fileId;
  dynamic get parentId => _parentId;
  bool? get isPrivate => _isPrivate;
  bool? get isOwned => _isOwned;
  String? get createdAt => _createdAt;
  List<String>? get tags => _tags;
  User? get user => _user;
  dynamic get country => _country;
  File? get file => _file;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['description'] = _description;
    map['language'] = _language;
    map['country_iso'] = _countryIso;
    map['media_type'] = _mediaType;
    map['license_type'] = _licenseType;
    map['status'] = _status;
    map['price'] = _price;
    map['subscription_period'] = _subscriptionPeriod;
    map['subscription_period_for_humans'] = _subscriptionPeriodForHumans;
    map['source'] = _source;
    map['commenting_status'] = _commentingStatus;
    map['lat'] = _lat;
    map['lng'] = _lng;
    if (_thumbnails != null) {
      map['thumbnails'] = _thumbnails?.toJson();
    }
    map['views_count'] = _viewsCount;
    map['sales_count'] = _salesCount;
    map['sales_number'] = _salesNumber;
    map['sales_volume'] = _salesVolume;
    map['user_id'] = _userId;
    map['file_id'] = _fileId;
    map['parent_id'] = _parentId;
    map['is_private'] = _isPrivate;
    map['is_owned'] = _isOwned;
    map['created_at'] = _createdAt;
    map['tags'] = _tags;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['country'] = _country;
    if (_file != null) {
      map['file'] = _file?.toJson();
    }
    return map;
  }

  PostType _getPostTypeByMediaType(String? mediaType) {
    switch(mediaType){
      case "text":
       return PostType.text;
      case "image":
        return PostType.image;
      case "audio":
        return PostType.audio;
      case "video":
        return PostType.video;
      default:
        return PostType.video;

    }
  }

}

File fileFromJson(String str) => File.fromJson(json.decode(str));
String fileToJson(File data) => json.encode(data.toJson());
class File {
  File({
      String? id, 
      num? type, 
      String? storage, 
      String? mediaType, 
      num? source, 
      String? extension, 
      String? size, 
      String? length, 
      Info? info, 
      dynamic sharesCount, 
      Thumbnails? thumbnails, 
      String? url, 
      String? userId, 
      String? createdAt,}){
    _id = id;
    _type = type;
    _storage = storage;
    _mediaType = mediaType;
    _source = source;
    _extension = extension;
    _size = size;
    _length = length;
    _info = info;
    _sharesCount = sharesCount;
    _thumbnails = thumbnails;
    _url = url;
    _userId = userId;
    _createdAt = createdAt;
}

  File.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _storage = json['storage'];
    _mediaType = json['media_type'];
    _source = json['source'];
    _extension = json['extension'];
    _size = json['size'];
    _length = json['length'];
   // _info = json['info'] != null ? Info.fromJson(json['info']) : null;
    _sharesCount = json['shares_count'];
    _thumbnails = json['thumbnails'] != null ? Thumbnails.fromJson(json['thumbnails']) : null;
    _url = json['url'];
    _userId = json['user_id'];
    _createdAt = json['created_at'];
  }
  String? _id;
  num? _type;
  String? _storage;
  String? _mediaType;
  num? _source;
  String? _extension;
  String? _size;
  String? _length;
  Info? _info;
  dynamic _sharesCount;
  Thumbnails? _thumbnails;
  String? _url;
  String? _userId;
  String? _createdAt;

  String? get id => _id;
  num? get type => _type;
  String? get storage => _storage;
  String? get mediaType => _mediaType;
  num? get source => _source;
  String? get extension => _extension;
  String? get size => _size;
  String? get length => _length;
  Info? get info => _info;
  dynamic get sharesCount => _sharesCount;
  Thumbnails? get thumbnails => _thumbnails;
  String? get url => _url;
  String? get userId => _userId;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['storage'] = _storage;
    map['media_type'] = _mediaType;
    map['source'] = _source;
    map['extension'] = _extension;
    map['size'] = _size;
    map['length'] = _length;
    if (_info != null) {
      map['info'] = _info?.toJson();
    }
    map['shares_count'] = _sharesCount;
    if (_thumbnails != null) {
      map['thumbnails'] = _thumbnails?.toJson();
    }
    map['url'] = _url;
    map['user_id'] = _userId;
    map['created_at'] = _createdAt;
    return map;
  }

}

Thumbnails thumbnailsFromJson(String str) => Thumbnails.fromJson(json.decode(str));
String thumbnailsToJson(Thumbnails data) => json.encode(data.toJson());
class Thumbnails {
  Thumbnails({
      String? x226, 
      String? x366, 
      String? x220, 
      String? x218, 
      String? x304, 
      String? x525, 
      String? x1080, 
      String? x1396,}){
    _x226 = x226;
    _x366 = x366;
    _x220 = x220;
    _x218 = x218;
    _x304 = x304;
    _x525 = x525;
    _x1080 = x1080;
    _x1396 = x1396;
}

  Thumbnails.fromJson(dynamic json) {
    try {
      _x226 = json['226x226'];
      _x366 = json['336x366'];
      _x220 = json['340x220'];
      _x218 = json['390x218'];
      _x304 = json['523x304'];
      _x525 = json['525x525'];
      _x1080 = json['1920x1080'];
      _x1396 = json['3090x1396'];
    }  catch (e) {
      // TODO
    }
  }
  String? _x226;
  String? _x366;
  String? _x220;
  String? _x218;
  String? _x304;
  String? _x525;
  String? _x1080;
  String? _x1396;

  String? get x226 => _x226;
  String? get x366 => _x366;
  String? get x220 => _x220;
  String? get x218 => _x218;
  String? get x304 => _x304;
  String? get x525 => _x525;
  String? get x1080 => _x1080;
  String? get x1396 => _x1396;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['226x226'] = _x226;
    map['336x366'] = _x366;
    map['340x220'] = _x220;
    map['390x218'] = _x218;
    map['523x304'] = _x304;
    map['525x525'] = _x525;
    map['1920x1080'] = _x1080;
    map['3090x1396'] = _x1396;
    return map;
  }

}

Info infoFromJson(String str) => Info.fromJson(json.decode(str));
String infoToJson(Info data) => json.encode(data.toJson());
class Info {
  Info({
      num? time, 
      List<dynamic>? audio, 
      Video? video, 
      String? bitrate, 
      num? filesize, 
      String? mimeType, 
      String? fileformat,}){
    _time = time;
    _audio = audio;
    _video = video;
    _bitrate = bitrate;
    _filesize = filesize;
    _mimeType = mimeType;
    _fileformat = fileformat;
}

  Info.fromJson(dynamic json) {
    _time = json['time'];
    if (json['audio'] != null) {
      _audio = [];
      // json['audio'].forEach((v) {
      //   _audio?.add(v);
      // });
    }
    _video = json['video'] != null ? Video.fromJson(json['video']) : null;
    _bitrate = json['bitrate'];
    _filesize = json['filesize'];
    _mimeType = json['mime_type'];
    _fileformat = json['fileformat'];
  }
  num? _time;
  List<dynamic>? _audio;
  Video? _video;
  String? _bitrate;
  num? _filesize;
  String? _mimeType;
  String? _fileformat;

  num? get time => _time;
  List<dynamic>? get audio => _audio;
  Video? get video => _video;
  String? get bitrate => _bitrate;
  num? get filesize => _filesize;
  String? get mimeType => _mimeType;
  String? get fileformat => _fileformat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = _time;
    if (_audio != null) {
      map['audio'] = _audio?.map((v) => v.toJson()).toList();
    }
    if (_video != null) {
      map['video'] = _video?.toJson();
    }
    map['bitrate'] = _bitrate;
    map['filesize'] = _filesize;
    map['mime_type'] = _mimeType;
    map['fileformat'] = _fileformat;
    return map;
  }

}

Video videoFromJson(String str) => Video.fromJson(json.decode(str));
String videoToJson(Video data) => json.encode(data.toJson());
class Video {
  Video({
      bool? lossless, 
      String? dataformat, 
      num? resolutionX, 
      num? resolutionY, 
      num? bitsPerSample, 
      num? compressionRatio,}){
    _lossless = lossless;
    _dataformat = dataformat;
    _resolutionX = resolutionX;
    _resolutionY = resolutionY;
    _bitsPerSample = bitsPerSample;
    _compressionRatio = compressionRatio;
}

  Video.fromJson(dynamic json) {
   // _lossless = json['lossless'];
    _dataformat = json['dataformat'];
    _resolutionX = json['resolution_x'];
    _resolutionY = json['resolution_y'];
    _bitsPerSample = json['bits_per_sample'];
    _compressionRatio = json['compression_ratio'];
  }
  bool? _lossless;
  String? _dataformat;
  num? _resolutionX;
  num? _resolutionY;
  num? _bitsPerSample;
  num? _compressionRatio;

  bool? get lossless => _lossless;
  String? get dataformat => _dataformat;
  num? get resolutionX => _resolutionX;
  num? get resolutionY => _resolutionY;
  num? get bitsPerSample => _bitsPerSample;
  num? get compressionRatio => _compressionRatio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lossless'] = _lossless;
    map['dataformat'] = _dataformat;
    map['resolution_x'] = _resolutionX;
    map['resolution_y'] = _resolutionY;
    map['bits_per_sample'] = _bitsPerSample;
    map['compression_ratio'] = _compressionRatio;
    return map;
  }

}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? id, 
      String? firstName, 
      String? lastName, 
      String? fullName, 
      String? username, 
      String? imageUrl,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _fullName = fullName;
    _username = username;
    _imageUrl = imageUrl;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _fullName = json['full_name'];
    _username = json['username'];
    _imageUrl = json['image_url'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _fullName;
  String? _username;
  String? _imageUrl;

  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get fullName => _fullName;
  String? get username => _username;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['full_name'] = _fullName;
    map['username'] = _username;
    map['image_url'] = _imageUrl;
    return map;
  }

}

