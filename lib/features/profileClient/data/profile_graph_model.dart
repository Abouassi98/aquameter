class ProfileGraphModel {
  int? code;
  String? message;
  Data? data;

  ProfileGraphModel({this.code, this.message, this.data});

  factory ProfileGraphModel.fromJson(Map<String, dynamic> json) {
    return ProfileGraphModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class Data {
  List<int>? ammonia;
  List<dynamic>? avrageWeight;
  List<int>? totalNumber;
  List<int>? conversionRate;
  List<dynamic>? numberOfDead;

  Data({
    this.ammonia,
    this.avrageWeight,
    this.totalNumber,
    this.conversionRate,
    this.numberOfDead,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      ammonia: json['ammonia'] as List<int>?,
      avrageWeight: json['avrage_weight'] as List<dynamic>?,
      totalNumber: json['total_number'] as List<int>?,
      conversionRate: json['conversion_rate'] as List<int>?,
      numberOfDead: json['number_of_dead'] as List<dynamic>?,
    );
  }
}
