class WalletModel {
  WalletModel({
      String? type, 
      num? balance, 
      String? updatedAt,}){
    _type = type;
    _balance = balance;
    _updatedAt = updatedAt;
}

  WalletModel.fromJson(dynamic json) {
    _type = json['type'];
    _balance = json['balance'];
    _updatedAt = json['updated_at'];
  }
  String? _type;
  num? _balance;
  String? _updatedAt;
WalletModel copyWith({  String? type,
  num? balance,
  String? updatedAt,
}) => WalletModel(  type: type ?? _type,
  balance: balance ?? _balance,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get type => _type;
  num? get balance => _balance;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['balance'] = _balance;
    map['updated_at'] = _updatedAt;
    return map;
  }

}