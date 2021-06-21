class GetOpenTable {
  String message;
  int statusCode;
  String token;
  List<OpenTable> data;

  GetOpenTable({this.message, this.statusCode, this.token, this.data});

  GetOpenTable.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      data = new List<OpenTable>();
      json['Data'].forEach((v) {
        data.add(new OpenTable.fromJson(v));
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

class OpenTable {
  int id;
  String code;
  String name;
  bool isOpen;

  OpenTable({this.id, this.code, this.name, this.isOpen});

  OpenTable.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    code = json['Code'];
    name = json['Name'];
    isOpen = json['IsOpen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['IsOpen'] = this.isOpen;
    return data;
  }
}