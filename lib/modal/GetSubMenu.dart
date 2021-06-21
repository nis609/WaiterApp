class GetSubMenu {
  String message;
  int statusCode;
  String token;
  List<SubMenuDetail> data;

  GetSubMenu({this.message, this.statusCode, this.token, this.data});

  GetSubMenu.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      data = new List<SubMenuDetail>();
      json['Data'].forEach((v) {
        data.add(new SubMenuDetail.fromJson(v));
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

class SubMenuDetail {
  int id;
  String name;

  SubMenuDetail({this.id, this.name});

  SubMenuDetail.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    return data;
  }
}