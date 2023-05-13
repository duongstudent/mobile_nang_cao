// ignore_for_file: file_names

class Cart {
  bool? choose;
  List<String>? option;
  List<String>? optionId;
  String? id;
  String? name;
  String? image;
  String? productId;
  double? price;
  int? quantity;

  Cart(
      {this.choose,
      this.option,
      this.optionId,
      this.id,
      this.name,
      this.image,
      this.productId,
      this.price,
      this.quantity});

  Cart.fromJson(Map<String, dynamic> json) {
    choose = json['choose'];
    option = json['option'].cast<String>();
    optionId = json['optionId'].cast<String>();
    id = json['id'];
    name = json['name'];
    image = json['image'];
    productId = json['productId'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['choose'] = this.choose;
    data['option'] = this.option;
    data['optionId'] = this.optionId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['productId'] = this.productId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
