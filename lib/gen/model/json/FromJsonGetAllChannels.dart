import 'dart:convert';

import 'package:mediaverse/gen/model/json/FromJsonGetChannels.dart';
FromJsonGetAllChannels fromJsonGetAllChannelsFromJson(String str) => FromJsonGetAllChannels.fromJson(json.decode(str));
String fromJsonGetAllChannelsToJson(FromJsonGetAllChannels data) => json.encode(data.toJson());
class FromJsonGetAllChannels {
  FromJsonGetAllChannels({
      List<ChannelModel>? data,}){
    _data = data;
}

  FromJsonGetAllChannels.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ChannelModel.fromJson(v));
      });
    }
  }
  List<ChannelModel>? _data;

  List<ChannelModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

