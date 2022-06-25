class CartModel {
  int? id;
  String? name;
  int? price;
  String? photo;
  late int qty;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.photo,
    required this.qty,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    photo = json['photo'];
    qty = json['qty'] == null ? qty = 0 : qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['photo'] = this.photo;
    data['qty'] = this.qty;
    return data;
  }
}
