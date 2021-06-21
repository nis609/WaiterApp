class PayemantMode {
  String message;
  int statusCode;
  String token;
  List<ModeOfPayment> data;

  PayemantMode({this.message, this.statusCode, this.token, this.data});

  PayemantMode.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      data = new List<ModeOfPayment>();
      json['Data'].forEach((v) {
        data.add(new ModeOfPayment.fromJson(v));
        data.removeWhere((element) => element.name=="Advance Pkr");
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

class ModeOfPayment {
  String name;

  ModeOfPayment({this.name});

  ModeOfPayment.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    return data;
  }
}
