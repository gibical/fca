import 'dart:convert';
FromJsonGetInvoices fromJsonGetInvoicesFromJson(String str) => FromJsonGetInvoices.fromJson(json.decode(str));
String fromJsonGetInvoicesToJson(FromJsonGetInvoices data) => json.encode(data.toJson());
class FromJsonGetInvoices {
  FromJsonGetInvoices({
      List<InvoiceModel>? data,
      String? path,
      num? perPage, 
      dynamic nextCursor, 
      dynamic nextPageUrl, 
      dynamic prevCursor, 
      dynamic prevPageUrl,}){
    _data = data;
    _path = path;
    _perPage = perPage;
    _nextCursor = nextCursor;
    _nextPageUrl = nextPageUrl;
    _prevCursor = prevCursor;
    _prevPageUrl = prevPageUrl;
}

  FromJsonGetInvoices.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(InvoiceModel.fromJson(v));
      });
    }
    _path = json['path'];
    _perPage = json['per_page'];
    _nextCursor = json['next_cursor'];
    _nextPageUrl = json['next_page_url'];
    _prevCursor = json['prev_cursor'];
    _prevPageUrl = json['prev_page_url'];
  }
  List<InvoiceModel>? _data;
  String? _path;
  num? _perPage;
  dynamic _nextCursor;
  dynamic _nextPageUrl;
  dynamic _prevCursor;
  dynamic _prevPageUrl;

  List<InvoiceModel>? get data => _data;
  String? get path => _path;
  num? get perPage => _perPage;
  dynamic get nextCursor => _nextCursor;
  dynamic get nextPageUrl => _nextPageUrl;
  dynamic get prevCursor => _prevCursor;
  dynamic get prevPageUrl => _prevPageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['next_cursor'] = _nextCursor;
    map['next_page_url'] = _nextPageUrl;
    map['prev_cursor'] = _prevCursor;
    map['prev_page_url'] = _prevPageUrl;
    return map;
  }

}

InvoiceModel dataFromJson(String str) => InvoiceModel.fromJson(json.decode(str));
String dataToJson(InvoiceModel data) => json.encode(data.toJson());
class InvoiceModel {
  InvoiceModel({
      String? id, 
      String? payerId, 
      String? payeeId, 
      String? relationType, 
      String? relationId, 
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

  InvoiceModel.fromJson(dynamic json) {
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
  String? _payerId;
  String? _payeeId;
  String? _relationType;
  String? _relationId;
  num? _amount;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get payerId => _payerId;
  String? get payeeId => _payeeId;
  String? get relationType => _relationType;
  String? get relationId => _relationId;
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