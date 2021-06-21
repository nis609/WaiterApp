class GetComment {
  String message;
  int statusCode;
  String token;
  List<Comments> data;

  GetComment({this.message, this.statusCode, this.token, this.data});

  GetComment.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      data = new List<Comments>();
      json['Data'].forEach((v) {
        data.add(new Comments.fromJson(v));
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

class Comments {
  int id;
  String comment;

  Comments({this.id, this.comment});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    comment = json['Comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Comment'] = this.comment;
    return data;
  }
}