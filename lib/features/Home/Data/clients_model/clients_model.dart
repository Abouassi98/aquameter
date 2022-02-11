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

class PeriodsResult {
  int? id;
  String? mceeting;
  int? clientId;
  int? userId;
  int? totalWieght;
  int? avrageFooder;
  dynamic endMceeting;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? startingWeight;
  int? targetWeight;
  int? ammonia;
  int? avrageWeight;
  int? totalNumber;
  int? conversionRate;
  int? numberOfDead;
  int? feed;

  PeriodsResult({
    this.id,
    this.mceeting,
    this.clientId,
    this.userId,
    this.totalWieght,
    this.avrageFooder,
    this.endMceeting,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.startingWeight,
    this.targetWeight,
    this.ammonia,
    this.avrageWeight,
    this.totalNumber,
    this.conversionRate,
    this.numberOfDead,
    this.feed,
  });

  factory PeriodsResult.fromJson(Map<String, dynamic> json) {
    return PeriodsResult(
      id: json['id'] as int?,
      mceeting: json['mceeting'] as String?,
      clientId: json['client_id'] as int?,
      userId: json['user_id'] as int?,
      totalWieght: json['total_wieght'] as int?,
      avrageFooder: json['avrage_fooder'] as int?,
      endMceeting: json['end_mceeting'] as dynamic,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      status: json['status'] as int?,
      startingWeight: json['starting_weight'] as int?,
      targetWeight: json['target_weight'] as int?,
      ammonia: json['ammonia'] as int?,
      avrageWeight: json['avrage_weight'] as int?,
      totalNumber: json['total_number'] as int?,
      conversionRate: json['conversion_rate'] as int?,
      numberOfDead: json['number_of_dead'] as int?,
      feed: json['feed'] as int?,
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

class Client {
  int? id;
  String? name;
  int? phone;
  int? governorate;
  int? area;
  String? address;
  int? landSize;
  String? landSizeType;
  dynamic startingWeight;
  dynamic targetWeight;
  String? createdAt;
  String? updatedAt;
  dynamic ammonia;
  dynamic avrageWeight;
  dynamic totalNumber;
  dynamic conversionRate;
  dynamic numberOfDead;
  dynamic lat;
  dynamic long;
  int? userId;
  dynamic totalFeed;
  dynamic feed;
  dynamic company;
  dynamic toxicAmmonia;
  int? periodsResultCount;
  int? onlinePeriodsResultCount;
  GovernorateData? governorateData;
  AreaData? areaData;
  List<PeriodsResult>? onlinePeriodsResult;
  List<Fish>? fish;

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
    this.feed,
    this.company,
    this.toxicAmmonia,
    this.periodsResultCount,
    this.onlinePeriodsResultCount,
    this.governorateData,
    this.areaData,
    this.onlinePeriodsResult,
    this.fish,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as int?,
      governorate: json['governorate'] as int?,
      area: json['area'] as int?,
      address: json['address'] as String?,
      landSize: json['land_size'] as int?,
      landSizeType: json['land_size_type'] as String?,
      startingWeight: json['starting_weight'] as dynamic,
      targetWeight: json['target_weight'] as dynamic,
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
      feed: json['feed'] as dynamic,
      company: json['company'] as dynamic,
      toxicAmmonia: json['toxic_ammonia'] as dynamic,
      periodsResultCount: json['periods_result_count'] as int?,
      onlinePeriodsResultCount: json['online_periods_result_count'] as int?,
      governorateData: json['governorate_data'] == null
          ? null
          : GovernorateData.fromJson(
              json['governorate_data'] as Map<String, dynamic>),
      areaData: json['area_data'] == null
          ? null
          : AreaData.fromJson(json['area_data'] as Map<String, dynamic>),
      onlinePeriodsResult: (json['online_periods_result'] as List<dynamic>?)
          ?.map((e) => PeriodsResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      fish: (json['fish'] as List<dynamic>?)
          ?.map((e) => Fish.fromJson(e as Map<String, dynamic>))
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
