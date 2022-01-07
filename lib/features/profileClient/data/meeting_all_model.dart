import 'package:aquameter/features/Home/Data/home_clients_model/home_clients_model.dart';

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
