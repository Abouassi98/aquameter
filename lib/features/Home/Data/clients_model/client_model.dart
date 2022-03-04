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

class Client {
  int? id;
  String? name;
  String? phone;
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
  List<OnlinePeriodsResult>? onlinePeriodsResult;
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
      phone: json['phone'] as String?,
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
          ?.map((e) => OnlinePeriodsResult.fromJson(e as Map<String, dynamic>))
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

class MeetingResult {
  int? id;
  int? meetingId;
  double? temperature;
  double? ph;
  double? salinity;
  double? oxygen;
  double? ammonia;
  dynamic averageWeight;
  double? totalWeight;
  double? conversionRate;
  String? createdAt;
  String? updatedAt;
  int? feed;
  int? deadFish;
  String? notes;
  dynamic totalNumber;
  double? toxicAmmonia;
  String? realDate;
  int? clientId;
  int? periodId;

  MeetingResult({
    this.id,
    this.meetingId,
    this.temperature,
    this.ph,
    this.salinity,
    this.oxygen,
    this.ammonia,
    this.averageWeight,
    this.totalWeight,
    this.conversionRate,
    this.createdAt,
    this.updatedAt,
    this.feed,
    this.deadFish,
    this.notes,
    this.totalNumber,
    this.toxicAmmonia,
    this.realDate,
    this.clientId,
    this.periodId,
  });

  factory MeetingResult.fromJson(Map<String, dynamic> json) {
    return MeetingResult(
      id: json['id'] as int?,
      meetingId: json['meeting_id'] as int?,
      temperature: (json['temperature'] as num?)?.toDouble(),
      ph: (json['ph'] as num?)?.toDouble(),
      salinity: (json['salinity'] as num?)?.toDouble(),
      oxygen: (json['oxygen'] as num?)?.toDouble(),
      ammonia: (json['ammonia'] as num?)?.toDouble(),
      averageWeight: json['average_weight'] as dynamic,
      totalWeight: (json['total_weight'] as num?)?.toDouble(),
      conversionRate: (json['conversion_rate'] as num?)?.toDouble(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      feed: json['feed'] as int?,
      deadFish: json['dead_fish'] as int?,
      notes: json['notes'] as String?,
      totalNumber: json['total_number'] as dynamic,
      toxicAmmonia: (json['toxic_ammonia'] as num?)?.toDouble(),
      realDate: json['real_date'] as String?,
      clientId: json['client_id'] as int?,
      periodId: json['period_id'] as int?,
    );
  }
}

class Meeting {
  int? id;
  String? meeting;
  int? clientId;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? periodId;

  Meeting({
    this.id,
    this.meeting,
    this.clientId,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.periodId,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['id'] as int?,
      meeting: json['meeting'] as String?,
      clientId: json['client_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      userId: json['user_id'] as int?,
      periodId: json['period_id'] as int?,
    );
  }
}

class OnlinePeriodsResult {
  int? id;
  String? mceeting;
  int? clientId;
  int? userId;
  dynamic totalWieght;
  dynamic avrageFooder;
  dynamic endMceeting;
  String? createdAt;
  String? updatedAt;
  int? status;
  double? startingWeight;
  num? targetWeight;
  num? ammonia;
  double? avrageWeight;
  int? totalNumber;
  num? conversionRate;
  int? numberOfDead;
  int? feed;
  List<Meeting>? meetings;
  List<MeetingResult>? meetingResults;

  OnlinePeriodsResult({
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
    this.meetings,
    this.meetingResults,
  });

  factory OnlinePeriodsResult.fromJson(Map<String, dynamic> json) {
    return OnlinePeriodsResult(
      id: json['id'] as int?,
      mceeting: json['mceeting'] as String?,
      clientId: json['client_id'] as int?,
      userId: json['user_id'] as int?,
      totalWieght: json['total_wieght'] as dynamic,
      avrageFooder: json['avrage_fooder'] as dynamic,
      endMceeting: json['end_mceeting'] as dynamic,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      status: json['status'] as int?,
      startingWeight: (json['starting_weight'] as num?)?.toDouble(),
      targetWeight: (json['target_weight'] as num?)?.toDouble(),
      ammonia: (json['ammonia'] as num?)?.toDouble(),
      avrageWeight: (json['avrage_weight'] as num?)?.toDouble(),
      totalNumber: json['total_number'] as int?,
      conversionRate: (json['conversion_rate'] as num?)?.toDouble(),
      numberOfDead: json['number_of_dead'] as int?,
      feed: json['feed'] as int?,
      meetings: (json['meetings'] as List<dynamic>?)
          ?.map((e) => Meeting.fromJson(e as Map<String, dynamic>))
          .toList(),
      meetingResults: (json['meeting_results'] as List<dynamic>?)
          ?.map((e) => MeetingResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
