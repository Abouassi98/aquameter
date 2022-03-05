import '../../Home/Data/clients_model/client_model.dart';

class ReportModel {
  int? code;
  List<ReportData>? reportData;
  String? message;

  ReportModel({this.code, this.reportData, this.message});

  ReportModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      reportData = <ReportData>[];
      json['data'].forEach((v) {
        reportData!.add(ReportData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class ReportData {
  int? id;
  int? meetingId;
  double? temperature;
  double? ph;
  double? salinity;
  double? oxygen;
  double? ammonia;
  Null? averageWeight;
  double? totalWeight;
  double? conversionRate;
  String? createdAt;
  String? updatedAt;
  int? feed;
  int? deadFish;
  String? notes;
  Null? totalNumber;
  double? toxicAmmonia;
  String? realDate;
  int? clientId;
  int? periodId;
  Client? client;
  Period? period;

  ReportData(
      {this.id,
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
      this.client,
      this.period});

  ReportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meetingId = json['meeting_id'];
    temperature = json['temperature'];
    ph = json['ph'];
    salinity = json['salinity'];
    oxygen = json['oxygen'];
    ammonia = json['ammonia'];
    averageWeight = json['average_weight'];
    totalWeight = json['total_weight'];
    conversionRate = json['conversion_rate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    feed = json['feed'];
    deadFish = json['dead_fish'];
    notes = json['notes'];
    totalNumber = json['total_number'];
    toxicAmmonia = json['toxic_ammonia'];
    realDate = json['real_date'];
    clientId = json['client_id'];
    periodId = json['period_id'];
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    period = json['period'] != null ? Period.fromJson(json['period']) : null;
  }
}

class Period {
  int? id;
  int? status;

  Period({this.id, this.status});

  Period.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    return data;
  }
}
