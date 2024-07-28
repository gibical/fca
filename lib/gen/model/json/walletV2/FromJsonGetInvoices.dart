class FromJsonGetInvoices {
  FromJsonGetInvoices({
      String? id, 
      num? payerId, 
      num? payeeId, 
      String? relationType, 
      num? relationId, 
      num? amount, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _payerId = payerId;
    _payeeId = payeeId;
    _relationType = relationType;
    _relationId = relationId;
    _amount = amount;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  FromJsonGetInvoices.fromJson(dynamic json) {
    _id = json['id'];
    _payerId = json['payer_id'];
    _payeeId = json['payee_id'];
    _relationType = json['relation_type'];
    _relationId = json['relation_id'];
    _amount = json['amount'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  num? _payerId;
  num? _payeeId;
  String? _relationType;
  num? _relationId;
  num? _amount;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  num? get payerId => _payerId;
  num? get payeeId => _payeeId;
  String? get relationType => _relationType;
  num? get relationId => _relationId;
  num? get amount => _amount;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['payer_id'] = _payerId;
    map['payee_id'] = _payeeId;
    map['relation_type'] = _relationType;
    map['relation_id'] = _relationId;
    map['amount'] = _amount;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}