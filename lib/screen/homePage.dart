// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_final/screen/detaiProductPage.dart';

import '../network/networkApi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final urlImages = [
    'https://cdn.hoanghamobile.com/i/home/Uploads/2022/10/11/vivo-v25-series-1200x382.jpg',
    'https://cdn.hoanghamobile.com/i/home/Uploads/2022/10/21/iphone-14-1200x382.jpg',
    'https://cdn.hoanghamobile.com/i/home/Uploads/2022/10/04/tai-nghe-bwoo-1200x382.jpg',
    'https://cdn.hoanghamobile.com/i/home/Uploads/2022/10/06/laptop-gaming-gigabyte-1200x382.jpg',
    'https://cdn.hoanghamobile.com/i/home/Uploads/2022/10/19/web-hotsale-samsung-galaxy-a-series-01.jpg',
    'https://cdn.hoanghamobile.com/i/home/Uploads/2022/10/13/xiaomi-12t-series-1200x382.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.amber),
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Bạn muốn tìm kiếm sản phẩm nào ?",
                      fillColor: Colors.white70,
                      prefixIcon: const Icon(Icons.search)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            child: CarouselSlider.builder(
              itemCount: urlImages.length,
              options: CarouselOptions(
                height: 100,
                viewportFraction: 1,
                autoPlay: true,
                reverse: true,
                autoPlayInterval: const Duration(seconds: 2),
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final urlImage = urlImages[index];
                return buildImage(urlImage, index);
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("THƯƠNG HIỆU NỔI BẬT")),
                  ),
                  // _buildBtnRow(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 400,
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              constraints: const BoxConstraints.expand(),
              child: FutureBuilder(
                  future: fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => detailProduct(
                                            product: snapshot.data![index],
                                          )));
                            },
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Giảm giá: " +
                                        snapshot.data![index].discount
                                            .toString() +
                                        "%",
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                  Image.network(
                                    snapshot.data![index].image.toString(),
                                    width: 100,
                                    height: 100,
                                  ),
                                  Text(
                                        snapshot.data![index].name.toString(),
                                  ),
                                  Text(
                                    snapshot.data![index].price.toString(),
                                    style: const TextStyle(color: Colors.red),
                                  )
                                ],
                                // title: Text(snapshot.data![index].name.toString()),
                                // // subtitle: Text(snapshot.data[index].price.toString()),
                              ),
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget _buildBtnRow() {
//   return Row(
//     children: [
//       ElevatedButton.icon(onPressed: ()=>{},
//       icon: Image.asset('../assert/image/samsungicon.png'), label: const Text("SamSung"), ),

//     ],
//   );
// }

Widget buildImage(String urlImage, int index) {
  return Container(
    // margin: EdgeInsets.symmetric(horizontal: 12),
    color: Colors.grey,
    child: Image.network(
      urlImage,
      fit: BoxFit.cover,
    ),
  );
}
