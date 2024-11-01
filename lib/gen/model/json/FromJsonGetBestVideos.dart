import 'package:mediaverse/gen/model/json/FromJsonGetmostText.dart';

import 'FromJsonGetBestModelVideows.dart';

class FromJsonGetBestVideos {
  FromJsonGetBestVideos({
      List<NewstVideos>? data,}){
    _data = data;
}

  FromJsonGetBestVideos.fromJson(dynamic json) {
    if (json['data']!= null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(v);
      });
    }
  }
  List<dynamic>? _data;

  List<dynamic>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class FromJsonGetBestText {
  FromJsonGetBestText({
      List<TextModel>? data,}){
    _data = data;
}

  FromJsonGetBestText.fromJson(dynamic json) {
    if (json['data']!= null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(v);
      });
    }
  }
  List<dynamic>? _data;

  List<dynamic>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class BestVideosModel {
  BestVideosModel({
      num? id, 
      num? assetId, 
      String? name, 
      String? description, 
      num? type, 
      String? summary, 
      String? language, 
      String? genre, 
      String? country,
      num? imdbScore, 
      num? productionYear, 
      num? length, 
      List<String>? producers, 
      List<String>? directors, 
      List<String>? actors, 
      List<String>? contributors, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _assetId = assetId;
    _name = name;
    _description = description;
    _type = type;
    _summary = summary;
    _language = language;
    _genre = genre;
    _country = country;
    _imdbScore = imdbScore;
    _productionYear = productionYear;
    _length = length;
    _producers = producers;
    _directors = directors;
    _actors = actors;
    _contributors = contributors;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  BestVideosModel.fromJson(dynamic json) {
    _id = json['id'];
    _assetId = json['asset_id'];
    _name = json['name'];
    _description = json['description'];
    _type = json['media_type'];
    _summary = json['summary'];
    _language = json['language'];
    _genre = json['genre'];
    _country = json['country'];
    _imdbScore = json['imdb_score'];
    _productionYear = json['production_year'];
    _length = json['length'];
    _producers = json['producers'] != null ? json['producers'].cast<String>() : [];
    _directors = json['directors'] != null ? json['directors'].cast<String>() : [];
    _actors = json['actors'] != null ? json['actors'].cast<String>() : [];
    _contributors = json['contributors'] != null ? json['contributors'].cast<String>() : [];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _assetId;
  String? _name;
  String? _description;
  num? _type;
  String? _summary;
  String? _language;
  String? _genre;
  String? _country;
  num? _imdbScore;
  num? _productionYear;
  num? _length;
  List<String>? _producers;
  List<String>? _directors;
  List<String>? _actors;
  List<String>? _contributors;
  String? _createdAt;
  String? _updatedAt;
BestVideosModel copyWith({  num? id,
  num? assetId,
  String? name,
  String? description,
  num? type,
  String? summary,
  String? language,
  String? genre,
  String? country,
  num? imdbScore,
  num? productionYear,
  num? length,
  List<String>? producers,
  List<String>? directors,
  List<String>? actors,
  List<String>? contributors,
  String? createdAt,
  String? updatedAt,
}) => BestVideosModel(  id: id ?? _id,
  assetId: assetId ?? _assetId,
  name: name ?? _name,
  description: description ?? _description,
  type: type ?? _type,
  summary: summary ?? _summary,
  language: language ?? _language,
  genre: genre ?? _genre,
  country: country ?? _country,
  imdbScore: imdbScore ?? _imdbScore,
  productionYear: productionYear ?? _productionYear,
  length: length ?? _length,
  producers: producers ?? _producers,
  directors: directors ?? _directors,
  actors: actors ?? _actors,
  contributors: contributors ?? _contributors,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get assetId => _assetId;
  String? get name => _name;
  String? get description => _description;
  num? get type => _type;
  String? get summary => _summary;
  String? get language => _language;
  String? get genre => _genre;
  String? get country => _country;
  num? get imdbScore => _imdbScore;
  num? get productionYear => _productionYear;
  num? get length => _length;
  List<String>? get producers => _producers;
  List<String>? get directors => _directors;
  List<String>? get actors => _actors;
  List<String>? get contributors => _contributors;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['asset_id'] = _assetId;
    map['name'] = _name;
    map['description'] = _description;
    map['media_type'] = _type;
    map['summary'] = _summary;
    map['language'] = _language;
    map['genre'] = _genre;
    map['country'] = _country;
    map['imdb_score'] = _imdbScore;
    map['production_year'] = _productionYear;
    map['length'] = _length;
    map['producers'] = _producers;
    map['directors'] = _directors;
    map['actors'] = _actors;
    map['contributors'] = _contributors;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}