class FrromJsonGetBiils {
  FrromJsonGetBiils({
      String? id, 
      num? userId, 
      String? relationType, 
      num? amount, 
      String? description, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _relationType = relationType;
    _amount = amount;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  FrromJsonGetBiils.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _relationType = json['relation_type'];
    _amount = json['amount'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  num? _userId;
  String? _relationType;
  num? _amount;
  String? _description;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  num? get userId => _userId;
  String? get relationType => _relationType;
  num? get amount => _amount;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['relation_type'] = _relationType;
    map['amount'] = _amount;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}