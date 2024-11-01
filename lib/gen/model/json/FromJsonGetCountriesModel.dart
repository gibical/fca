class CountriesModel {
  CountriesModel({
      String? iso, 
      String? name, 
      String? callingCode, 
      String? title,}){
    _iso = iso;
    _name = name;
    _callingCode = callingCode;
    _title = title;
}

  CountriesModel.fromJson(dynamic json) {
    _iso = json['iso'];
    _name = json['name'];
    _callingCode = json['calling_code'];
    _title = json['title'];
  }
  String? _iso;
  String? _name;
  String? _callingCode;
  String? _title;

  String? get iso => _iso;
  String? get name => _name;
  String? get callingCode => _callingCode;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iso'] = _iso;
    map['name'] = _name;
    map['calling_code'] = _callingCode;
    map['title'] = _title;
    return map;
  }

}