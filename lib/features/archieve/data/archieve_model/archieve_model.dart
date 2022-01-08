import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';

class ArchieveModel {
  int? code;
  List<ArchieveData>? data;
  String? message;

  ArchieveModel({this.code, this.data, this.message});

  factory ArchieveModel.fromJson(Map<String, dynamic> json) {
    return ArchieveModel(
      code: json['code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ArchieveData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );
  }
}

class ArchieveData {
  int? id;
  String? meeting;
  int? clientId;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? periodId;
  Client? client;

  ArchieveData({
    this.id,
    this.meeting,
    this.clientId,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.periodId,
    this.client,
  });

  factory ArchieveData.fromJson(Map<String, dynamic> json) {
    return ArchieveData(
      id: json['id'] as int?,
      meeting: json['meeting'] as String?,
      clientId: json['client_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      userId: json['user_id'] as int?,
      periodId: json['period_id'] as int?,
      client: json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
    );
  }
}
