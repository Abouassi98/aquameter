import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';

class AddClientModel {
  int? code;
  String? message;
  Client? data;

  AddClientModel({this.code, this.message, this.data});

  factory AddClientModel.fromJson(Map<String, dynamic> json) {
    return AddClientModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Client.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
