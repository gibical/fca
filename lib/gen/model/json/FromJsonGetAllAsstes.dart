import 'dart:convert';
import 'dart:developer';

class FromJsonGetAllAsstes {
  FromJsonGetAllAsstes({
      List<dynamic>? texts,
      List<dynamic>? images,
      List<dynamic>? audios,
      List<dynamic>? videos,}){
    _texts = texts;
    _images = images;
    _audios = audios;
    _videos = videos;
}

  FromJsonGetAllAsstes.fromJson(dynamic json) {
   // log('FromJsonGetAllAsstes.fromJson 1  = ${jsonDecode(json)}');

    if (json['data'] != null) {
      _all = [];
      json['data'].forEach((v) {
        _all?.add(v);
      });
    }
    if (json['texts'] != null) {
      _texts = [];
      json['texts'].forEach((v) {
        _texts?.add(v);
      });
    }
    if (json['images'] != null) {
      _images = [];

     // log('FromJsonGetAllAsstes.fromJson 2 = ${jsonDecode(json['images'])}');
      json['images'].forEach((v) {
        _images?.add(v);
      });
    }
    if (json['audios'] != null) {
      _audios = [];
      json['audios'].forEach((v) {
        _audios?.add(v);
      });
    }
    if (json['videos'] != null) {
      _videos = [];
      json['videos'].forEach((v) {
        _videos?.add(v);
      });
    }
  }
  List<dynamic>? _texts;
  List<dynamic>? _images;
  List<dynamic>? _audios;
  List<dynamic>? _videos;
  List<dynamic>? _all;
FromJsonGetAllAsstes copyWith({  List<dynamic>? texts,
  List<dynamic>? images,
  List<dynamic>? audios,
  List<dynamic>? videos,
}) => FromJsonGetAllAsstes(  texts: texts ?? _texts,
  images: images ?? _images,
  audios: audios ?? _audios,
  videos: videos ?? _videos,
);
  List<dynamic>? get texts => _texts;
  List<dynamic>? get images => _images;
  List<dynamic>? get audios => _audios;
  List<dynamic>? get videos => _videos;
  List<dynamic>? get all => _all;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_texts != null) {
      map['texts'] = _texts?.map((v) => v.toJson()).toList();
    }
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    if (_audios != null) {
      map['audios'] = _audios?.map((v) => v.toJson()).toList();
    }
    if (_videos != null) {
      map['videos'] = _videos?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Videos {
  Videos({
      num? id, 
      num? assetId, 
      String? name, 
      String? description, 
      num? type, 
      String? summary, 
      String? language, 
      String? genre, 
      String? country, 
      int? imdbScore, 
      int? productionYear, 
      int? length, 
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

  Videos.fromJson(dynamic json) {
    _id = json['id'];
    _assetId = json['asset_id'];
    _name = json['name'];
    _description = json['description'];
    _type = json['type'];
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
  int? _imdbScore;
  int? _productionYear;
  int? _length;
  List<String>? _producers;
  List<String>? _directors;
  List<String>? _actors;
  List<String>? _contributors;
  String? _createdAt;
  String? _updatedAt;
Videos copyWith({  num? id,
  num? assetId,
  String? name,
  String? description,
  num? type,
  String? summary,
  String? language,
  String? genre,
  String? country,
  int? imdbScore,
  int? productionYear,
  int? length,
  List<String>? producers,
  List<String>? directors,
  List<String>? actors,
  List<String>? contributors,
  String? createdAt,
  String? updatedAt,
}) => Videos(  id: id ?? _id,
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
  int? get imdbScore => _imdbScore;
  int? get productionYear => _productionYear;
  int? get length => _length;
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
    map['type'] = _type;
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

class Audios {
  Audios({
      num? id, 
      num? assetId, 
      String? name, 
      String? description, 
      num? type, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _assetId = assetId;
    _name = name;
    _description = description;
    _type = type;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Audios.fromJson(dynamic json) {
    _id = json['id'];
    _assetId = json['asset_id'];
    _name = json['name'];
    _description = json['description'];
    _type = json['type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _assetId;
  String? _name;
  String? _description;
  num? _type;
  String? _createdAt;
  String? _updatedAt;
Audios copyWith({  num? id,
  num? assetId,
  String? name,
  String? description,
  num? type,
  String? createdAt,
  String? updatedAt,
}) => Audios(  id: id ?? _id,
  assetId: assetId ?? _assetId,
  name: name ?? _name,
  description: description ?? _description,
  type: type ?? _type,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get assetId => _assetId;
  String? get name => _name;
  String? get description => _description;
  num? get type => _type;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['asset_id'] = _assetId;
    map['name'] = _name;
    map['description'] = _description;
    map['type'] = _type;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Images {
  Images({
      num? id, 
      num? assetId, 
      String? name, 
      String? description, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _assetId = assetId;
    _name = name;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Images.fromJson(dynamic json) {
    _id = json['id'];
    _assetId = json['asset_id'];
    _name = json['name'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _assetId;
  String? _name;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
Images copyWith({  num? id,
  num? assetId,
  String? name,
  String? description,
  String? createdAt,
  String? updatedAt,
}) => Images(  id: id ?? _id,
  assetId: assetId ?? _assetId,
  name: name ?? _name,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get assetId => _assetId;
  String? get name => _name;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['asset_id'] = _assetId;
    map['name'] = _name;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Texts {
  Texts({
      num? id, 
      num? assetId, 
      String? name, 
      String? description, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _assetId = assetId;
    _name = name;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Texts.fromJson(dynamic json) {
    _id = json['id'];
    _assetId = json['asset_id'];
    _name = json['name'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _assetId;
  String? _name;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
Texts copyWith({  num? id,
  num? assetId,
  String? name,
  String? description,
  String? createdAt,
  String? updatedAt,
}) => Texts(  id: id ?? _id,
  assetId: assetId ?? _assetId,
  name: name ?? _name,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get assetId => _assetId;
  String? get name => _name;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['asset_id'] = _assetId;
    map['name'] = _name;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}