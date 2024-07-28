class FromJsonGetstripePayout {
  FromJsonGetstripePayout({
      bool? enabled,}){
    _enabled = enabled;
}

  FromJsonGetstripePayout.fromJson(dynamic json) {
    _enabled = json['enabled'];
  }
  bool? _enabled;

  bool? get enabled => _enabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enabled'] = _enabled;
    return map;
  }

}