class getTablePreviousOrderForNewKOT {
  String message;
  int statusCode;
  String token;
  List<PreviousList> data;

  getTablePreviousOrderForNewKOT(
      {this.message, this.statusCode, this.token, this.data});

  getTablePreviousOrderForNewKOT.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    statusCode = json['StatusCode'];
    token = json['Token'];
    if (json['Data'] != null) {
      data = new List<PreviousList>();
      json['Data'].forEach((v) {
        data.add(new PreviousList.fromJson(v));
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

class PreviousList {
  int id;
  String subMenu;
  String itemName;
  int qty;
  bool isModifier;
  int modifierId;
  int code;
  bool isComment;
  int commentId;
  String comment;
  bool isNew;
  double rate;
  String details;
  int subMenuId;
  int unitId;
  String orderType;
  double subTotal;

  PreviousList(
      {this.id,
        this.subMenu,
        this.itemName,
        this.qty,
        this.isModifier,
        this.modifierId,
        this.code,
        this.isComment,
        this.commentId,
        this.comment,
        this.isNew,
        this.rate,
        this.details,
        this.subMenuId,
        this.unitId,
        this.orderType,
        this.subTotal});

  PreviousList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    subMenu = json['SubMenu'];
    itemName = json['ItemName'];
    qty = json['Qty'];
    isModifier = json['IsModifier'];
    modifierId = json['ModifierId'];
    code = json['Code'];
    isComment = json['IsComment'];
    commentId = json['CommentId'];
    comment = json['Comment'];
    isNew = json['IsNew'];
    rate = json['Rate'];
    details = json['Details'];
    subMenuId = json['SubMenuId'];
    unitId = json['UnitId'];
    orderType = json['OrderType'];
    subTotal = json['SubTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['SubMenu'] = this.subMenu;
    data['ItemName'] = this.itemName;
    data['Qty'] = this.qty;
    data['IsModifier'] = this.isModifier;
    data['ModifierId'] = this.modifierId;
    data['Code'] = this.code;
    data['IsComment'] = this.isComment;
    data['CommentId'] = this.commentId;
    data['Comment'] = this.comment;
    data['IsNew'] = this.isNew;
    data['Rate'] = this.rate;
    data['Details'] = this.details;
    data['SubMenuId'] = this.subMenuId;
    data['UnitId'] = this.unitId;
    data['OrderType'] = this.orderType;
    data['SubTotal'] = this.subTotal;
    return data;
  }
}
