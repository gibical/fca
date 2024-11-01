class FromJsonGetMesseges {
  FromJsonGetMesseges({
      List<MessegesModel>? data,
      String? path, 
      num? perPage, 
      dynamic nextCursor, 
      dynamic nextPageUrl, 
      dynamic prevCursor, 
      dynamic prevPageUrl,}){
    _data = data;
    _path = path;
    _perPage = perPage;
    _nextCursor = nextCursor;
    _nextPageUrl = nextPageUrl;
    _prevCursor = prevCursor;
    _prevPageUrl = prevPageUrl;
}

  FromJsonGetMesseges.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MessegesModel.fromJson(v));
      });
    }
    _path = json['path'];
    _perPage = json['per_page'];
    _nextCursor = json['next_cursor'];
    _nextPageUrl = json['next_page_url'];
    _prevCursor = json['prev_cursor'];
    _prevPageUrl = json['prev_page_url'];
  }
  List<MessegesModel>? _data;
  String? _path;
  num? _perPage;
  dynamic _nextCursor;
  dynamic _nextPageUrl;
  dynamic _prevCursor;
  dynamic _prevPageUrl;
FromJsonGetMesseges copyWith({  List<MessegesModel>? data,
  String? path,
  num? perPage,
  dynamic nextCursor,
  dynamic nextPageUrl,
  dynamic prevCursor,
  dynamic prevPageUrl,
}) => FromJsonGetMesseges(  data: data ?? _data,
  path: path ?? _path,
  perPage: perPage ?? _perPage,
  nextCursor: nextCursor ?? _nextCursor,
  nextPageUrl: nextPageUrl ?? _nextPageUrl,
  prevCursor: prevCursor ?? _prevCursor,
  prevPageUrl: prevPageUrl ?? _prevPageUrl,
);
  List<MessegesModel>? get data => _data;
  String? get path => _path;
  num? get perPage => _perPage;
  dynamic get nextCursor => _nextCursor;
  dynamic get nextPageUrl => _nextPageUrl;
  dynamic get prevCursor => _prevCursor;
  dynamic get prevPageUrl => _prevPageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['next_cursor'] = _nextCursor;
    map['next_page_url'] = _nextPageUrl;
    map['prev_cursor'] = _prevCursor;
    map['prev_page_url'] = _prevPageUrl;
    return map;
  }

}

class MessegesModel {
  MessegesModel({
      num? id, 
      num? userId, 
      String? message, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _message = message;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  MessegesModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _message = json['message'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _userId;
  String? _message;
  String? _createdAt;
  String? _updatedAt;
MessegesModel copyWith({  num? id,
  num? userId,
  String? message,
  String? createdAt,
  String? updatedAt,
}) => MessegesModel(  id: id ?? _id,
  userId: userId ?? _userId,
  message: message ?? _message,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get userId => _userId;
  String? get message => _message;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['message'] = _message;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}