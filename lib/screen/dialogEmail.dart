import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../variable.dart';

class DialogEmail extends StatefulWidget {
  const DialogEmail({super.key});

  @override
  State<DialogEmail> createState() => _DialogEmailState();
}

class _DialogEmailState extends State<DialogEmail> {

  final TextEditingController EmailController = TextEditingController();
  @override
  void dispose() {
    EmailController.dispose();
    super.dispose();
  }

  updateEmail() async {
    Map data = {
      "email": EmailController.text
    };
    Map<String,String> headers ={"content-type" : "application/json",
                                "accept" : "*/*", "Authorization": "Bearer " + token!};
    var jsonResponse = null;
    var response = await http.put(Uri.parse('https://phone-s.herokuapp.com/api/user/profile/changeEmail'),
                             body: jsonEncode(data), headers: headers);
    if(response.statusCode == 200) {
      Navigator.pop(context, "email");
    }
    else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog( // <-- SEE HERE
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text("Update Email"),
                TextField(
                  controller: EmailController,
                      decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.blue),
                      hintText: "Enter your name"
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: () {
                    updateEmail();
                  }, child: const Text('Update')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: () {
                    Navigator.pop(context, "aaa");
                  }, child: const Text('Cancel')),
                )
              ],
            ),
          ),
        );
  }
}