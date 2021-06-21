class LoginModal {
  String message;
  int statusCode;
  String token;
  List<CreateUser> data;

  LoginModal({this.message, this.statusCode, this.token, this.data});

  LoginModal.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      data = new List<CreateUser>();
      json['Data'].forEach((v) {
        data.add(new CreateUser.fromJson(v));
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

class CreateUser {
  int userId;
  String userName;
  String password;
  String role;
  int code;

  CreateUser({this.userId, this.userName, this.password, this.role, this.code});

  CreateUser.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    userName = json['UserName'];
    password = json['Password'];
    role = json['Role'];
    code = json['Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    data['Role'] = this.role;
    data['Code'] = this.code;
    return data;
  }
}