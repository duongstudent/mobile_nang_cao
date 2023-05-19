// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_final/model/cartModel.dart';
import 'package:project_final/model/productModel.dart';
import 'package:project_final/screen/cartPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../controler/cart_controler.dart';
import '../network/networkApi.dart';
import '../variable.dart';

class detailProduct extends StatefulWidget {
  const detailProduct({super.key, required this.product});

  final Product product;

  @override
  State<detailProduct> createState() => _detailProductState();
}

class _detailProductState extends State<detailProduct> {
  CartControler cartControler = Get.find<CartControler>();

  late Product product;
  bool check = false;

  int _countProduct = 1;
  @override
  void initState() {
    super.initState();
    product = widget.product;
    getToken();
    if (token != null) {
      checkWishList();
    }
  }

  getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.getString("token");
    });
  }

  List<String> parseCheck(String body) {
    final Map<String, dynamic> jsonMap = jsonDecode(body);
    List<String> list = List.from(jsonMap["data"]["product"]);
    return list;
  }

  checkWishList() async {
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer ${token!}"
    };
    final res = await http.get(
        Uri.parse(
            'https://phone-s.herokuapp.com/api/user/wishlist/check?productId=${product.id}'),
        headers: headers);
    if (res.statusCode == 200) {
      List<String> list = parseCheck(res.body);
      if (list.isNotEmpty) {
        setState(() {
          check = true;
        });
      }
    } else {
      print(res.body);
    }
  }

  addWishList() async {
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer ${token!}"
    };
    final res = await http.post(
        Uri.parse(
            'https://phone-s.herokuapp.com/api/user/wishlist/add?productId=${product.id}'),
        headers: headers);
    if (res.statusCode == 200) {
      print("add success");
      setState(() {
        check = true;
      });
    } else {
      print(res.body);
    }
  }

  deleteWishList() async {
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer ${token!}"
    };
    final res = await http.delete(
        Uri.parse(
            'https://phone-s.herokuapp.com/api/user/wishlist/remove?productId=${product.id}'),
        headers: headers);
    if (res.statusCode == 200) {
      print("delete success");
      setState(() {
        check = false;
      });
    } else {
      print(res.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool IsAdd = false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "Mô tả sản phẩm",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            setState(() {
              check = false;
            });
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, top: 20.0, right: 20, bottom: 5.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.name.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: <Widget>[
                            Image.network(
                              product.img!.isNotEmpty
                                  ? product.img![0].toString()
                                  : product.image.toString(),
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "ROM",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      product.listAttributeOption![0].values![0]
                                          .value
                                          .toString(),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      decreaseProduct();
                                    },
                                    child: const Icon(Icons.remove),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[200],
                                      padding: EdgeInsets.all(8),
                                      shape: CircleBorder(),
                                      elevation: 0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    _countProduct.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      increaseProduct();
                                    },
                                    child: const Icon(Icons.add),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[200],
                                      padding: EdgeInsets.all(8),
                                      shape: CircleBorder(),
                                      elevation: 0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Tổng tiền: " +
                                      (product.price! * _countProduct)
                                          .toString() +
                                      "đ",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  // ElevatedButton(
                                  //   onPressed: () {},
                                  //   child: const Text("Mua Ngay"),
                                  //   style: ElevatedButton.styleFrom(
                                  //     primary: Colors.red,
                                  //     padding: EdgeInsets.symmetric(
                                  //         horizontal: 30, vertical: 10),
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(10),
                                  //     ),
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (token != null) {
                                        addProducttoCart();
                                      }
                                    },
                                    child: const Text("Thêm Vào Giỏ"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (token != null) {
                                    if (check) {
                                      //removeWishList
                                      deleteWishList();
                                    } else {
                                      //addWishList
                                      addWishList();
                                    }
                                  }
                                },
                                // styling the button
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(20),
                                  // Button color
                                  backgroundColor: Colors.white,
                                  // Splash color
                                  foregroundColor: Colors.cyan,
                                ),
                                child: check
                                    ? const Icon(Icons.favorite,
                                        color: Colors.red)
                                    : const Icon(Icons.favorite,
                                        color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Mô Tả Sản Phẩm",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.description.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Divider(thickness: 1.0),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Price: ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${product.price.toString()}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // increase Product void
  void increaseProduct() {
    setState(() {
      _countProduct++;
      if (_countProduct > 5) _countProduct = 5;
    });
  }

  //decrease Product void
  void decreaseProduct() {
    setState(() {
      _countProduct--;
      if (_countProduct < 1) _countProduct = 1;
    });
  }

  void addProducttoCart() async {
    Map data = {
      "listAttribute": [product.listAttributeOption![0].values![0].id],
      "productId": product.id,
      "quantity": _countProduct
    };
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer " + token!
    };
    var res = await http.post(
        Uri.parse('https://phone-s.herokuapp.com/api/user/cart/insert'),
        body: jsonEncode(data),
        headers: headers);
    var json = null;
    if (res.statusCode == 200) {
      List<Cart> cart = await fetchCart(token!);
      cartControler.addToCart(cart);
      // json = json.decode(res.body);
      print("add success");
    } else {
      print(res.body);
    }
  }
}

// my url is https://phone-s.herokuapp.com/api/user/cart
Future<List<Cart>> fetchCart(String tokenAccess) async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "*/*",
    "Authorization": "Bearer " + tokenAccess
  };
  final res = await http.get(
      Uri.parse('https://phone-s.herokuapp.com/api/user/cart'),
      headers: headers);
  if (res.statusCode == 200) {
    return compute(parseCart, res.body);
  } else {
    throw Exception('Request API error');
  }
}
