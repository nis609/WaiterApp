class getKotMenu {
  String message;
  int statusCode;
  String token;
  List<KotMenu> data;

  getKotMenu({this.message, this.statusCode, this.token, this.data});

  getKotMenu.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      data = new List<KotMenu>();
      json['Data'].forEach((v) {
        data.add(new KotMenu.fromJson(v));
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

class KotMenu {
  int id;
  String name;
  double rate;

  KotMenu({this.id, this.name, this.rate});

  KotMenu.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    rate = json['Rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Rate'] = this.rate;
    return data;
  }
}