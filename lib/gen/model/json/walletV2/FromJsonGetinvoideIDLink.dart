class FromJsonGetinvoideIdLink {
  FromJsonGetinvoideIdLink({
      String? url,}){
    _url = url;
}

  FromJsonGetinvoideIdLink.fromJson(dynamic json) {
    _url = json['url'];
  }
  String? _url;

  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    return map;
  }

}