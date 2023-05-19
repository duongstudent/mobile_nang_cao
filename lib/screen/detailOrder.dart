import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_final/model/oderModel.dart';

import '../variable.dart';

class DetailOrder extends StatefulWidget {
  DetailOrder({super.key, required this.index, required this.order});

  Order order;
  int index;

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  Order? order;
  int? index;

  @override
  void initState() {
    order = widget.order;
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        title: Text(
          "Chi tiết đơn hàng",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, "aaaa"),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Danh sách Sản Phẩm",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: order!.cartResponseFEs!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                                    order!.cartResponseFEs![index].image
                                        .toString(),
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Giá: ${order!.cartResponseFEs![index].price}"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Số lượng: ${order!.cartResponseFEs![index].quantity}"),
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
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Phí Ship: 20000"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tổng tiền: ${order!.total}"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            index == 0
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      deleteOrder();
                    },
                    child: Text("Hủy đơn"),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  deleteOrder() async {
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer " + token!
    };
    var jsonResponse = null;
    var response = await http.delete(
        Uri.parse(
            'https://phone-s.herokuapp.com/api/user/order/delete/${order!.orderId}'),
        headers: headers);
    if (response.statusCode == 200) {
      Navigator.pop(context, "cancle");
    }
  }

  double totalPrice() {
    double sum = 0;
    order!.cartResponseFEs!.forEach((element) {
      sum += ((element.price!) * (element.quantity!.toDouble()));
    });
    return sum;
  }
}
