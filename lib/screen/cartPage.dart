// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_final/network/networkApi.dart';
import 'package:project_final/screen/detaiProductPage.dart';
import 'package:project_final/screen/homePage.dart';
import 'package:project_final/screen/orderPage.dart';
import 'package:project_final/variable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../controler/cart_controler.dart';
import '../model/cartModel.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartControler cartControler = Get.find<CartControler>();

  List<String> listCart = [];
  List<Cart> listProduct = [];
  double total = 0;
  late Future<List<Cart>> _futureCart;
  String? name;

  @override
  void initState() {
    getToken();
    super.initState();
  }

  changeData() {
    setState(() {
      _futureCart = fetchCart(token!);
    });
  }

  void getData() {
    _futureCart.then((value) => {
          value.forEach((element) {
            if (element.choose!) {
              listCart.add(element.id.toString());
              // listCart.add('"${element.id}"');
              total += (element.price! * element.quantity!);
              listProduct.add(element);
            }
          }),
        });
  }

  getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      setState(() {
        token = sharedPreferences.getString("token");
        _futureCart = fetchCart(token!);
      });
    }
  }

  changeStatus(bool status, int quantity, String id) async {
    Map data = {"quantity": quantity, "status": !status};
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer " + token!,
    };
    var jsonResponse = null;
    var response = await http.put(
      Uri.parse('https://phone-s.herokuapp.com/api/user/cart/update/${id}'),
      body: jsonEncode(data),
      headers: headers,
    );
    if (response.statusCode == 200) {
      setState(() {
        _futureCart = fetchCart(token!);
      });
      print("update cart");
    } else {
      print(response.body);
    }
  }

  removeQuantity(bool status, int quantity, String id) async {
    if (quantity-- < 0) {
      quantity = 0;
    }
    Map data = {"quantity": quantity--, "status": status};
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer " + token!,
    };
    var jsonResponse = null;
    var response = await http.put(
      Uri.parse('https://phone-s.herokuapp.com/api/user/cart/update/${id}'),
      body: jsonEncode(data),
      headers: headers,
    );
    if (response.statusCode == 200) {
      setState(() {
        _futureCart = fetchCart(token!);
      });
      print("update cart");
    } else {
      print(response.body);
    }
  }

  addQuantity(bool status, int quantity, String id) async {
    if (quantity++ > 10) {
      quantity = 10;
    }
    Map data = {"quantity": quantity++, "status": status};
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer " + token!,
    };
    var jsonResponse = null;
    var response = await http.put(
      Uri.parse('https://phone-s.herokuapp.com/api/user/cart/update/${id}'),
      body: jsonEncode(data),
      headers: headers,
    );
    if (response.statusCode == 200) {
      setState(() {
        _futureCart = fetchCart(token!);
      });
      print("update cart");
    } else {
      print(response.body);
    }
  }

  //check dang nhap, xu ly lai logic
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          IconButton(
            onPressed: () {
              if (token != null) {
                setState(() {
                  _futureCart = fetchCart(token!);
                });
              }
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: token != null
                ? listCartBuilder()
                : const Text("Bạn chưa đăng nhập"),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (token != null) {
                    getData();
                    String order = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderPage(
                          listCart: listCart,
                          listProduct: listProduct,
                          total: total,
                        ),
                      ),
                    );
                    if (order == "success") {
                      setState(() {
                        _futureCart = fetchCart(token!);
                        listCart = [];
                        listProduct = [];
                        total = 0;
                      });
                    }
                    if (order == "back") {
                      setState(() {
                        listCart = [];
                        listProduct = [];
                        total = 0;
                      });
                    }
                  }
                },
                child: const Text("Mua Hàng"),
              ),
            ),
          )
        ],
      ),
    );
  }

  FutureBuilder<dynamic> listCartBuilder() {
    return FutureBuilder(
      future: _futureCart,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 40),
                          Checkbox(
                            value: snapshot.data![index].choose,
                            onChanged: (value) {
                              changeStatus(
                                snapshot.data![index].choose,
                                snapshot.data![index].quantity,
                                snapshot.data![index].id,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 6,
                        child: Image.network(
                          snapshot.data![index].image.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data![index].name.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Price: ${snapshot.data![index].price.toString()}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    removeQuantity(
                                      snapshot.data![index].choose,
                                      snapshot.data![index].quantity,
                                      snapshot.data![index].id,
                                    );
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                Text(snapshot.data![index].quantity.toString()),
                                IconButton(
                                  onPressed: () {
                                    addQuantity(
                                      snapshot.data![index].choose,
                                      snapshot.data![index].quantity,
                                      snapshot.data![index].id,
                                    );
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 40),
                          IconButton(
                            onPressed: () {
                              deleteCart(snapshot.data![index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

// Rest of the code remains the same...

// Rest of the code remains the same...

  deleteCart(String id) async {
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer " + token!
    };
    var jsonResponse = null;
    var response = await http.delete(
        Uri.parse('https://phone-s.herokuapp.com/api/user/cart/delete/' + id),
        headers: headers);
    if (response.statusCode == 200) {
      setState(() {
        _futureCart = fetchCart(token!);
      });
    }
  }

  chooseAllCart() async {
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer " + token!
    };

    var response = await http.put(
        Uri.parse(
            'https://phone-s.herokuapp.com/api/user/cart/choose/all?status=true'),
        headers: headers);
    if (response.statusCode == 200) {
      String order = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderPage(
                    listCart: listCart,
                    listProduct: listProduct,
                    total: total,
                  )));
      if (order == "success") {
        setState(() {
          _futureCart = fetchCart(token!);
        });
      }
      if (order == "back") {
        setState(() {
          listCart = [];
          listProduct = [];
          total = 0;
        });
      }
    } else {
      print(response.body);
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
