class FromJsonStripeSubscriptionLink {
  FromJsonStripeSubscriptionLink({
      String? link,}){
    _link = link;
}

  FromJsonStripeSubscriptionLink.fromJson(dynamic json) {
    _link = json['link'];
  }
  String? _link;

  String? get link => _link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['link'] = _link;
    return map;
  }

}