class CoinResponseModel {
  String? id;
  String? symbol;
  String? name;

  CoinResponseModel({this.id, this.symbol, this.name});

  CoinResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['symbol'] = symbol;
    data['name'] = name;
    return data;
  }
}