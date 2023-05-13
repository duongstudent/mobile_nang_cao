// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:project_final/model/cartModel.dart';
import 'package:project_final/model/oderModel.dart';
import 'package:project_final/model/productModel.dart';
import 'package:http/http.dart' as http;

import '../model/UserModel.dart';
import '../model/addressModel.dart';

List<Product> parseProduct(String resBody) {
  final Map<String, dynamic> jsonMap = jsonDecode(resBody);
  final List<dynamic> productListJson = jsonMap['data']['listProduct'];
  List<Product> productList = productListJson
      .map((productJson) => Product.fromJson(productJson))
      .toList();

  // Decode Unicode to UTF-8
  productList.forEach((product) {
    if (product.name != null) {
      product.name = utf8.decode(product.name!.codeUnits);
    }
    if (product.description != null) {
      product.description = utf8.decode(product.description!.codeUnits);
    }
  });

  return productList;
}
// my url is https://phone-s.herokuapp.com/api/product/all
Future<List<Product>> fetchProducts() async {
  final res = await http
      .get(Uri.parse('https://phone-s.herokuapp.com/api/product/all'));
  if (res.statusCode == 200) {
    return compute(parseProduct, res.body);
  } else {
    throw Exception('Request API error');
  }
}

// Cart

List<Cart> parseCart(String resBody) {
  final Map<String, dynamic> jsonMap = jsonDecode(resBody);
  final List<dynamic> cartListJson = jsonMap['data']['listCart'];
  List<Cart> cartList = cartListJson
      .map((cartJson) => Cart.fromJson(cartJson))
      .toList();

  // Decode Unicode to UTF-8
  cartList.forEach((cart) {
    if (cart.name != null) {
      cart.name = utf8.decode(cart.name!.codeUnits);
    }
  });
  return cartList;
}
// my url is https://phone-s.herokuapp.com/api/user/cart
Future<List<Cart>> fetchCart(String tokenAccess) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*","Authorization": "Bearer " + tokenAccess};
  final res = await http
      .get(Uri.parse('https://phone-s.herokuapp.com/api/user/cart'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseCart, res.body);
  } else {
    throw Exception('Request API error');
  }
}

//Adress
List<Address> parseAdress(String resBody) {
  final Map<String, dynamic> jsonMap = jsonDecode(resBody);
  final List<dynamic> addressListJson = jsonMap['data']['addressList'];
  List<Address> addressList = addressListJson
      .map((cartJson) => Address.fromJson(cartJson))
      .toList();

  // Decode Unicode to UTF-8
  // cartList.forEach((cart) {
  //   if (cart.name != null) {
  //     cart.name = utf8.decode(cart.name!.codeUnits);
  //   }
  // });
  return addressList;
}
// my url is https://phone-s.herokuapp.com/api/user/cart
Future<List<Address>> fetchAddress(String tokenAccess) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*","Authorization": "Bearer " + tokenAccess};
  final res = await http
      .get(Uri.parse('https://phone-s.herokuapp.com/api/user/address'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseAdress, res.body);
  } else {
    throw Exception('Request API error');
  }
}


//Order Processing
List<Order> parsePOder(String resBody) {
  final Map<String, dynamic> jsonMap = jsonDecode(resBody);
  final List<dynamic> orderListJson = jsonMap['data']['listOrder'];
  List<Order> orderList = orderListJson
      .map((orderJson) => Order.fromJson(orderJson))
      .toList();
  List<Order> orderPList =[];
  orderList.forEach((element) {
    if(element.orderStatus == 0){
      orderPList.add(element);
    }
  });
  return orderPList;
}
// my url is https://phone-s.herokuapp.com/api/user/order
Future<List<Order>> fetchPOder(String tokenAccess) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*","Authorization": "Bearer " + tokenAccess};
  final res = await http
      .get(Uri.parse('https://phone-s.herokuapp.com/api/user/order'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parsePOder, res.body);
  } else {
    throw Exception('Request API error');
  }
}
//Order Delivery
List<Order> parseDOder(String resBody) {
  final Map<String, dynamic> jsonMap = jsonDecode(resBody);
  final List<dynamic> orderListJson = jsonMap['data']['listOrder'];
  List<Order> orderList = orderListJson
      .map((orderJson) => Order.fromJson(orderJson))
      .toList();
  List<Order> orderPList =[];
  orderList.forEach((element) {
    if(element.orderStatus == 1){
      orderPList.add(element);
    }
  });
  return orderPList;
}
// my url is https://phone-s.herokuapp.com/api/user/order
Future<List<Order>> fetchDOder(String tokenAccess) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*","Authorization": "Bearer " + tokenAccess};
  final res = await http
      .get(Uri.parse('https://phone-s.herokuapp.com/api/user/order'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseDOder, res.body);
  } else {
    throw Exception('Request API error');
  }
}
//Order Success
List<Order> parseSOder(String resBody) {
  final Map<String, dynamic> jsonMap = jsonDecode(resBody);
  final List<dynamic> orderListJson = jsonMap['data']['listOrder'];
  List<Order> orderList = orderListJson
      .map((orderJson) => Order.fromJson(orderJson))
      .toList();
  List<Order> orderPList =[];
  orderList.forEach((element) {
    if(element.orderStatus == 2){
      orderPList.add(element);
    }
  });
  return orderPList;
}
// my url is https://phone-s.herokuapp.com/api/user/order
Future<List<Order>> fetchSOder(String tokenAccess) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*","Authorization": "Bearer " + tokenAccess};
  final res = await http
      .get(Uri.parse('https://phone-s.herokuapp.com/api/user/order'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseSOder, res.body);
  } else {
    throw Exception('Request API error');
  }
}
//Cancel Order
List<Order> parseCOder(String resBody) {
  final Map<String, dynamic> jsonMap = jsonDecode(resBody);
  final List<dynamic> orderListJson = jsonMap['data']['listOrder'];
  List<Order> orderList = orderListJson
      .map((orderJson) => Order.fromJson(orderJson))
      .toList();
  List<Order> orderPList =[];
  orderList.forEach((element) {
    if(element.orderStatus == 3){
      orderPList.add(element);
    }
  });
  return orderPList;
}
// my url is https://phone-s.herokuapp.com/api/user/order
Future<List<Order>> fetchCOder(String tokenAccess) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*","Authorization": "Bearer " + tokenAccess};
  final res = await http
      .get(Uri.parse('https://phone-s.herokuapp.com/api/user/order'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseCOder, res.body);
  } else {
    throw Exception('Request API error');
  }
}

//Get User

User parseUser(String body) {
  final Map<String, dynamic> jsonMap = jsonDecode(body);
  User user = User.fromJson(jsonMap["data"]["user"]);
  return user;
}
// my url is https://phone-s.herokuapp.com/api/user/profile
Future<User> fetchUser(String tokenAccess) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*","Authorization": "Bearer " + tokenAccess};
  final res = await http
      .get(Uri.parse('https://phone-s.herokuapp.com/api/user/profile'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseUser, res.body);
  } else {
    throw Exception('Request API error');
  }
}