// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:project_final/model/cartModel.dart';
import 'package:project_final/model/oderModel.dart';
import 'package:project_final/model/productModel.dart';
import 'package:http/http.dart' as http;

import '../model/UserModel.dart';
import '../model/addressModel.dart';
import '../model/detailAddressModel.dart';

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


//WishList

// my url is https://phone-s.herokuapp.com/api/user/profile
Future<List<Product>> fetchWishList(String tokenAccess) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*","Authorization": "Bearer " + tokenAccess};
  final res = await http
      .get(Uri.parse('https://phone-s.herokuapp.com/api/user/wishlist'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseProduct, res.body);
  } else {
    throw Exception('Request API error');
  }
}	

Future<List<Product>> fetchSearchList(String query) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*"};
  final res = await http
      .get(Uri.parse('https://phone-s.herokuapp.com/api/product/key/${query}?page=0&size=30&sort=product_id'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseProduct, res.body);
  } else {
    throw Exception('Request API error');
  }
}	

//Province by id
Province parseProvincebyId(String resBody) {
  final Map<String, dynamic> jsonMap = jsonDecode(resBody);
  Province province = Province.fromJson(jsonMap);
  return province;
}
// my url is https://phone-s.herokuapp.com/api/user/order
Future<Province> fetchProvincebyId(String province) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*",};
  final res = await http
      .get(Uri.parse('https://provinces.open-api.vn/api/p/${province}'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseProvincebyId, res.body);
  } else {
    throw Exception('Request API error');
  }
}
//district by id
District parseDistrictbyId(String resBody) {
  final Map<String, dynamic> jsonMap = jsonDecode(resBody);
  District district = District.fromJson(jsonMap);
  
  return district;
}
// my url is https://phone-s.herokuapp.com/api/user/order
Future<District> fetchDistrictbyId(String district) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*",};
  final res = await http
      .get(Uri.parse('https://provinces.open-api.vn/api/d/${district}'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseDistrictbyId, res.body);
  } else {
    throw Exception('Request API error');
  }
}

Commune parseCommunebyId(String resBody) {
  final Map<String, dynamic> jsonMap = jsonDecode(resBody);
  Commune commune = Commune.fromJson(jsonMap);
  
  return commune;
}
// my url is https://phone-s.herokuapp.com/api/user/order
Future<Commune> fetchCommunebyId(String commune) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*"};
  final res = await http
      .get(Uri.parse('https://provinces.open-api.vn/api/w/${commune}'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseCommunebyId, res.body);
  } else {
    throw Exception('Request API error');
  }
}

// all Provine
List<Province> parseProvince(String resBody) {
  var list = json.decode(resBody) as List<dynamic>;
  List<Province> provinceList = list
      .map((provinceJson) => Province.fromJson(provinceJson))
      .toList();
  provinceList.forEach((element) {
    if(element.name!= null){
      element.name = utf8.decode(element.name!.codeUnits);
    }
  });
  return provinceList;
}
// my url is https://phone-s.herokuapp.com/api/user/order
Future<List<Province>> fetchProvince() async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*",};
  final res = await http
      .get(Uri.parse('https://provinces.open-api.vn/api/p/'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseProvince, res.body);
  } else {
    throw Exception('Request API error');
  }
}


List<District> parseDistrictbyProvince(String resBody) {
  final Map<String, dynamic> jsonMap = jsonDecode(resBody);
  final List<dynamic> districtListJson = jsonMap['districts'];
  List<District> districtList = districtListJson
      .map((districtJson) => District.fromJson(districtJson))
      .toList();
  districtList.forEach((element) {
    if(element.name!= null){
      element.name = utf8.decode(element.name!.codeUnits);
    }
  });
  return districtList;
}
// my url is https://phone-s.herokuapp.com/api/user/order
Future<List<District>> fetchDistrictbyProvince(String province) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*",};
  final res = await http
      .get(Uri.parse('https://provinces.open-api.vn/api/p/${province}/?depth=2'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseDistrictbyProvince, res.body);
  } else {
    throw Exception('Request API error');
  }
}

List<Commune> parseCommunebyDistrict(String resBody) {
  final Map<String, dynamic> jsonMap = jsonDecode(resBody);
  final List<dynamic> communeListJson = jsonMap['wards'];
  List<Commune> communeList = communeListJson
      .map((communetJson) => Commune.fromJson(communetJson))
      .toList();
  communeList.forEach((element) {
    if(element.name!= null){
      element.name = utf8.decode(element.name!.codeUnits);
    }
  });
  return communeList;
}
// my url is https://phone-s.herokuapp.com/api/user/order
Future<List<Commune>> fetchCommunebyDistrict(String district) async {
  Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*",};
  final res = await http
      .get(Uri.parse('https://provinces.open-api.vn/api/d/${district}/?depth=2'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseCommunebyDistrict, res.body);
  } else {
    throw Exception('Request API error');
  }
}