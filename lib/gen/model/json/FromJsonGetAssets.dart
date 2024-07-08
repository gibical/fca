class AssetsModel {
  AssetsModel({
      num? assets, 
      num? texts, 
      num? images, 
      num? audios, 
      num? videos, 
      num? salesNumber, 
      num? salesVolume,}){
    _assets = assets;
    _texts = texts;
    _images = images;
    _audios = audios;
    _videos = videos;
    _salesNumber = salesNumber;
    _salesVolume = salesVolume;
}

  AssetsModel.fromJson(dynamic json) {
    _assets = json['assets'];
    _texts = json['texts'];
    _images = json['images'];
    _audios = json['audios'];
    _videos = json['videos'];
    _salesNumber = int.parse(json['sales_number'].toString());
    _salesVolume = int.parse(json['sales_volume'].toString());
  }
  num? _assets;
  num? _texts;
  num? _images;
  num? _audios;
  num? _videos;
  num? _salesNumber;
  num? _salesVolume;
AssetsModel copyWith({  num? assets,
  num? texts,
  num? images,
  num? audios,
  num? videos,
  num? salesNumber,
  num? salesVolume,
}) => AssetsModel(  assets: assets ?? _assets,
  texts: texts ?? _texts,
  images: images ?? _images,
  audios: audios ?? _audios,
  videos: videos ?? _videos,
  salesNumber: salesNumber ?? _salesNumber,
  salesVolume: salesVolume ?? _salesVolume,
);
  num? get assets => _assets;
  num? get texts => _texts;
  num? get images => _images;
  num? get audios => _audios;
  num? get videos => _videos;
  num? get salesNumber => _salesNumber;
  num? get salesVolume => _salesVolume;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['assets'] = _assets;
    map['texts'] = _texts;
    map['images'] = _images;
    map['audios'] = _audios;
    map['videos'] = _videos;
    map['sales_number'] = _salesNumber;
    map['sales_volume'] = _salesVolume;
    return map;
  }

}