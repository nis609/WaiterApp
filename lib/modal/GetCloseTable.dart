class GetCloseTable {
  String message;
  int statusCode;
  String token;
  List<CloseTable> data;

  GetCloseTable({this.message, this.statusCode, this.token, this.data});

  GetCloseTable.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      data = new List<CloseTable>();
      json['Data'].forEach((v) {
        data.add(new CloseTable.fromJson(v));
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

class CloseTable {
  int id;
  String code;
  String name;
  bool isOpen;
  //this one sir
  // so tapialia teha ko item click garda yo closetable ko constructor access garnu parne?yes sir
  // and are they releated?yes sir , can you show me how?

  CloseTable({this.id, this.code, this.name, this.isOpen});

  CloseTable.fromJson(Map<String, dynamic> json) {
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