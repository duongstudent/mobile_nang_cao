class Address {
  String? id;
  String? fullName;
  String? companyName;
  String? phoneNumber;
  String? province;
  String? district;
  String? commune;
  String? addressDetail;
  AddressType? addressType;

  Address(
      {this.id,
      this.fullName,
      this.companyName,
      this.phoneNumber,
      this.province,
      this.district,
      this.commune,
      this.addressDetail,
      this.addressType});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    companyName = json['companyName'];
    phoneNumber = json['phoneNumber'];
    province = json['province'];
    district = json['district'];
    commune = json['commune'];
    addressDetail = json['addressDetail'];
    addressType = json['addressType'] != null
        ? new AddressType.fromJson(json['addressType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['companyName'] = this.companyName;
    data['phoneNumber'] = this.phoneNumber;
    data['province'] = this.province;
    data['district'] = this.district;
    data['commune'] = this.commune;
    data['addressDetail'] = this.addressDetail;
    if (this.addressType != null) {
      data['addressType'] = this.addressType!.toJson();
    }
    return data;
  }
}

class AddressType {
  int? id;
  String? addressTypeName;

  AddressType({this.id, this.addressTypeName});

  AddressType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressTypeName = json['addressTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['addressTypeName'] = this.addressTypeName;
    return data;
  }
}
