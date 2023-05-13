import 'package:project_final/model/cartModel.dart';

class Order {
  int? orderId;
  int? createdDate;
  int? orderStatus;
  int? expectedDate;
  int? total;
  String? name;
  AddressOrder? addressOrder;
  ShipOrder? shipOrder;
  PaymentOrder? paymentOrder;
  List<Cart>? cartResponseFEs;
  Null? voucherOrder;
  bool? paymentStatus;

  Order(
      {this.orderId,
      this.createdDate,
      this.orderStatus,
      this.expectedDate,
      this.total,
      this.name,
      this.addressOrder,
      this.shipOrder,
      this.paymentOrder,
      this.cartResponseFEs,
      this.voucherOrder,
      this.paymentStatus});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    createdDate = json['createdDate'];
    orderStatus = json['orderStatus'];
    expectedDate = json['expectedDate'];
    total = json['total'];
    name = json['name'];
    addressOrder = json['addressOrder'] != null
        ? new AddressOrder.fromJson(json['addressOrder'])
        : null;
    shipOrder = json['shipOrder'] != null
        ? new ShipOrder.fromJson(json['shipOrder'])
        : null;
    paymentOrder = json['paymentOrder'] != null
        ? new PaymentOrder.fromJson(json['paymentOrder'])
        : null;
    if (json['cartResponseFEs'] != null) {
      cartResponseFEs = <Cart>[];
      json['cartResponseFEs'].forEach((v) {
        cartResponseFEs!.add(new Cart.fromJson(v));
      });
    }
    voucherOrder = json['voucherOrder'];
    paymentStatus = json['paymentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['createdDate'] = this.createdDate;
    data['orderStatus'] = this.orderStatus;
    data['expectedDate'] = this.expectedDate;
    data['total'] = this.total;
    data['name'] = this.name;
    if (this.addressOrder != null) {
      data['addressOrder'] = this.addressOrder!.toJson();
    }
    if (this.shipOrder != null) {
      data['shipOrder'] = this.shipOrder!.toJson();
    }
    if (this.paymentOrder != null) {
      data['paymentOrder'] = this.paymentOrder!.toJson();
    }
    if (this.cartResponseFEs != null) {
      data['cartResponseFEs'] =
          this.cartResponseFEs!.map((v) => v.toJson()).toList();
    }
    data['voucherOrder'] = this.voucherOrder;
    data['paymentStatus'] = this.paymentStatus;
    return data;
  }
}

class AddressOrder {
  String? id;
  String? fullName;
  String? companyName;
  String? phoneNumber;
  String? province;
  String? district;
  String? commune;
  String? addressDetail;
  AddressType? addressType;

  AddressOrder(
      {this.id,
      this.fullName,
      this.companyName,
      this.phoneNumber,
      this.province,
      this.district,
      this.commune,
      this.addressDetail,
      this.addressType});

  AddressOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    companyName = json['companyName'];
    phoneNumber = json['phoneNumber'];
    province = json['province'];
    district = json['district'];
    commune = json['commune'];
    addressDetail = json['addressDetail'];
    addressType = json['addressType'] != null
        ? new AddressType.fromJson(json['addressType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['companyName'] = this.companyName;
    data['phoneNumber'] = this.phoneNumber;
    data['province'] = this.province;
    data['district'] = this.district;
    data['commune'] = this.commune;
    data['addressDetail'] = this.addressDetail;
    if (this.addressType != null) {
      data['addressType'] = this.addressType!.toJson();
    }
    return data;
  }
}

class AddressType {
  int? id;
  String? addressTypeName;

  AddressType({this.id, this.addressTypeName});

  AddressType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressTypeName = json['addressTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['addressTypeName'] = this.addressTypeName;
    return data;
  }
}

class ShipOrder {
  int? shipId;
  String? shipType;
  int? shipPrice;

  ShipOrder({this.shipId, this.shipType, this.shipPrice});

  ShipOrder.fromJson(Map<String, dynamic> json) {
    shipId = json['shipId'];
    shipType = json['shipType'];
    shipPrice = json['shipPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipId'] = this.shipId;
    data['shipType'] = this.shipType;
    data['shipPrice'] = this.shipPrice;
    return data;
  }
}

class PaymentOrder {
  int? paymentId;
  String? paymentName;

  PaymentOrder({this.paymentId, this.paymentName});

  PaymentOrder.fromJson(Map<String, dynamic> json) {
    paymentId = json['paymentId'];
    paymentName = json['paymentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentId'] = this.paymentId;
    data['paymentName'] = this.paymentName;
    return data;
  }
}

// class CartResponseFEs {
//   bool? choose;
//   List<String>? option;
//   List<String>? optionId;
//   String? id;
//   String? name;
//   String? image;
//   String? productId;
//   int? price;
//   int? quantity;

//   CartResponseFEs(
//       {this.choose,
//       this.option,
//       this.optionId,
//       this.id,
//       this.name,
//       this.image,
//       this.productId,
//       this.price,
//       this.quantity});

//   CartResponseFEs.fromJson(Map<String, dynamic> json) {
//     choose = json['choose'];
//     option = json['option'].cast<String>();
//     optionId = json['optionId'].cast<String>();
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     productId = json['productId'];
//     price = json['price'];
//     quantity = json['quantity'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['choose'] = this.choose;
//     data['option'] = this.option;
//     data['optionId'] = this.optionId;
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['productId'] = this.productId;
//     data['price'] = this.price;
//     data['quantity'] = this.quantity;
//     return data;
//   }
// }
