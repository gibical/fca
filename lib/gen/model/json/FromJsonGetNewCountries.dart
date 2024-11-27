import 'dart:convert';
FromJsonGetNewCountries fromJsonGetNewCountriesFromJson(String str) => FromJsonGetNewCountries.fromJson(json.decode(str));
String fromJsonGetNewCountriesToJson(FromJsonGetNewCountries data) => json.encode(data.toJson());
class FromJsonGetNewCountries {
  FromJsonGetNewCountries({
      List<CountryModel>? data,}){
    _data = data;
}

  FromJsonGetNewCountries.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CountryModel.fromJson(v));
      });
    }
  }
  List<CountryModel>? _data;

  List<CountryModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

CountryModel dataFromJson(String str) => CountryModel.fromJson(json.decode(str));
String dataToJson(CountryModel data) => json.encode(data.toJson());
class CountryModel {
  CountryModel({
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

  CountryModel.fromJson(dynamic json) {
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