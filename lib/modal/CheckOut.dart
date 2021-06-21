class CheckOut {
  String message;
  int statusCode;
  String token;
  List<dynamic> data;

  CheckOut({this.message, this.statusCode, this.token, this.data});

  CheckOut.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    data = json['Data'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['StatusCode'] = this.statusCode;
    data['Token'] = this.token;
    data['Data'] = this.data;

    return data;
  }
}