// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_final/model/productModel.dart';

class detailProduct extends StatefulWidget {
  const detailProduct({super.key, required this.product});

  final Product product;

  @override
  State<detailProduct> createState() => _detailProductState();
}

class _detailProductState extends State<detailProduct> {
  late Product product;

  int _countProduct = 0;
  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      product.listAttributeOption![0].values![1]
                                          .value
                                          .toString(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
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
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Mua Ngay"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  SizedBox(height: 10.0),
                  Divider(thickness: 1.0),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
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
      if (_countProduct < 0) _countProduct = 0;
    });
  }
}
