class ProfileGraphModel {
  int? code;
  String? message;
  Graph? data;

  ProfileGraphModel({this.code, this.message, this.data});

  factory ProfileGraphModel.fromJson(Map<String, dynamic> json) {
    return ProfileGraphModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Graph.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class Graph {
  List<dynamic>? toxicAmmonia;
  List<dynamic>? temperature;
  List<dynamic>? ph;
  List<dynamic>? salinity;
  List<dynamic>? oxygen;
  List<dynamic>? ammonia;
  List<dynamic>? avrageWeight;
  List<dynamic>? totalNumber;
  List<dynamic>? conversionRate;
  List<dynamic>? numberOfDead;
  List<dynamic>? id;

  Graph({
    this.temperature,
    this.ph,
    this.salinity,
    this.oxygen,
    this.toxicAmmonia,
    this.ammonia,
    this.avrageWeight,
    this.totalNumber,
    this.conversionRate,
    this.numberOfDead,
    this.id,
  });

  factory Graph.fromJson(Map<String, dynamic> json) {
    return Graph(
      oxygen: json['oxygen'] as List<dynamic>?,
      ph: json['ph'] as List<dynamic>?,
      salinity: json['salinity'] as List<dynamic>?,
      temperature: json['temperature'] as List<dynamic>?,
      toxicAmmonia: json['toxic_ammonia'] as List<dynamic>?,
      ammonia: json['ammonia'] as List<dynamic>?,
      avrageWeight: json['avrage_weight'] as List<dynamic>?,
      totalNumber: json['total_number'] as List<dynamic>?,
      conversionRate: json['conversion_rate'] as List<dynamic>?,
      numberOfDead: json['number_of_dead'] as List<dynamic>?,
      id: json['id'] as List<dynamic>?,
    );
  }
}
