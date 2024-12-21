import 'dart:convert';
import 'dart:developer';

import 'FromJsonGetChannelsShow.dart';
FromJsonGetChannelsLive fromJsonGetChannelsLiveFromJson(String str) => FromJsonGetChannelsLive.fromJson(json.decode(str));
String fromJsonGetChannelsLiveToJson(FromJsonGetChannelsLive data) => json.encode(data.toJson());
class FromJsonGetChannelsLive {
  FromJsonGetChannelsLive({
      List<LiveModel>? data,}){
    _data = data;
}

  FromJsonGetChannelsLive.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LiveModel.fromJson(v));
      });
    }
  }
  List<LiveModel>? _data;

  List<LiveModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

LiveModel dataFromJson(String str) => LiveModel.fromJson(json.decode(str));
String dataToJson(LiveModel data) => json.encode(data.toJson());
class LiveModel {
  LiveModel({
      String? id, 
      String? server, 
      String? lastEvent, 
      String? createdAt, 
      String? updatedAt, 
      String? eventsCount, 
      String? url, 
      String? startedAt, 
      String? stoppedAt, 
      String? length, 
      String? programId, 
      Program? program, 
      List<Events>? events,}){
    _id = id;
    _server = server;
    _lastEvent = lastEvent;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _eventsCount = eventsCount;
    _url = url;
    _startedAt = startedAt;
    _stoppedAt = stoppedAt;
    _length = length;
    _programId = programId;
    _program = program;
    _events = events;
}

  LiveModel.fromJson(dynamic json) {
  //  debugger();
    _id = json['id'];
    _server = json['server'];//
    _lastEvent = json['last_event'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _eventsCount = json['events_count'];
    _url = json['url'];
    _startedAt = json['started_at'];
    _stoppedAt = json['stopped_at'];
    _length = json['length'];
    _programId = json['program_id'];
    _program = json['program'] != null ? Program.fromJson(json['program']) : null;
    if (json['events'] != null) {
      _events = [];
      json['events'].forEach((v) {
        _events?.add(Events.fromJson(v));
      });
    }
  }
  String? _id;
  String? _server;
  String? _lastEvent;
  String? _createdAt;
  String? _updatedAt;
  String? _eventsCount;
  String? _url;
  String? _startedAt;
  String? _stoppedAt;
  String? _length;
  String? _programId;
  Program? _program;
  List<Events>? _events;

  String? get id => _id;
  String? get server => _server;
  String? get lastEvent => _lastEvent;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get eventsCount => _eventsCount;
  String? get url => _url;
  String? get startedAt => _startedAt;
  String? get stoppedAt => _stoppedAt;
  String? get length => _length;
  String? get programId => _programId;
  Program? get program => _program;
  List<Events>? get events => _events;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['server'] = _server;
    map['last_event'] = _lastEvent;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['events_count'] = _eventsCount;
    map['url'] = _url;
    map['started_at'] = _startedAt;
    map['stopped_at'] = _stoppedAt;
    map['length'] = _length;
    map['program_id'] = _programId;
    if (_program != null) {
      map['program'] = _program?.toJson();
    }
    if (_events != null) {
      map['events'] = _events?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Events eventsFromJson(String str) => Events.fromJson(json.decode(str));
String eventsToJson(Events data) => json.encode(data.toJson());
class Events {
  Events({
      String? id, 
      String? type, 
      List<dynamic>? details, 
      String? createdAt, 
      String? updatedAt, 
      String? liveId, 
      dynamic live,}){
    _id = id;
    _type = type;
    _details = details;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _liveId = liveId;
    _live = live;
}

  Events.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    if (json['details'] != null) {
      _details = [];
      json['details'].forEach((v) {
        _details?.add(v);
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _liveId = json['live_id'];
    _live = json['live'];
  }
  String? _id;
  String? _type;
  List<dynamic>? _details;
  String? _createdAt;
  String? _updatedAt;
  String? _liveId;
  dynamic _live;

  String? get id => _id;
  String? get type => _type;
  List<dynamic>? get details => _details;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get liveId => _liveId;
  dynamic get live => _live;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    if (_details != null) {
      map['details'] = _details?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['live_id'] = _liveId;
    map['live'] = _live;
    return map;
  }

}

Program programFromJson(String str) => Program.fromJson(json.decode(str));
String programToJson(Program data) => json.encode(data.toJson());
class Program {
  Program({
      String? id, 
      String? channelId, 
      String? name, 
      String? source, 
      List<dynamic>? details, 
      String? lastEvent, 
      String? createdAt, 
      String? updatedAt, 
      String? value, 
      String? streamUrl, 
      String? streamKey, 
      String? livesCount, 
      List<Events>? events, 
      Channel? channel, 
      List<dynamic>? lives, 
      dynamic lastLive,}){
    _id = id;
    _channelId = channelId;
    _name = name;
    _source = source;
    _details = details;
    _lastEvent = lastEvent;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _value = value;
    _streamUrl = streamUrl;
    _streamKey = streamKey;
    _livesCount = livesCount;
    _events = events;
    _channel = channel;
    _lives = lives;
    _lastLive = lastLive;
}

  Program.fromJson(dynamic json) {
    _name = json['name'];
    // _id = json['id'];
    // _channelId = json['channel_id'];
    // _source = json['source'];
    // if (json['details'] != null) {
    //   _details = [];
    //   json['details'].forEach((v) {
    //     _details?.add(v);
    //   });
    // }
    // _lastEvent = json['last_event'];
    // _createdAt = json['created_at'];
    // _updatedAt = json['updated_at'];
    // _value = json['value'];
    // _streamUrl = json['stream_url'];
    // _streamKey = json['stream_key'];
    // _livesCount = json['lives_count'];
    // if (json['events'] != null) {
    //   _events = [];
    //   json['events'].forEach((v) {
    //     _events?.add(Events.fromJson(v));
    //   });
    // }
    // _channel = json['channel'] != null ? Channel.fromJson(json['channel']) : null;
    // if (json['lives'] != null) {
    //   _lives = [];
    //   json['lives'].forEach((v) {
    //     _lives?.add(v);
    //   });
    // }
    // _lastLive = json['last_live'];
  }
  String? _id;
  String? _channelId;
  String? _name;
  String? _source;
  List<dynamic>? _details;
  String? _lastEvent;
  String? _createdAt;
  String? _updatedAt;
  String? _value;
  String? _streamUrl;
  String? _streamKey;
  String? _livesCount;
  List<Events>? _events;
  Channel? _channel;
  List<dynamic>? _lives;
  dynamic _lastLive;

  String? get id => _id;
  String? get channelId => _channelId;
  String? get name => _name;
  String? get source => _source;
  List<dynamic>? get details => _details;
  String? get lastEvent => _lastEvent;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get value => _value;
  String? get streamUrl => _streamUrl;
  String? get streamKey => _streamKey;
  String? get livesCount => _livesCount;
  List<Events>? get events => _events;
  Channel? get channel => _channel;
  List<dynamic>? get lives => _lives;
  dynamic get lastLive => _lastLive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['channel_id'] = _channelId;
    map['name'] = _name;
    map['source'] = _source;
    if (_details != null) {
      map['details'] = _details?.map((v) => v.toJson()).toList();
    }
    map['last_event'] = _lastEvent;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['value'] = _value;
    map['stream_url'] = _streamUrl;
    map['stream_key'] = _streamKey;
    map['lives_count'] = _livesCount;
    if (_events != null) {
      map['events'] = _events?.map((v) => v.toJson()).toList();
    }
    if (_channel != null) {
      map['channel'] = _channel?.toJson();
    }
    if (_lives != null) {
      map['lives'] = _lives?.map((v) => v.toJson()).toList();
    }
    map['last_live'] = _lastLive;
    return map;
  }

}

Channel channelFromJson(String str) => Channel.fromJson(json.decode(str));
String channelToJson(Channel data) => json.encode(data.toJson());
class Channel {
  Channel({
      String? id, 
      String? name, 
      String? userId, 
      String? programId, 
      String? description, 
      String? url, 
      String? language, 
      bool? isPrivate, 
      bool? isRecordable, 
      bool? isAvailable, 
      String? createdAt, 
      String? updatedAt, 
      String? lastEvent, 
      String? thumbnails, 
      String? countryIso, 
      User? user, 
      List<Events>? events, 
      List<Destinations>? destinations, 
      List<dynamic>? programs, 
      dynamic program, 
      Country? country,}){
    _id = id;
    _name = name;
    _userId = userId;
    _programId = programId;
    _description = description;
    _url = url;
    _language = language;
    _isPrivate = isPrivate;
    _isRecordable = isRecordable;
    _isAvailable = isAvailable;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _lastEvent = lastEvent;
    _thumbnails = thumbnails;
    _countryIso = countryIso;
    _user = user;
    _events = events;
    _destinations = destinations;
    _programs = programs;
    _program = program;
    _country = country;
}

  Channel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _userId = json['user_id'];
    _programId = json['program_id'];
    _description = json['description'];
    _url = json['url'];
    _language = json['language'];
    _isPrivate = json['is_private'];
    _isRecordable = json['is_recordable'];
    _isAvailable = json['is_available'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _lastEvent = json['last_event'];
    _thumbnails = json['thumbnails'];
    _countryIso = json['country_iso'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['events'] != null) {
      _events = [];
      json['events'].forEach((v) {
        _events?.add(Events.fromJson(v));
      });
    }
    if (json['destinations'] != null) {
      _destinations = [];
      json['destinations'].forEach((v) {
        _destinations?.add(Destinations.fromJson(v));
      });
    }
    if (json['programs'] != null) {
      _programs = [];
      json['programs'].forEach((v) {
        _programs?.add(v);
      });
    }
    _program = json['program'];
    _country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }
  String? _id;
  String? _name;
  String? _userId;
  String? _programId;
  String? _description;
  String? _url;
  String? _language;
  bool? _isPrivate;
  bool? _isRecordable;
  bool? _isAvailable;
  String? _createdAt;
  String? _updatedAt;
  String? _lastEvent;
  String? _thumbnails;
  String? _countryIso;
  User? _user;
  List<Events>? _events;
  List<Destinations>? _destinations;
  List<dynamic>? _programs;
  dynamic _program;
  Country? _country;

  String? get id => _id;
  String? get name => _name;
  String? get userId => _userId;
  String? get programId => _programId;
  String? get description => _description;
  String? get url => _url;
  String? get language => _language;
  bool? get isPrivate => _isPrivate;
  bool? get isRecordable => _isRecordable;
  bool? get isAvailable => _isAvailable;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get lastEvent => _lastEvent;
  String? get thumbnails => _thumbnails;
  String? get countryIso => _countryIso;
  User? get user => _user;
  List<Events>? get events => _events;
  List<Destinations>? get destinations => _destinations;
  List<dynamic>? get programs => _programs;
  dynamic get program => _program;
  Country? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['user_id'] = _userId;
    map['program_id'] = _programId;
    map['description'] = _description;
    map['url'] = _url;
    map['language'] = _language;
    map['is_private'] = _isPrivate;
    map['is_recordable'] = _isRecordable;
    map['is_available'] = _isAvailable;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['last_event'] = _lastEvent;
    map['thumbnails'] = _thumbnails;
    map['country_iso'] = _countryIso;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_events != null) {
      map['events'] = _events?.map((v) => v.toJson()).toList();
    }
    if (_destinations != null) {
      map['destinations'] = _destinations?.map((v) => v.toJson()).toList();
    }
    if (_programs != null) {
      map['programs'] = _programs?.map((v) => v.toJson()).toList();
    }
    map['program'] = _program;
    if (_country != null) {
      map['country'] = _country?.toJson();
    }
    return map;
  }

}

Country countryFromJson(String str) => Country.fromJson(json.decode(str));
String countryToJson(Country data) => json.encode(data.toJson());
class Country {
  Country({
      String? iso, 
      String? name, 
      String? title, 
      String? callingCode, 
      String? dialingCode, 
      String? continent, 
      num? stripeSupported,}){
    _iso = iso;
    _name = name;
    _title = title;
    _callingCode = callingCode;
    _dialingCode = dialingCode;
    _continent = continent;
    _stripeSupported = stripeSupported;
}

  Country.fromJson(dynamic json) {
    _iso = json['iso'];
    _name = json['name'];
    _title = json['title'];
    _callingCode = json['calling_code'];
    _dialingCode = json['dialing_code'];
    _continent = json['continent'];
    _stripeSupported = json['stripe_supported'];
  }
  String? _iso;
  String? _name;
  String? _title;
  String? _callingCode;
  String? _dialingCode;
  String? _continent;
  num? _stripeSupported;

  String? get iso => _iso;
  String? get name => _name;
  String? get title => _title;
  String? get callingCode => _callingCode;
  String? get dialingCode => _dialingCode;
  String? get continent => _continent;
  num? get stripeSupported => _stripeSupported;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iso'] = _iso;
    map['name'] = _name;
    map['title'] = _title;
    map['calling_code'] = _callingCode;
    map['dialing_code'] = _dialingCode;
    map['continent'] = _continent;
    map['stripe_supported'] = _stripeSupported;
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


Operator operatorFromJson(String str) => Operator.fromJson(json.decode(str));
String operatorToJson(Operator data) => json.encode(data.toJson());
class Operator {
  Operator({
      String? id, 
      String? userId, 
      dynamic user, 
      List<dynamic>? permissions, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _user = user;
    _permissions = permissions;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Operator.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _user = json['user'];
    if (json['permissions'] != null) {
      _permissions = [];
      json['permissions'].forEach((v) {
        _permissions?.add(v);
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userId;
  dynamic _user;
  List<dynamic>? _permissions;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get userId => _userId;
  dynamic get user => _user;
  List<dynamic>? get permissions => _permissions;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['user'] = _user;
    if (_permissions != null) {
      map['permissions'] = _permissions?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());
class Address {
  Address({
      String? id, 
      String? userId, 
      String? line1, 
      String? line2, 
      num? cityId, 
      String? countryIso, 
      City? city, 
      Country? country,}){
    _id = id;
    _userId = userId;
    _line1 = line1;
    _line2 = line2;
    _cityId = cityId;
    _countryIso = countryIso;
    _city = city;
    _country = country;
}

  Address.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _line1 = json['line1'];
    _line2 = json['line2'];
    _cityId = json['city_id'];
    _countryIso = json['country_iso'];
    _city = json['city'] != null ? City.fromJson(json['city']) : null;
    _country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }
  String? _id;
  String? _userId;
  String? _line1;
  String? _line2;
  num? _cityId;
  String? _countryIso;
  City? _city;
  Country? _country;

  String? get id => _id;
  String? get userId => _userId;
  String? get line1 => _line1;
  String? get line2 => _line2;
  num? get cityId => _cityId;
  String? get countryIso => _countryIso;
  City? get city => _city;
  Country? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['line1'] = _line1;
    map['line2'] = _line2;
    map['city_id'] = _cityId;
    map['country_iso'] = _countryIso;
    if (_city != null) {
      map['city'] = _city?.toJson();
    }
    if (_country != null) {
      map['country'] = _country?.toJson();
    }
    return map;
  }

}

City cityFromJson(String str) => City.fromJson(json.decode(str));
String cityToJson(City data) => json.encode(data.toJson());
class City {
  City({
      num? id, 
      Country? country, 
      String? ascii, 
      String? name, 
      String? province, 
      String? lat, 
      String? lng,}){
    _id = id;
    _country = country;
    _ascii = ascii;
    _name = name;
    _province = province;
    _lat = lat;
    _lng = lng;
}

  City.fromJson(dynamic json) {
    _id = json['id'];
    _country = json['country'] != null ? Country.fromJson(json['country']) : null;
    _ascii = json['ascii'];
    _name = json['name'];
    _province = json['province'];
    _lat = json['lat'];
    _lng = json['lng'];
  }
  num? _id;
  Country? _country;
  String? _ascii;
  String? _name;
  String? _province;
  String? _lat;
  String? _lng;

  num? get id => _id;
  Country? get country => _country;
  String? get ascii => _ascii;
  String? get name => _name;
  String? get province => _province;
  String? get lat => _lat;
  String? get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_country != null) {
      map['country'] = _country?.toJson();
    }
    map['ascii'] = _ascii;
    map['name'] = _name;
    map['province'] = _province;
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }

}

