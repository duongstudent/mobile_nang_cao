// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_final/network/networkApi.dart';
import 'package:project_final/screen/changePassPage.dart';
import 'package:project_final/screen/historyPage.dart';
import 'package:project_final/screen/inforPage.dart';
import 'package:project_final/screen/wishPage.dart';
import 'package:project_final/variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences sharedPreferences;
  bool isLogin = false;

  //anh xa textfield
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      setState(() {
        isLogin = false;
      });
    } else {
      setState(() {
        token = sharedPreferences.getString("token");
        isLogin = true;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //Sign In Void
  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'phone': email, 'password': pass};
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
    };
    var jsonResponse = null;
    var response = await http.post(
        Uri.parse('https://phone-s.herokuapp.com/api/auth/login'),
        body: jsonEncode(data),
        headers: headers);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        //Xu ly data User from body
        setState(() {
          token = jsonResponse['data']['accessToken'];
          isLogin = true;
        });
        sharedPreferences.setString(
            "token", jsonResponse['data']['accessToken']);
      }
    } else {
      setState(() {
        isLogin = false;
      });
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Center(
          child: Container(
            color: Colors.red,
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height - 56,
            width: MediaQuery.of(context).size.width,
            child: isLogin ? detailProfilePage() : LoginForm(),
          ),
        ),
      ]),
    );
  }

  //isLogin == true
  Widget detailProfilePage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white, // Set the background color to white
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: fetchUser(token!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              return Column(
                children: [
                  // Avatar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.img.toString()),
                      radius: 100,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Buttons
                  Expanded(
                    child: ListView(
                      children: [
                        _buildProfileButton(
                          icon: Icons.person,
                          label: 'Thông tin tài khoản',
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InforPage()),
                              );
                            });
                          },
                        ),
                        _buildProfileButton(
                          icon: Icons.history,
                          label: 'Lịch sử mua hàng',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HistoryPage()),
                            );
                          },
                        ),
                        // _buildProfileButton(
                        //   icon: Icons.notifications,
                        //   label: 'Thông báo',
                        //   onPressed: () {
                        //     setState(() {
                        //       isLogin = false;
                        //     });
                        //   },
                        // ),
                        _buildProfileButton(
                          icon: Icons.favorite,
                          label: 'Sản phẩm yêu thích',
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WishPage()),
                              );
                            });
                          },
                        ),
                        // _buildProfileButton(
                        //   icon: Icons.discount,
                        //   label: 'Ưu đãi của bạn',
                        //   onPressed: () {},
                        // ),
                        _buildProfileButton(
                          icon: Icons.password,
                          label: 'Đổi Mật Khẩu',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChangePassPage()),
                            );
                          },
                        ),
                        _buildProfileButton(
                          icon: Icons.exit_to_app,
                          label: 'Log out',
                          onPressed: () {
                            sharedPreferences.clear();
                            sharedPreferences.commit();
                            setState(() {
                              isLogin = false;
                              // token = "";
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return LoginForm();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          alignment: Alignment.centerLeft,
          primary: Colors.amber, // Thay đổi tông màu thành Colors.amber
        ),
        icon: Icon(icon),
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }

  //isLogin == false
  Widget LoginForm() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(13, 71, 161, 1),
            Color.fromRGBO(21, 101, 192, 1),
            Color.fromRGBO(25, 118, 210, 1),
            Color.fromRGBO(30, 136, 229, 1),
          ],
        ),
      ),
      child: Center(
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onPressed: () {
                      signIn(phoneController.text, passwordController.text);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onPressed: () {
                      _showAlertDialogRegister(context);
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Register(String phone, String password) async {
  Map data = {'phone': phone, 'password': password};
  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "*/*",
  };
  var jsonResponse = null;
  var response = await http.post(
      Uri.parse('https://phone-s.herokuapp.com/api/user/register'),
      body: jsonEncode(data),
      headers: headers);
  if (response.statusCode == 200) {
    print("Register success");
  } else {
    print(response.body);
  }
}

//Dialog Register
Future<void> _showAlertDialogRegister(BuildContext context) async {
  final TextEditingController passwordRController = TextEditingController();
  final TextEditingController phoneRController = TextEditingController();
  final TextEditingController passwordR1Controller = TextEditingController();

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Register'), // Add a title to the dialog
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text("Please fill in the registration form:"),
              const SizedBox(
                  height:
                      16), // Add some spacing between the text and text fields
              TextField(
                controller: phoneRController,
                decoration: const InputDecoration(
                  labelText:
                      'Phone Number', // Provide a label for the text field
                  border:
                      OutlineInputBorder(), // Add a border around the text field
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                controller: passwordRController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordR1Controller,
                decoration: const InputDecoration(
                  labelText: 'Repassword',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Hide the password input
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      if (passwordRController.text ==
                          passwordR1Controller.text) {
                        Register(
                            phoneRController.text, passwordRController.text);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Register'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Colors.grey[400], // Use a different background color
                    ),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
