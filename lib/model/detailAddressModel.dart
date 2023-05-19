class District {
  String? name;
  int? code;
  String? divisionType;
  String? codename;
  int? provinceCode;
  // List<Null>? wards;

  District(
      {this.name,
      this.code,
      this.divisionType,
      this.codename,
      this.provinceCode,
      // this.wards
      });

  District.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    divisionType = json['division_type'];
    codename = json['codename'];
    provinceCode = json['province_code'];
    // if (json['wards'] != null) {
    //   wards = <Null>[];
    //   json['wards'].forEach((v) {
    //     wards!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['division_type'] = this.divisionType;
    data['codename'] = this.codename;
    data['province_code'] = this.provinceCode;
    // if (this.wards != null) {
    //   data['wards'] = this.wards!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
class Commune {
  String? name;
  int? code;
  String? divisionType;
  String? codename;
  int? districtCode;

  Commune(
      {this.name,
      this.code,
      this.divisionType,
      this.codename,
      this.districtCode});

  Commune.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    divisionType = json['division_type'];
    codename = json['codename'];
    districtCode = json['district_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['division_type'] = this.divisionType;
    data['codename'] = this.codename;
    data['district_code'] = this.districtCode;
    return data;
  }
}
class Province {
  String? name;
  int? code;
  String? divisionType;
  String? codename;
  int? phoneCode;
  // List<Null>? districts;

  Province(
      {this.name,
      this.code,
      this.divisionType,
      this.codename,
      this.phoneCode,
      // this.districts
      });

  Province.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    divisionType = json['division_type'];
    codename = json['codename'];
    phoneCode = json['phone_code'];
    // if (json['districts'] != null) {
    //   districts = <Null>[];
    //   json['districts'].forEach((v) {
    //     districts!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['division_type'] = this.divisionType;
    data['codename'] = this.codename;
    data['phone_code'] = this.phoneCode;
    // if (this.districts != null) {
    //   data['districts'] = this.districts!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
