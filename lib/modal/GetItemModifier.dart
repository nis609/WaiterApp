class GetItemModifier {
  String message;
  int statusCode;
  String token;
  List<ItemModifier> data;

  GetItemModifier({this.message, this.statusCode, this.token, this.data});

  GetItemModifier.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      data = new List<ItemModifier>();
      json['Data'].forEach((v) {
        data.add(new ItemModifier.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['StatusCode'] = this.statusCode;
    data['Token'] = this.token;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemModifier {
  int id;
  int itemId;
  String name;
  double extraPrice;

  ItemModifier({this.id, this.itemId, this.name, this.extraPrice});

  ItemModifier.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    itemId = json['ItemId'];
    name = json['Name'];
    extraPrice = json['ExtraPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ItemId'] = this.itemId;
    data['Name'] = this.name;
    data['ExtraPrice'] = this.extraPrice;
    return data;
  }
}