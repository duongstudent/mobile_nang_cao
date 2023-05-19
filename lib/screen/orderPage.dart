import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_final/network/networkApi.dart';
import 'package:http/http.dart' as http;
import 'package:project_final/screen/updateAddress.dart';

import '../model/addressModel.dart';
import '../model/cartModel.dart';
import '../model/detailAddressModel.dart';
import '../variable.dart';

class OrderPage extends StatefulWidget {
  const OrderPage(
      {super.key,
      required this.listProduct,
      required this.listCart,
      required this.total});

  final List<Cart> listProduct;
  final List<String> listCart;
  final double total;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late List<Cart> listProduct;
  late List<String> listCart;
  late double total;
  late String address;
  late Future<List<Address>> _futureAddress;
  late String idAddress;
  Address? address1;

  Future<Province>? _province;
  Future<District>? _district;
  Future<Commune>? _commune;

  String? province;
  String? district;
  String? commune;

  @override
  void initState() {
    listCart = widget.listCart;
    listProduct = widget.listProduct;
    total = widget.total;
    getAddress();
    getIdAddress();
    super.initState();
  }

  void getAddress() {
    _futureAddress = fetchAddress(token!);
  }

  void getIdAddress() {
    _futureAddress.then((value) => {
          idAddress = value[0].id!,
        });
  }

  Order() async {
    Map data = {
      "address": idAddress,
      "listCart": listCart,
      "nullVoucher": true,
      "payment": 1,
      "ship": 1,
      "voucher": ""
    };
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer " + token!
    };
    var jsonResponse = null;
    var response = await http.post(
        Uri.parse('https://phone-s.herokuapp.com/api/user/order/insert'),
        body: jsonEncode(data),
        headers: headers);
    if (response.statusCode == 200) {
      print("order success");
      // ignore: use_build_context_synchronously
      Navigator.pop(context, "success");
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "Chi tiết đơn hàng",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, "back"),
        ),
      ),
      body: ListView(
        children: [
          Column(children: [
            SizedBox(
              height: 400,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Danh sách Sản Phẩm",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: listProduct.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Colors.grey),
                                  left: BorderSide(color: Colors.grey),
                                  right: BorderSide(color: Colors.grey),
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.network(
                                    listProduct[index].image.toString(),
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Giá: ${listProduct[index].price}"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Số lượng: ${listProduct[index].quantity}"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // address
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Thông tin giao hàng",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FutureBuilder(
                    future: _futureAddress,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Card(
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Tên người nhận: ${snapshot.data![0].fullName}"),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Số điện thoại nhận hàng: ${snapshot.data![0].phoneNumber}"),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                "Địa chỉ người nhận: ${snapshot.data![0].addressDetail},"),
                                          ),
                                        ),
                                        FutureBuilder(
                                          future: fetchCommunebyId(snapshot
                                              .data![0].commune
                                              .toString()),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                    " ${utf8.decode(snapshot.data!.name!.codeUnits)},"),
                                              );
                                            } else if (snapshot.hasError) {
                                              return const Text("null");
                                            }
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        FutureBuilder(
                                          future: fetchDistrictbyId(snapshot
                                              .data![0].district
                                              .toString()),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                    " ${utf8.decode(snapshot.data!.name!.codeUnits)},"),
                                              );
                                            } else if (snapshot.hasError) {
                                              return const Text("null");
                                            }
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                        FutureBuilder(
                                          future: fetchProvincebyId(snapshot
                                              .data![0].province
                                              .toString()),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        " ${utf8.decode(snapshot.data!.name!.codeUnits)},")),
                                              );
                                            } else if (snapshot.hasError) {
                                              return const Text("null");
                                            }
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () async {
                                    String rs = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateAddressPage(
                                            id: snapshot.data![0].id
                                                .toString()),
                                      ),
                                    );

                                    if (rs == "address") {
                                      setState(() {
                                        _futureAddress = fetchAddress(token!);
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tạm tính: ${totalPrice()}"),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Phí Ship: 20000"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tổng tiền: ${totalPrice() + 20000}"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Order();
              },
              child: const Text("Thanh toán khi giao hàng"),
            ),
          ]),
        ],
      ),
    );
  }

  double totalPrice() {
    double sum = 0;
    listProduct.forEach((element) {
      sum += ((element.price!) * (element.quantity!.toDouble()));
    });
    return sum;
  }
}
