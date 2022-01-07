

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
class MeetingClient {
  int? id;
  String? meeting;
  int? clientId;
  String? createdAt;
  String? updatedAt;
  int? userId;
  Client? client;

  MeetingClient({
    this.id,
    this.meeting,
    this.clientId,
    this.createdAt,
    this.updatedAt,
    this.userId,
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
      client: json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
    );
  }
}