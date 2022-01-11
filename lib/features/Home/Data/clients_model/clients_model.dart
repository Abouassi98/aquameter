class ClientsModel {
  int? code;
  String? message;
  List<Client>? data;

  ClientsModel({this.code, this.message, this.data});

  factory ClientsModel.fromJson(Map<String, dynamic> json) {
    return ClientsModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Client.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AreaData {
  int? id;
  String? names;

  AreaData({this.id, this.names});

  factory AreaData.fromJson(Map<String, dynamic> json) {
    return AreaData(
      id: json['id'] as int?,
      names: json['names'] as String?,
    );
  }
}

class Client {
  int? id;
  String? name;
  dynamic phone;
  int? governorate;
  int? area;
  String? address;
  int? landSize;
  String? landSizeType;
  int? startingWeight;
  int? targetWeight;
  String? createdAt;
  String? updatedAt;
  dynamic ammonia;
  dynamic avrageWeight;
  dynamic totalNumber;
  dynamic conversionRate;
  dynamic numberOfDead;
  dynamic feed;
  dynamic company;
  dynamic lat;
  dynamic long;
  int? userId;
  dynamic totalFeed;
  GovernorateData? governorateData;
  AreaData? areaData;
  List<Fish>? fish;
  dynamic toxicAmmonia;

  Client({
    this.id,
    this.name,
    this.phone,
    this.governorate,
    this.area,
    this.address,
    this.landSize,
    this.landSizeType,
    this.startingWeight,
    this.targetWeight,
    this.createdAt,
    this.updatedAt,
    this.ammonia,
    this.avrageWeight,
    this.totalNumber,
    this.conversionRate,
    this.numberOfDead,
    this.lat,
    this.long,
    this.userId,
    this.totalFeed,
    this.governorateData,
    this.areaData,
    this.fish,
    this.feed,
    this.company,
    this.toxicAmmonia,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as dynamic,
      governorate: json['governorate'] as int?,
      area: json['area'] as int?,
      address: json['address'] as String?,
      landSize: json['land_size'] as int?,
      landSizeType: json['land_size_type'] as String?,
      startingWeight: json['starting_weight'] as int?,
      targetWeight: json['target_weight'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      ammonia: json['ammonia'] as dynamic,
      avrageWeight: json['avrage_weight'] as dynamic,
      totalNumber: json['total_number'] as dynamic,
      conversionRate: json['conversion_rate'] as dynamic,
      numberOfDead: json['number_of_dead'] as dynamic,
      lat: json['lat'] as dynamic,
      long: json['long'] as dynamic,
      userId: json['user_id'] as int?,
      totalFeed: json['total_feed'] as dynamic,
      governorateData: json['governorate_data'] == null
          ? null
          : GovernorateData.fromJson(
              json['governorate_data'] as Map<String, dynamic>),
      areaData: json['area_data'] == null
          ? null
          : AreaData.fromJson(json['area_data'] as Map<String, dynamic>),
      fish: (json['fish'] as List<dynamic>?)
          ?.map((e) => Fish.fromJson(e as Map<String, dynamic>))
          .toList(),
      feed: json['feed'] as dynamic,
      company: json['company'] as dynamic,
      toxicAmmonia:  json['toxic_ammonia'] as dynamic,
    );
  }
}

class GovernorateData {
  int? id;
  String? names;

  GovernorateData({this.id, this.names});

  factory GovernorateData.fromJson(Map<String, dynamic> json) {
    return GovernorateData(
      id: json['id'] as int?,
      names: json['names'] as String?,
    );
  }
}

class Fish {
  int? id;
  String? number;
  int? type;
  int? clientId;
  FishType? fishType;

  Fish({this.id, this.number, this.type, this.clientId, this.fishType});

  factory Fish.fromJson(Map<String, dynamic> json) {
    return Fish(
      id: json['id'] as int?,
      number: json['number'] as String?,
      type: json['type'] as int?,
      clientId: json['client_id'] as int?,
      fishType: json['fish_type'] == null
          ? null
          : FishType.fromJson(json['fish_type'] as Map<String, dynamic>),
    );
  }
}

class FishType {
  int? id;
  String? name;

  FishType({this.id, this.name});

  factory FishType.fromJson(Map<String, dynamic> json) {
    return FishType(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}
