class ParamsRequest {
  String? type;
  String? id;

  ParamsRequest({this.type, this.id});

  ParamsRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['UID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type ?? '';
    data['id'] = id ?? '';
    return data;
  }
}
