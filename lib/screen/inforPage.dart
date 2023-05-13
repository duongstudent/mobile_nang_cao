import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_final/network/networkApi.dart';
import 'package:project_final/screen/dialogEmail.dart';
import 'package:project_final/screen/updatePage.dart';
import 'package:project_final/variable.dart';

import '../model/UserModel.dart';

class InforPage extends StatefulWidget {
  InforPage({super.key});

  @override
  State<InforPage> createState() => _InforPageState();
}

class _InforPageState extends State<InforPage> {
  Future<User>? user;

  @override
  void initState() {
    user = fetchUser(token!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0),
                      child: Table(
                        border: TableBorder.all(color: Colors.white),
                        children: [
                          TableRow(children: [
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Full Name:",
                                )),
                            Text(snapshot.data!.fullName.toString()),
                            const SizedBox()
                          ]),
                          const TableRow(
                              children: [Text(""), Text(""), SizedBox()]),
                          TableRow(children: [
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Gender:",
                                )),
                            Text(snapshot.data!.gender.toString()),
                            const SizedBox()
                          ]),
                          const TableRow(
                              children: [Text(""), Text(""), SizedBox()]),
                          TableRow(children: [
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Phone number:",
                                )),
                            Text(snapshot.data!.phone.toString()),
                            const SizedBox()
                          ]),
                          const TableRow(
                              children: [Text(""), Text(""), SizedBox()]),
                          TableRow(children: [
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Email:",
                                )),
                            Text(snapshot.data!.email.toString()),
                            IconButton(
                                onPressed: () async {
                                  String? rs = await showDialog<String>(
                                    //<--------|
                                    context: context,
                                    builder: (context) => const DialogEmail(),
                                  );
                                  if (rs == "email") {
                                    setState(() {
                                      user = fetchUser(token!);
                                    });
                                  }
                                },
                                icon: const Icon(Icons.edit))
                          ]),
                          const TableRow(
                              children: [Text(""), Text(""), SizedBox()]),
                          TableRow(children: [
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Address:")),
                            Text(
                                "${snapshot.data!.address![0].addressDetail},${snapshot.data!.address![0].district},${snapshot.data!.address![0].province}"),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.edit))
                          ])
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          String rs = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UpdatePage()));
                          if (rs == "update") {
                            setState(() {
                              user = fetchUser(token!);
                            });
                          }
                        },
                        child: const Text("Update Profile"))
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
