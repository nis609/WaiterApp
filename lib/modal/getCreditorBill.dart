class GetCreditorBill {
  String message;
  int statusCode;
  String token;
  List<CreditorBill> data;

  GetCreditorBill(
      {this.message, this.statusCode, this.token, this.data});

  GetCreditorBill.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      data = new List<CreditorBill>();
      json['Data'].forEach((v) {

        data.add(new CreditorBill.fromJson(v));
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

class CreditorBill {
  String phone;
  String name;
  String Id;

  CreditorBill({this.phone, this.name,this.Id});

  CreditorBill.fromJson(Map<String, dynamic> json) {
    phone = json['Phone'];
    name = json['Name'];
    Id=json["Id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Phone'] = this.phone;
    data['Name'] = this.name;
    data['Id']=this.Id;
    return data;
  }
}
