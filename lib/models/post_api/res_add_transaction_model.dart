class ResAddTransactionModel {
  bool? success;
  Data? data;
  String? message;

  ResAddTransactionModel({this.success, this.data, this.message});

  ResAddTransactionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? date;
  String? transCode;
  List<Detail>? detail;
  int? id;

  Data({this.date, this.transCode, this.detail, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    transCode = json['trans_code'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(new Detail.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['trans_code'] = this.transCode;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Detail {
  int? id;
  String? name;
  String? description;
  int? price;
  String? photo;
  int? qty;

  Detail(
      {this.id, this.name, this.description, this.price, this.photo, this.qty});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    photo = json['photo'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['photo'] = this.photo;
    data['qty'] = this.qty;
    return data;
  }
}
