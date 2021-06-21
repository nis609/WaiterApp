class GetBillById {
  String message;
  int statusCode;
  String token;
  List<Bills> data;

  GetBillById({this.message, this.statusCode, this.token, this.data});

  GetBillById.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      data = new List<Bills>();
      json['Data'].forEach((v) {
        data.add(new Bills.fromJson(v));
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

class Bills {
  String order;
  String item;
  String time;
  int qty;
  double total;
  int id;
  int tblId;
  String tabName;

  Bills(
      {this.order,
        this.item,
        this.time,
        this.qty,
        this.total,
        this.id,
        this.tblId,
        this.tabName});

  Bills.fromJson(Map<String, dynamic> json) {
    order = json['Order'];
    item = json['Item'];
    time = json['Time'];
    qty = json['Qty'];
    total = json['Total'];
    id = json['Id'];
    tblId = json['TblId'];
    tabName = json['TabName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Order'] = this.order;
    data['Item'] = this.item;
    data['Time'] = this.time;
    data['Qty'] = this.qty;
    data['Total'] = this.total;
    data['Id'] = this.id;
    data['TblId'] = this.tblId;
    data['TabName'] = this.tabName;
    return data;
  }
}