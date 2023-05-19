import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_final/network/networkApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/oderModel.dart';
import '../variable.dart';
import 'detailOrder.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    super.key,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<Order>> _listPOrder;
  late Future<List<Order>> _listDOrder;
  late Future<List<Order>> _listSOrder;
  late Future<List<Order>> _listCOrder;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      token = sharedPreferences.getString("token");
      setState(() {
        _listPOrder = fetchPOder(token!);
        _listDOrder = fetchDOder(token!);
        _listSOrder = fetchSOder(token!);
        _listCOrder = fetchCOder(token!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Lịch sửa mua hàng",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.amber,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Đang xử lý"),
              Tab(text: "Vận chuyển"),
              Tab(text: "Đã giao"),
              Tab(text: "Đã hủy"),
            ],
            indicatorColor:
                Colors.white, // Change the color of the selected tab indicator
            labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold), // Style the tab labels
          ),
        ),
        body: TabBarView(children: [
          ListOrder(_listPOrder, 0),
          ListOrder(_listDOrder, 1),
          ListOrder(_listSOrder, 2),
          ListOrder(_listCOrder, 3)
        ]),
      ),
    );
  }

  Column ListOrder(Future<List<Order>> listOrder, int number) {
    return Column(
      children: [
        Expanded(
          // Wrap the container in an Expanded widget to take all available vertical space
          child: Container(
            margin: const EdgeInsets.all(
                16), // Add some margin around the container
            child: FutureBuilder(
              future: listOrder,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          String rs = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailOrder(
                                  index: number, order: snapshot.data![index]),
                            ),
                          );
                          if (rs == "cancle") {
                            setState(() {
                              _listPOrder = fetchPOder(token!);
                              _listDOrder = fetchDOder(token!);
                              _listSOrder = fetchSOder(token!);
                              _listCOrder = fetchCOder(token!);
                            });
                          }
                        },
                        child: Card(
                          elevation:
                              2, // Add a slight elevation to the card for a 3D effect
                          child: Padding(
                            padding: const EdgeInsets.all(
                                16), // Add padding within the card
                            child: Row(
                              children: [
                                Expanded(
                                  // Expand the column to take all available horizontal space
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Align text to the left
                                    children: [
                                      Text(
                                        "Mã đơn hàng:",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                          snapshot.data![index].name.toString(),
                                          style: TextStyle(fontSize: 14)),
                                      SizedBox(height: 8),
                                      Text(
                                        "Tổng tiền:",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                          snapshot.data![index].total
                                              .toString(),
                                          style: TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(
                    child:
                        CircularProgressIndicator()); // Center the progress indicator
              },
            ),
          ),
        ),
      ],
    );
  }
}
