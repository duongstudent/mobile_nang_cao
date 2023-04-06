// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_final/model/productModel.dart';

class detailProduct extends StatelessWidget {
  const detailProduct({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.amber),
              child: Column(
                children: <Widget>[
                  Text(
                    product.name.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image.network(
                            product.img![0].toString(),
                            width: 250,
                            height: 250,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    product.price.toString() + "đ",
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 16),
                                  )),
                            ),
                            const Text("ROM"),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text(product.listAttributeOption![0]
                                        .values![0].value
                                        .toString())),
                                SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text(product.listAttributeOption![0]
                                        .values![1].value
                                        .toString())),
                              ],
                            ),
                            const Text("Mô Tả Sản Phẩm"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width: 200,
                                  child: Text(product.description.toString())),
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Icon(Icons.shopping_basket),
                                        ),
                                      ),
                                      TextSpan(text: 'Thêm vào giỏ hàng'),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Icon(Icons.favorite),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
