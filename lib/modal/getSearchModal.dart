class getSearchModal {
  String message;
  int statusCode;
  String token;
  List<SearchItem> data;

  getSearchModal({this.message, this.statusCode, this.token, this.data});

  getSearchModal.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      data = new List<SearchItem>();
      json['Data'].forEach((v) {
        data.add(new SearchItem.fromJson(v));
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

class SearchItem {
  int id;
  String name;
  double rate;

  SearchItem({this.id, this.name, this.rate});

  SearchItem.fromJson(Map<String, dynamic> json) {
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
