// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

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
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                FractionallySizedBox(
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
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 300,
                  child: CarouselSlider.builder(
                    itemCount: urlImages.length,
                    options: CarouselOptions(
                      height: 300,
                      viewportFraction: 1,
                      autoPlay: true,
                      reverse: true,
                      autoPlayInterval: const Duration(seconds: 2),
                    ),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      final urlImage = urlImages[index];
                      return buildImage(urlImage, index);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)
                )
              ),
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(alignment: Alignment.centerLeft,
                      child: Text("THƯƠNG HIỆU NỔI BẬT")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                              'https://cdn.tgdd.vn/Brand/1/logo-iphone-220x48.png',
                              height: 75.0,
                              width: 150.0,
                              ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                              'https://cdn.tgdd.vn/Brand/1/samsungnew-220x48-1.png',
                              height: 50.0,
                              width: 50.0,
                              ),
                        ),
                      ],
                    ),
                  )
                ],
                
            ),),
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
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Image.network(
                                            snapshot.data![index].image.toString(),
                                            width: double.infinity,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            "${snapshot.data![index].discount}% OFF",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data![index].name.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 10,),
                                      Flexible(
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            strutStyle: const StrutStyle(fontSize: 12.0),
                                            text: TextSpan(
                                              text: snapshot.data![index].description.toString(),
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "\$${snapshot.data![index].price.toString()}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
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
