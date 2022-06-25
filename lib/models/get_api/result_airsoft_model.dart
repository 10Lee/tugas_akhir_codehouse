class ResultsAirsoftModel {
  int? id;
  String? name;
  String? description;
  int? price;
  String? photo;
  late int qty;

  ResultsAirsoftModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.photo,
    required this.qty,
  });

  ResultsAirsoftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    photo = json['photo'];
    qty = json['qty'] == null ? qty = 0 : qty = json['qty'];
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
