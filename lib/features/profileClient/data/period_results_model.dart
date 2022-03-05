class PeriodResultsModel {
  int? code;
  List<PeriodResults>? data;
  String? message;

  PeriodResultsModel({this.code, this.data, this.message});

  factory PeriodResultsModel.fromJson(Map<String, dynamic> json) {
    return PeriodResultsModel(
      code: json['code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PeriodResults.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );
  }
}

class PeriodResults {
  int? id;
  int? meetingId;
  double? temperature;
  double? ph;
  double? salinity;
  double? oxygen;
  double? ammonia;
  num? averageWeight;
  double? totalWeight;
  double? conversionRate;
  String? createdAt;
  String? updatedAt;
  num? feed;
  int? deadFish;
  String? notes;
  int? totalNumber;
  double? toxicAmmonia;
  String? realDate;
  int? clientId;
  int? periodId;

  PeriodResults({
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

  factory PeriodResults.fromJson(Map<String, dynamic> json) {
    return PeriodResults(
      id: json['id'] as int?,
      meetingId: json['meeting_id'] as int?,
      temperature: (json['temperature'] as num?)?.toDouble(),
      ph: (json['ph'] as num?)?.toDouble(),
      salinity: (json['salinity'] as num?)?.toDouble(),
      oxygen: (json['oxygen'] as num?)?.toDouble(),
      ammonia: (json['ammonia'] as num?)?.toDouble(),
      averageWeight: (json['average_weight'] as num?)?.toDouble(),
      totalWeight: (json['total_weight'] as num?)?.toDouble(),
      conversionRate: (json['conversion_rate'] as num?)?.toDouble(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      feed:( json['feed']as num?)?.toDouble(),
      deadFish: json['dead_fish'] as int?,
      notes: json['notes'] as String?,
      totalNumber: json['total_number'] as int?,
      toxicAmmonia: (json['toxic_ammonia'] as num?)?.toDouble(),
      realDate: json['real_date'] as String?,
      clientId: json['client_id'] as int?,
      periodId: json['period_id'] as int?,
    );
  }
}
