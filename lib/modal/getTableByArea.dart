class getTablesByArea {
  String message;
  int statusCode;
  String token;
  List<TablesByArea> tablesByArea;

  getTablesByArea(
      {this.message, this.statusCode, this.token, this.tablesByArea});

  getTablesByArea.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      tablesByArea = new List<TablesByArea>();
      json['Data'].forEach((v) {
        tablesByArea.add(new TablesByArea.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['StatusCode'] = this.statusCode;
    data['Token'] = this.token;
    if (this.tablesByArea != null) {
      data['Data'] = this.tablesByArea.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TablesByArea {
  int id;
  String code;
  String name;
  bool isOpen;

  TablesByArea({this.id, this.code, this.name, this.isOpen});

  TablesByArea.fromJson(Map<String, dynamic> json) {
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
