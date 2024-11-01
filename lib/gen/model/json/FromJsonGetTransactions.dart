class FromJsonGetTransactions {
  FromJsonGetTransactions({
      List<TransactionModel>? data,}){
    _data = data;
}

  FromJsonGetTransactions.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TransactionModel.fromJson(v));
      });
    }
  }
  List<TransactionModel>? _data;
FromJsonGetTransactions copyWith({  List<TransactionModel>? data,
}) => FromJsonGetTransactions(  data: data ?? _data,
);
  List<TransactionModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TransactionModel {
  TransactionModel({
      num? id, 
      num? amount, 
      num? newBalance, 
      String? description,
    String? relationType,
      num? relationId, 
      num? userId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _amount = amount;
    _newBalance = newBalance;
    _description = description;
    _relationType = relationType;
    _relationId = relationId;
    _userId = userId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  TransactionModel.fromJson(dynamic json) {
    _id = json['id'];
    _amount = json['amount'];
    _newBalance = json['new_balance'];
    _description = json['description'];
    _relationType = json['relation_type'];
    _relationId = json['relation_id'];
    _userId = json['user_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _amount;
  num? _newBalance;
  String? _description;
  String? _relationType;
  num? _relationId;
  num? _userId;
  String? _createdAt;
  String? _updatedAt;
TransactionModel copyWith({  num? id,
  num? amount,
  num? newBalance,
  String? description,
  String? relationType,
  num? relationId,
  num? userId,
  String? createdAt,
  String? updatedAt,
}) => TransactionModel(  id: id ?? _id,
  amount: amount ?? _amount,
  newBalance: newBalance ?? _newBalance,
  description: description ?? _description,
  relationType: relationType ?? _relationType,
  relationId: relationId ?? _relationId,
  userId: userId ?? _userId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get amount => _amount;
  num? get newBalance => _newBalance;
  String? get description => _description;
  String? get relationType => _relationType;
  num? get relationId => _relationId;
  num? get userId => _userId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['amount'] = _amount;
    map['new_balance'] = _newBalance;
    map['description'] = _description;
    map['relation_type'] = _relationType;
    map['relation_id'] = _relationId;
    map['user_id'] = _userId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}