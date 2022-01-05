class AddClientModel {
  int? code;
  String? message;
  Client? data;

  AddClientModel({this.code, this.message, this.data});

  factory AddClientModel.fromJson(Map<String, dynamic> json) {
    return AddClientModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Client.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class Client {
  String? name;
  String? phone;
  int? governorate;
  int? area;
  String? address;
  int? landSize;
  String? landSizeType;
  int? startingWeight;
  int? targetWeight;
  List<int>? number;
  List<int>? type;
  String? lat;
  String? long;

  Client({
    this.name,
    this.phone,
    this.governorate,
    this.area,
    this.address,
    this.landSize,
    this.landSizeType,
    this.startingWeight,
    this.targetWeight,
    this.number,
    this.type,
    this.lat,
    this.long,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      governorate: json['governorate'] as int?,
      area: json['area'] as int?,
      address: json['address'] as String?,
      landSize: json['land_size'] as int?,
      landSizeType: json['land_size_type'] as String?,
      startingWeight: json['starting_weight'] as int?,
      targetWeight: json['target_weight'] as int?,
      number: json['number'] as List<int>?,
      type: json['type'] as List<int>?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
    );
  }
}
