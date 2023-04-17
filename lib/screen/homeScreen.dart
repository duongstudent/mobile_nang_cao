// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_final/screen/homePage.dart';
import 'package:project_final/screen/noticePage.dart';
import 'package:project_final/screen/orderPage.dart';
import 'package:project_final/screen/profilePage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;

  final pages = [
    HomePage(),
    OrderPage(),
    // NoticePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack( 
        index: currentIndex,
        children: pages,),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) =>setState(() => currentIndex=index),
        backgroundColor: Colors.amber,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Cart',
            backgroundColor: Colors.white,
            ),
            // BottomNavigationBarItem(
            // icon: Icon(Icons.circle_notifications),
            // label: 'Home',
            // backgroundColor: Colors.blueAccent,
            // ),
            BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: Colors.white,
            ),
        ]),
    );
  }
}