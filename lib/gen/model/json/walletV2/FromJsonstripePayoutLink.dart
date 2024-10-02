class FromJsonstripePayoutLink {
  FromJsonstripePayoutLink({
      String? setup, 
      String? dashboard,}){
    _setup = setup;
    _dashboard = dashboard;
}

  FromJsonstripePayoutLink.fromJson(dynamic json) {
    _setup = json['setup'];
    _dashboard = json['dashboard'];
  }
  String? _setup;
  String? _dashboard;

  String? get setup => _setup;
  String? get dashboard => _dashboard;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['setup'] = _setup;
    map['dashboard'] = _dashboard;
    return map;
  }

}