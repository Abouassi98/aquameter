class ArchieveModel {
  int? code;
  String? message;
  List<ArchieveData>? data;

  ArchieveModel({this.code, this.message, this.data});

  ArchieveModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != num) {
      data = <ArchieveData>[];
      json['data'].forEach((v) {
        data!.add(ArchieveData.fromJson(v));
      });
    }
  }
}

class ArchieveData {
  int? id;
  String? name;
  int? phone;
  int? governorate;
  int? area;
  String? address;
  int? landSize;
  String? landSizeType;
  num? startingWeight;
  num? targetWeight;
  String? createdAt;
  String? updatedAt;
  num? ammonia;
  num? avrageWeight;
  num? totalNumber;
  num? conversionRate;
  num? numberOfDead;
  num? lat;
  num? long;
  int? userId;
  num? totalFeed;
  num? feed;
  num? company;
  num? toxicAmmonia;
  int? periodsResultCount;
  int? onlinePeriodsResultCount;
  GovernorateData? governorateData;
  GovernorateData? areaData;
  List<PeriodsResult>? periodsResult;
  List<Fish>? fish;

  ArchieveData(
      {this.id,
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
      this.periodsResult,
      this.fish});

  ArchieveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    governorate = json['governorate'];
    area = json['area'];
    address = json['address'];
    landSize = json['land_size'];
    landSizeType = json['land_size_type'];
    startingWeight = json['starting_weight'];
    targetWeight = json['target_weight'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ammonia = json['ammonia'];
    avrageWeight = json['avrage_weight'];
    totalNumber = json['total_number'];
    conversionRate = json['conversion_rate'];
    numberOfDead = json['number_of_dead'];
    lat = json['lat'];
    long = json['long'];
    userId = json['user_id'];
    totalFeed = json['total_feed'];
    feed = json['feed'];
    company = json['company'];
    toxicAmmonia = json['toxic_ammonia'];
    periodsResultCount = json['periods_result_count'];
    onlinePeriodsResultCount = json['online_periods_result_count'];
    governorateData = json['governorate_data'] != null
        ? GovernorateData.fromJson(json['governorate_data'])
        : null;
    areaData = json['area_data'] != null
        ? GovernorateData.fromJson(json['area_data'])
        : null;
    if (json['periods_result'] != num) {
      periodsResult = <PeriodsResult>[];
      json['periods_result'].forEach((v) {
        periodsResult!.add(PeriodsResult.fromJson(v));
      });
    }
    if (json['fish'] != num) {
      fish = <Fish>[];
      json['fish'].forEach((v) {
        fish!.add(Fish.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['governorate'] = governorate;
    data['area'] = area;
    data['address'] = address;
    data['land_size'] = landSize;
    data['land_size_type'] = landSizeType;
    data['starting_weight'] = startingWeight;
    data['target_weight'] = targetWeight;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['ammonia'] = ammonia;
    data['avrage_weight'] = avrageWeight;
    data['total_number'] = totalNumber;
    data['conversion_rate'] = conversionRate;
    data['number_of_dead'] = numberOfDead;
    data['lat'] = lat;
    data['long'] = long;
    data['user_id'] = userId;
    data['total_feed'] = totalFeed;
    data['feed'] = feed;
    data['company'] = company;
    data['toxic_ammonia'] = toxicAmmonia;
    data['periods_result_count'] = periodsResultCount;
    data['online_periods_result_count'] = onlinePeriodsResultCount;
    if (governorateData != null) {
      data['governorate_data'] = governorateData!.toJson();
    }
    if (areaData != null) {
      data['area_data'] = areaData!.toJson();
    }
    if (periodsResult != null) {
      data['periods_result'] = periodsResult!.map((v) => v.toJson()).toList();
    }
    if (fish != null) {
      data['fish'] = fish!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GovernorateData {
  int? id;
  String? names;

  GovernorateData({this.id, this.names});

  GovernorateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    names = json['names'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['names'] = names;
    return data;
  }
}

class PeriodsResult {
  int? id;
  String? mceeting;
  int? clientId;
  int? userId;
  int? totalWieght;
  num? avrageWieght;
  int? avrageFooder;
  dynamic endMceeting;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? startingWeight;
  int? targetWeight;
  int? ammonia;
  int? totalNumber;
  num? conversionRate;
  int? numberOfDead;
  int? feed;

  PeriodsResult(
      {this.id,
      this.mceeting,
      this.clientId,
      this.userId,
      this.totalWieght,
      this.avrageWieght,
      this.avrageFooder,
      this.endMceeting,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.startingWeight,
      this.targetWeight,
      this.ammonia,
      this.totalNumber,
      this.conversionRate,
      this.numberOfDead,
      this.feed});

  PeriodsResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mceeting = json['mceeting'];
    clientId = json['client_id'];
    userId = json['user_id'];
    totalWieght = json['total_wieght'];
    avrageWieght = json['avrage_weight'];
    avrageFooder = json['avrage_fooder'];
    endMceeting = json['end_mceeting'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    startingWeight = json['starting_weight'];
    targetWeight = json['target_weight'];
    ammonia = json['ammonia'];
    totalNumber = json['total_number'];
    conversionRate = json['conversion_rate'];
    numberOfDead = json['number_of_dead'];
    feed = json['feed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mceeting'] = mceeting;
    data['client_id'] = clientId;
    data['user_id'] = userId;
    data['total_wieght'] = totalWieght;
    data['avrage_wieght'] = avrageWieght;
    data['avrage_fooder'] = avrageFooder;
    data['end_mceeting'] = endMceeting;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    data['starting_weight'] = startingWeight;
    data['target_weight'] = targetWeight;
    data['ammonia'] = ammonia;
    data['total_number'] = totalNumber;
    data['conversion_rate'] = conversionRate;
    data['number_of_dead'] = numberOfDead;
    data['feed'] = feed;
    return data;
  }
}

class Fish {
  int? id;
  String? number;
  int? type;
  int? clientId;
  FishType? fishType;

  Fish({this.id, this.number, this.type, this.clientId, this.fishType});

  Fish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    type = json['type'];
    clientId = json['client_id'];
    fishType =
        json['fish_type'] != null ? FishType.fromJson(json['fish_type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    data['type'] = type;
    data['client_id'] = clientId;
    if (fishType != null) {
      data['fish_type'] = fishType!.toJson();
    }
    return data;
  }
}

class FishType {
  int? id;
  String? name;

  FishType({this.id, this.name});

  FishType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
