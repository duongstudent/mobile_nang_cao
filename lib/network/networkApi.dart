// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:project_final/model/productModel.dart';
import 'package:http/http.dart' as http;

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
