// ignore_for_file: file_names, unnecessary_new

class Product {
  String? id;
  String? image;
  String? name;
  String? description;
  double? rate;
  double? price;
  double? discount;
  int? sold;
  int? inventory;
  String? brand;
  String? origins;
  String? category;
  List<String>? img;
  List<ListAttributeOption>? listAttributeOption;

  Product({
    this.id,
    this.image,
    this.name,
    this.description,
    this.rate,
    this.price,
    this.discount,
    this.sold,
    this.inventory,
    this.brand,
    this.origins,
    this.category,
    this.img,
    this.listAttributeOption,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    rate = json['rate'];
    price = json['price'];
    discount = json['discount'];
    sold = json['sold'];
    inventory = json['inventory'];
    brand = json['brand'];
    origins = json['origins'];
    category = json['category'];
    img = json['img'].cast<String>();
    if (json['listAttributeOption'] != null) {
      listAttributeOption = <ListAttributeOption>[];
      json['listAttributeOption'].forEach((v) {
        listAttributeOption!.add(new ListAttributeOption.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['rate'] = this.rate;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['sold'] = this.sold;
    data['inventory'] = this.inventory;
    data['brand'] = this.brand;
    data['origins'] = this.origins;
    data['category'] = this.category;
    data['img'] = this.img;
    if (this.listAttributeOption != null) {
      data['listAttributeOption'] =
          this.listAttributeOption!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListAttributeOption {
  List<Values>? values;
  String? name;
  String? id;

  ListAttributeOption({this.values, this.name, this.id});

  ListAttributeOption.fromJson(Map<String, dynamic> json) {
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(new Values.fromJson(v));
      });
    }
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.values != null) {
      data['values'] = this.values!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class Values {
  double? compare;
  String? idType;
  String? id;
  String? value;

  Values({this.compare, this.idType, this.id, this.value});

  Values.fromJson(Map<String, dynamic> json) {
    compare = json['compare'];
    idType = json['idType'];
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compare'] = this.compare;
    data['idType'] = this.idType;
    data['id'] = this.id;
    data['value'] = this.value;
    return data;
  }
}