class HoldingResponseModel {
  List<HoldingModel>? holdingList;

  HoldingResponseModel({this.holdingList});

  HoldingResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['holdingList'] != null) {
      holdingList = <HoldingModel>[];
      json['holdingList'].forEach((v) {
        holdingList!.add(HoldingModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (holdingList != null) {
      data['holdingList'] = holdingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HoldingModel {
  String? id;
  String? symbol;
  String? name;
  num? qty;
  num? totalAmount;
  num? amount;

  HoldingModel({this.id, this.symbol, this.amount, this.totalAmount, this.name, this.qty});

  HoldingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    qty = json['qty'];
    totalAmount = json['totalAmount'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['symbol'] = symbol;
    data['name'] = name;
    data['qty'] = qty;
    data['amount'] = amount;
    return data;
  }
}
