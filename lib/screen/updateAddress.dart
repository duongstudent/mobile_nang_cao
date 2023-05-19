import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_final/variable.dart';

import '../model/detailAddressModel.dart';
import '../network/networkApi.dart';

class UpdateAddressPage extends StatefulWidget {
  UpdateAddressPage({super.key, required this.id});

  String id;

  @override
  State<UpdateAddressPage> createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {
  String? idAddress;
  String? province;
  String? district;
  String? commune;

  Future<Province>? nameProvince;
  Future<District>? nameDistrict;
  Future<Commune>? nameCommune;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController detailAddressController = TextEditingController();

  @override
  void initState() {
    idAddress = widget.id;
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    detailAddressController.dispose();
    super.dispose();
  }

  updateAddress() async {
    Map data = {
      "addressDetail": detailAddressController.text,
      "addressType": 1,
      "commune": commune,
      "companyName": "Truong SPKT TPHCM",
      "district": district,
      "fullName": fullNameController.text,
      "phone": phoneController.text,
      "province": province
    };
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer ${token!}",
    };
    var jsonResponse = null;
    var response = await http.put(
      Uri.parse(
          'https://phone-s.herokuapp.com/api/user/address/update/${idAddress}'),
      body: jsonEncode(data),
      headers: headers,
    );
    if (response.statusCode == 200) {
      print("update address");
      Navigator.pop(context, "address");
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "Thay đổi địa chỉ nhận hàng",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context, "aaa"),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  hintText: 'Tên người nhận',
                  hintStyle: TextStyle(color: Colors.blue),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'Số điện thoại',
                  hintStyle: TextStyle(color: Colors.blue),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: fetchProvince(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
                      hint: nameProvince == null
                          ? Text('Chọn tỉnh thành', textAlign: TextAlign.center)
                          : FutureBuilder(
                              future: nameProvince,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    utf8
                                        .decode(snapshot.data!.name!.codeUnits)
                                        .toString(),
                                    style: TextStyle(color: Colors.blue),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.blue),
                      items: snapshot.data!.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val.code.toString(),
                            child: Text(val.name.toString()),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(() {
                          nameProvince = fetchProvincebyId(val!);
                          province = val;
                        });
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            province != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: fetchDistrictbyProvince(province!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButton(
                            hint: nameDistrict == null
                                ? Text('Chọn quận/huyện',
                                    textAlign: TextAlign.center)
                                : FutureBuilder(
                                    future: nameDistrict,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          utf8
                                              .decode(snapshot
                                                  .data!.name!.codeUnits)
                                              .toString(),
                                          style: TextStyle(color: Colors.blue),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: Colors.blue),
                            items: snapshot.data!.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val.code.toString(),
                                  child: Text(val.name.toString()),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(() {
                                nameDistrict = fetchDistrictbyId(val!);
                                district = val;
                              });
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      hint: const Text('Chọn quận/huyện',
                          textAlign: TextAlign.center),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: const TextStyle(color: Colors.blue),
                      items: [].map(
                        (val) {
                          return const DropdownMenuItem<String>(
                            value: "",
                            child: Text(""),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {},
                    ),
                  ),
            district != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: fetchCommunebyDistrict(district!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButton(
                            hint: nameCommune == null
                                ? const Text('Chọn quận/huyện',
                                    textAlign: TextAlign.center)
                                : FutureBuilder(
                                    future: nameCommune,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          utf8
                                              .decode(snapshot
                                                  .data!.name!.codeUnits)
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.blue),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: const TextStyle(color: Colors.blue),
                            items: snapshot.data!.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val.code.toString(),
                                  child: Text(val.name.toString()),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(() {
                                nameCommune = fetchCommunebyId(val!);
                                commune = val;
                              });
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      hint: const Text('Chọn phường/xã',
                          textAlign: TextAlign.center),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: const TextStyle(color: Colors.blue),
                      items: [].map(
                        (val) {
                          return const DropdownMenuItem<String>(
                            value: "",
                            child: Text(""),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {},
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: detailAddressController,
                decoration: const InputDecoration(
                  hintText: 'Nhập địa chỉ chi tiết',
                  hintStyle: TextStyle(color: Colors.blue),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      updateAddress();
                    },
                    child: const Text("Cập nhật")),
              ),
            ),
          ],
        ));
  }
}
