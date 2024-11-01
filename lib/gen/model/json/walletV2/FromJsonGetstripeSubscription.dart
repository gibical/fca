class FromJsonGetstripeSubscription {
  FromJsonGetstripeSubscription({
      bool? enabled, 
      num? debt, 
      String? currency,}){
    _enabled = enabled;
    _debt = debt;
    _currency = currency;
}

  FromJsonGetstripeSubscription.fromJson(dynamic json) {
    _enabled = json['enabled'];
    _debt = json['debt'];
    _currency = json['currency'];
  }
  bool? _enabled;
  num? _debt;
  String? _currency;

  bool? get enabled => _enabled;
  num? get debt => _debt;
  String? get currency => _currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enabled'] = _enabled;
    map['debt'] = _debt;
    map['currency'] = _currency;
    return map;
  }

}