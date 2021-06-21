class GetTotalBills {
  String message;
  int statusCode;
  String token;
  List<TotalBills> totalBills;

  GetTotalBills({this.message, this.statusCode, this.token, this.totalBills});

  GetTotalBills.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      totalBills = new List<TotalBills>();
      json['Data'].forEach((v) {
        totalBills.add(new TotalBills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['StatusCode'] = this.statusCode;
    data['Token'] = this.token;
    if (this.totalBills != null) {
      data['Data'] = this.totalBills.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TotalBills {
  String item;
  int qty;
  double rate;
  double total;
  double subtTotal;
  double vat;
  double grandTotal;

  TotalBills(
      {this.item,
        this.qty,
        this.rate,
        this.total,
        this.subtTotal,
        this.vat,
        this.grandTotal});

  TotalBills.fromJson(Map<String, dynamic> json) {
    item = json['Item'];
    qty = json['Qty'];
    rate = json['Rate'];
    total = json['Total'];
    subtTotal = json['SubtTotal'];
    vat = json['Vat'];
    grandTotal = json['GrandTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Item'] = this.item;
    data['Qty'] = this.qty;
    data['Rate'] = this.rate;
    data['Total'] = this.total;
    data['SubtTotal'] = this.subtTotal;
    data['Vat'] = this.vat;
    data['GrandTotal'] = this.grandTotal;
    return data;
  }
}
