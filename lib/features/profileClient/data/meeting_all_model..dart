import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';

class MeetingAllModel {
  int? code;
  List<MeetingClient>? data;
  String? message;

  MeetingAllModel({this.code, this.data, this.message});

  factory MeetingAllModel.fromJson(Map<String, dynamic> json) {
    return MeetingAllModel(
      code: json['code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MeetingClient.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
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
  num? feed;
  int? deadFish;
  String? notes;
  dynamic totalNumber;
  double? toxicAmmonia;
  String? realDate;

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
    );
  }
}

class MeetingClient {
  int? id;
  String? meeting;
  int? clientId;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? periodId;
  List<MeetingResult>? meetingResult;
  Client? client;

  MeetingClient({
    this.id,
    this.meeting,
    this.clientId,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.periodId,
    this.meetingResult,
    this.client,
  });

  factory MeetingClient.fromJson(Map<String, dynamic> json) {
    return MeetingClient(
      id: json['id'] as int?,
      meeting: json['meeting'] as String?,
      clientId: json['client_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      userId: json['user_id'] as int?,
      periodId: json['period_id'] as int?,
      meetingResult: (json['meeting_result'] as List<dynamic>?)
          ?.map((e) => MeetingResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      client: json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
    );
  }
}
