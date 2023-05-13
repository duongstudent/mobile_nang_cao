import 'addressModel.dart';

class User {
  String? id;
  String? fullName;
  String? email;
  String? gender;
  String? nickName;
  String? phone;
  DateTime? birthDate;
  String? img;
  bool? status;
  bool? active;
  String? country;
  int? createAt;
  int? updateAt;
  List<Address>? address;

  User(
      {this.id,
      this.fullName,
      this.email,
      this.gender,
      this.nickName,
      this.phone,
      this.birthDate,
      this.img,
      this.status,
      this.active,
      this.country,
      this.createAt,
      this.updateAt,
      this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    gender = json['gender'];
    nickName = json['nickName'];
    phone = json['phone'];
    birthDate = json['birthDate'];
    img = json['img'];
    status = json['status'];
    active = json['active'];
    country = json['country'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['nickName'] = this.nickName;
    data['phone'] = this.phone;
    data['birthDate'] = this.birthDate;
    data['img'] = this.img;
    data['status'] = this.status;
    data['active'] = this.active;
    data['country'] = this.country;
    data['createAt'] = this.createAt;
    data['updateAt'] = this.updateAt;
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Address {
//   String? id;
//   String? fullName;
//   String? companyName;
//   String? phoneNumber;
//   String? province;
//   String? district;
//   String? commune;
//   String? addressDetail;
//   AddressType? addressType;

//   Address(
//       {this.id,
//       this.fullName,
//       this.companyName,
//       this.phoneNumber,
//       this.province,
//       this.district,
//       this.commune,
//       this.addressDetail,
//       this.addressType});

//   Address.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     fullName = json['fullName'];
//     companyName = json['companyName'];
//     phoneNumber = json['phoneNumber'];
//     province = json['province'];
//     district = json['district'];
//     commune = json['commune'];
//     addressDetail = json['addressDetail'];
//     addressType = json['addressType'] != null
//         ? new AddressType.fromJson(json['addressType'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['fullName'] = this.fullName;
//     data['companyName'] = this.companyName;
//     data['phoneNumber'] = this.phoneNumber;
//     data['province'] = this.province;
//     data['district'] = this.district;
//     data['commune'] = this.commune;
//     data['addressDetail'] = this.addressDetail;
//     if (this.addressType != null) {
//       data['addressType'] = this.addressType!.toJson();
//     }
//     return data;
//   }
// }

// class AddressType {
//   int? id;
//   String? addressTypeName;

//   AddressType({this.id, this.addressTypeName});

//   AddressType.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     addressTypeName = json['addressTypeName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['addressTypeName'] = this.addressTypeName;
//     return data;
//   }
// }
