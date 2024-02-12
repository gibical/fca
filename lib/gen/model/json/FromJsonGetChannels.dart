class FromJsonGetChannels {
  FromJsonGetChannels({
      List<ChannelModel>? data,}){
    _data = data;
}

  FromJsonGetChannels.fromJson(dynamic json) {
    if (json != null) {
      _data = [];
      json.forEach((v) {
        _data?.add(ChannelModel.fromJson(v));
      });
    }
  }
  List<ChannelModel>? _data;
FromJsonGetChannels copyWith({  List<ChannelModel>? data,
}) => FromJsonGetChannels(  data: data ?? _data,
);
  List<ChannelModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ChannelModel {
  ChannelModel({
      num? id, 
      String? title, 
      String? description, 
      num? type, 
      String? link, 
      String? thumbnail, 
      String? language,
    String? country,
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _title = title;
    _description = description;
    _type = type;
    _link = link;
    _thumbnail = thumbnail;
    _language = language;
    _country = country;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  ChannelModel.fromJson(dynamic json) {
    print('ChannelModel.fromJson 1 ');
    _id = json['id'];
    print('ChannelModel.fromJson 2 ');
    _title = json['title'];
    print('ChannelModel.fromJson 3 ');
    _description = json['description'];
    print('ChannelModel.fromJson 4 ');
    _type = json['type'];
    print('ChannelModel.fromJson 5 ');
    _link = json['link'];
    print('ChannelModel.fromJson 6 ');
    _thumbnail = json['thumbnail'];
    print('ChannelModel.fromJson 7 ');
    _language = json['language'];
    print('ChannelModel.fromJson 8 ');
    _country = json['country'].toString();
    print('ChannelModel.fromJson 9 ');
    _createdAt = json['created_at'];
    print('ChannelModel.fromJson 10 ');
    _updatedAt = json['updated_at'];
    print('ChannelModel.fromJson 11 ');
  }
  num? _id;
  String? _title;
  String? _description;
  num? _type;
  String? _link;
  String? _thumbnail;
  String? _language;
  String? _country;
  String? _createdAt;
  String? _updatedAt;
ChannelModel copyWith({  num? id,
  String? title,
  String? description,
  num? type,
  String? link,
  String? thumbnail,
  String? language,
  String? country,
  String? createdAt,
  String? updatedAt,
}) => ChannelModel(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  type: type ?? _type,
  link: link ?? _link,
  thumbnail: thumbnail ?? _thumbnail,
  language: language ?? _language,
  country: country ?? _country,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get title => _title;
  String? get description => _description;
  num? get type => _type;
  String? get link => _link;
  String? get thumbnail => _thumbnail;
  String? get language => _language;
  String? get country => _country;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['type'] = _type;
    map['link'] = _link;
    map['thumbnail'] = _thumbnail;
    map['language'] = _language;
    map['country'] = _country;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}