import 'dart:convert';
FromJsonGetPrograms fromJsonGetProgramsFromJson(String str) => FromJsonGetPrograms.fromJson(json.decode(str));
String fromJsonGetProgramsToJson(FromJsonGetPrograms data) => json.encode(data.toJson());
class FromJsonGetPrograms {
  FromJsonGetPrograms({
      List<ProgramModel>? data,
      Links? links, 
      Meta? meta,}){
    _data = data;
    _links = links;
    _meta = meta;
}

  FromJsonGetPrograms.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProgramModel.fromJson(v));
      });
    }
    _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<ProgramModel>? _data;
  Links? _links;
  Meta? _meta;

  List<ProgramModel>? get data => _data;
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
      num? currentPage, 
      num? from, 
      num? lastPage, 
      List<Links>? links, 
      String? path, 
      num? perPage, 
      num? to, 
      num? total,}){
    _currentPage = currentPage;
    _from = from;
    _lastPage = lastPage;
    _links = links;
    _path = path;
    _perPage = perPage;
    _to = to;
    _total = total;
}

  Meta.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _from = json['from'];
    _lastPage = json['last_page'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _path = json['path'];
    _perPage = json['per_page'];
    _to = json['to'];
    _total = json['total'];
  }
  num? _currentPage;
  num? _from;
  num? _lastPage;
  List<Links>? _links;
  String? _path;
  num? _perPage;
  num? _to;
  num? _total;

  num? get currentPage => _currentPage;
  num? get from => _from;
  num? get lastPage => _lastPage;
  List<Links>? get links => _links;
  String? get path => _path;
  num? get perPage => _perPage;
  num? get to => _to;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

Links linksFromJson(String str) => Links.fromJson(json.decode(str));
String linksToJson(Links data) => json.encode(data.toJson());
class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;

  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}



ProgramModel dataFromJson(String str) => ProgramModel.fromJson(json.decode(str));
String dataToJson(ProgramModel data) => json.encode(data.toJson());
class ProgramModel {
  ProgramModel({
      String? id, 
      String? name, 
      String? userId, 
      String? source, 
      List<dynamic>? details, 
      dynamic lastEvent, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      List<dynamic>? events, 
      List<dynamic>? destinations,}){
    _id = id;
    _name = name;
    _userId = userId;
    _source = source;
    _details = details;
    _lastEvent = lastEvent;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _events = events;
    _destinations = destinations;
}

  ProgramModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _userId = json['user_id'];
    _source = json['source'];
    _details = json['details'];
    _lastEvent = json['last_event'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    streamURL = "${json['stream_url']}/${json['stream_key']}";
    print('ProgramModel.fromJson ${streamURL}');
    if (json['events'] != null) {
      _events = [];
      json['events'].forEach((v) {
        _events?.add(v);
      });
    }
    if (json['destinations'] != null) {
      _destinations = [];
      json['destinations'].forEach((v) {
        _destinations?.add(v);
      });
    }
  }
  String? _id;
  String? _name;
  String? _userId;
  String? _source;
  dynamic _details;
  dynamic _lastEvent;
  String? _createdAt;
  String? _updatedAt;
  String streamURL = "";
  dynamic _deletedAt;
  List<dynamic>? _events;
  List<dynamic>? _destinations;

  String? get id => _id;
  String? get name => _name;
  String? get userId => _userId;
  String? get source => _source;
  dynamic get details => _details;
  dynamic get lastEvent => _lastEvent;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  List<dynamic>? get events => _events;
  List<dynamic>? get destinations => _destinations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['user_id'] = _userId;
    map['source'] = _source;
    if (_details != null) {
      map['details'] = _details?.map((v) => v.toJson()).toList();
    }
    map['last_event'] = _lastEvent;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    if (_events != null) {
      map['events'] = _events?.map((v) => v.toJson()).toList();
    }
    if (_destinations != null) {
      map['destinations'] = _destinations?.map((v) => v).toList();
    }
    return map;
  }

}