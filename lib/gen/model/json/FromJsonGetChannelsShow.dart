import 'dart:convert';
import 'dart:developer';

import 'package:mediaverse/gen/model/json/v2/FromJsonGetContentFromExplore.dart';
FromJsonGetChannelsShow fromJsonGetChannelsShowFromJson(String str) => FromJsonGetChannelsShow.fromJson(json.decode(str));
String fromJsonGetChannelsShowToJson(FromJsonGetChannelsShow data) => json.encode(data.toJson());
class FromJsonGetChannelsShow {
  FromJsonGetChannelsShow({
      ChannelsModel? data,}){
    _data = data;
}

  FromJsonGetChannelsShow.fromJson(dynamic json) {
    _data = json['data'] != null ? ChannelsModel.fromJson(json['data']) : null;
  }
  ChannelsModel? _data;

  ChannelsModel? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

ChannelsModel dataFromJson(String str) => ChannelsModel.fromJson(json.decode(str));
String dataToJson(ChannelsModel data) => json.encode(data.toJson());
class ChannelsModel {
  ChannelsModel({
      String? id,
      String? name,
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
      String? country,
      List<String>? users,
      List<Events>? events,
      List<Destinations>? destinations,
      List<Programs>? programs,}){
    _id = id;
    _name = name;
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
    _country = country;
    _users = users;
    _events = events;
    _destinations = destinations??[];
    _programs = programs;
}

  ChannelsModel.fromJson(dynamic json) {
   // debugger();
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _url = json['current_url'];
    _language = json['language'];
    _isPrivate = json['is_private'];
    _isRecordable = json['is_recordable'];
    _isAvailable = json['is_available'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _lastEvent = json['last_event'];
    _thumbnails = json['thumbnails'];
    _program = json['program'] != null ? Programs.fromJson(json['program']): null;
    _country = json['country_iso'];
    _users = json['users'] != null ? json['users'].cast<String>() : [];
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
        _programs?.add(Programs.fromJson(v));
      });

    }
  }
  String? _id;
  String? _name;
  String? _description;
  String? _url;
  String? _language;
  bool? _isPrivate;
  bool? _isRecordable;
  bool? _isAvailable;
  String? _createdAt;
  String? _updatedAt;
  String? _lastEvent;
  dynamic? _thumbnails;
  String? _country;
  List<String>? _users;
  List<Events>? _events;
  List<Destinations> _destinations=[];
  List<Programs>? _programs;
  Programs? _program;

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get url => _url;
  String? get language => _language;
  bool? get isPrivate => _isPrivate;
  bool? get isRecordable => _isRecordable;
  bool? get isAvailable => _isAvailable;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get lastEvent => _lastEvent;
  Programs? get program => _program;
  dynamic? get thumbnails => _thumbnails;
  String? get country => _country;
  List<String>? get users => _users;
  List<Events>? get events => _events;
  List<Destinations> get destinations => _destinations;
  List<Programs>? get programs => _programs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
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
    map['country_iso'] = _country;
    map['users'] = _users;
    if (_events != null) {
      map['events'] = _events?.map((v) => v.toJson()).toList();
    }
    if (_destinations != null) {
      map['destinations'] = _destinations?.map((v) => v.toJson()).toList();
    }
    if (_programs != null) {
      map['programs'] = _programs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Programs programsFromJson(String str) => Programs.fromJson(json.decode(str));
String programsToJson(Programs data) => json.encode(data.toJson());
class Programs {
  Programs({
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
      dynamic channel, 
      List<Lives>? lives,}){
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
}

  Programs.fromJson(dynamic json) {
    _id = json['id'];
    _channelId = json['channel_id'];
    _name = json['name'];
    try {
      _asset = ContentModel.fromJson(json['asset']);
    }  catch (e) {
      // TODO
    }
    _source = json['source'];
    if (json['details'] != null) {
      _details = [];

    }
    _lastEvent = json['last_event_type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _value = json['value'];
    _streamUrl = "${json['stream_url']}/${json['stream_key']}";
    _streamKey = json['stream_key'];
    _livesCount = json['lives_count'];
    if (json['events'] != null) {
      _events = [];
      json['events'].forEach((v) {
        _events?.add(Events.fromJson(v));
      });
    }
    _channel = json['channel'];
    if (json['lives'] != null) {
      _lives = [];
      json['lives'].forEach((v) {
        _lives?.add(Lives.fromJson(v));
      });
    }
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
  ContentModel? _asset;
  String? _livesCount;
  List<Events>? _events;
  dynamic _channel;
  List<Lives>? _lives;

  String? get id => _id;
  String? get channelId => _channelId;
  String? get name => _name;
  ContentModel? get asset => _asset;
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
  dynamic get channel => _channel;
  List<Lives>? get lives => _lives;

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
    map['channel'] = _channel;
    if (_lives != null) {
      map['lives'] = _lives?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Lives livesFromJson(String str) => Lives.fromJson(json.decode(str));
String livesToJson(Lives data) => json.encode(data.toJson());
class Lives {
  Lives({
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
      dynamic program, 
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

  Lives.fromJson(dynamic json) {
    _id = json['id'];
    _server = json['server'];
    _lastEvent = json['last_event'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _eventsCount = json['events_count'];
    _url = json['url'];
    _startedAt = json['started_at'];
    _stoppedAt = json['stopped_at'];
    _length = json['length'];
    _programId = json['program_id'];
    _program = json['program'];
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
  dynamic _program;
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
  dynamic get program => _program;
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
    map['program'] = _program;
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

sFromJson(String str) => Destinations.fromJson(json.decode(str));
String destinationsToJson(Destinations data) => json.encode(data.toJson());
class Destinations {
  Destinations({
      String? id, 
      String? name, 
      String? userId, 
      String? type, 
      List<dynamic>? details, 
      String? createdAt, 
      String? updatedAt, 
      String? user, 
      List<Channels>? channels,}){
    _id = id;
    _name = name;
    _userId = userId;
    _type = type;
    _details = details;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
    _channels = channels;
}
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Destinations && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
  Destinations.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _userId = json['user_id'];
    _type = json['type'];
    if (json['details'] != null) {
      _details = [];

    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'];
    if (json['channels'] != null) {
      _channels = [];
      json['channels'].forEach((v) {
        _channels?.add(Channels.fromJson(v));
      });
    }
  }
  String? _id;
  String? _name;
  String? _userId;
  String? _type;
  List<dynamic>? _details;
  String? _createdAt;
  String? _updatedAt;
  String? _user;
  List<Channels>? _channels;

  String? get id => _id;
  String? get name => _name;
  String? get userId => _userId;
  String? get type => _type;
  List<dynamic>? get details => _details;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get user => _user;
  List<Channels>? get channels => _channels;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['user_id'] = _userId;
    map['type'] = _type;
    if (_details != null) {
      map['details'] = _details?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['user'] = _user;
    if (_channels != null) {
      map['channels'] = _channels?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Channels channelsFromJson(String str) => Channels.fromJson(json.decode(str));
String channelsToJson(Channels data) => json.encode(data.toJson());
class Channels {
  Channels({
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
      dynamic channel, 
      List<Lives>? lives,}){
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
}

  Channels.fromJson(dynamic json) {
    _id = json['id'];
    _channelId = json['channel_id'];
    _name = json['name'];
    _source = json['source'];
    if (json['details'] != null) {
      _details = [];

    }
    _lastEvent = json['last_event'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _value = json['value'];
    _streamUrl = json['stream_url'];
    _streamKey = json['stream_key'];
    _livesCount = json['lives_count'];
    if (json['events'] != null) {
      _events = [];
      json['events'].forEach((v) {
        _events?.add(Events.fromJson(v));
      });
    }
    _channel = json['channel'];
    if (json['lives'] != null) {
      _lives = [];
      json['lives'].forEach((v) {
        _lives?.add(Lives.fromJson(v));
      });
    }
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
  dynamic _channel;
  List<Lives>? _lives;

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
  dynamic get channel => _channel;
  List<Lives>? get lives => _lives;

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
    map['channel'] = _channel;
    if (_lives != null) {
      map['lives'] = _lives?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
