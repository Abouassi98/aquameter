class AddClientModel {
  int? code;
  String? message;
  Data? data;

  AddClientModel({this.code, this.message, this.data});

  AddClientModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? name;
  String? phone;
  int? governorate;
  int? area;
  String? address;
  int? landSize;
  String? landSizeType;
  int? startingWeight;
  int? targetWeight;
  List<dynamic>? number;
  List<dynamic>? type;
  String? lat;
  String? long;
  String? feed;
  String? company;
  int? ammonia;
  int? avrageWeight;
  int? totalNumber;
  int? conversionRate;
  int? numberOfDead;

  Data(
      {this.name,
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
      this.feed,
      this.company,
      this.ammonia,
      this.avrageWeight,
      this.totalNumber,
      this.conversionRate,
      this.numberOfDead});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    governorate = json['governorate'];
    area = json['area'];
    address = json['address'];
    landSize = json['land_size'];
    landSizeType = json['land_size_type'];
    startingWeight = json['starting_weight'];
    targetWeight = json['target_weight'];
    number = json['number'] as List<dynamic>?;
    type = json['type'] as List<dynamic>?;
    lat = json['lat'];
    long = json['long'];
    feed = json['feed'];
    company = json['company'];
    ammonia = json['ammonia'];
    avrageWeight = json['avrage_weight'];
    totalNumber = json['total_number'];
    conversionRate = json['conversion_rate'];
    numberOfDead = json['number_of_dead'];
  }
}
