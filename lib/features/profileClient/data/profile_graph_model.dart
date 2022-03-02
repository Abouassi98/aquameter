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
  List<dynamic>? ammonia;
  List<dynamic>? avrageWeight;
  List<dynamic>? totalNumber;
  List<dynamic>? conversionRate;
  List<dynamic>? numberOfDead;
  List<dynamic>? id;

  Graph({
    this.ammonia,
    this.avrageWeight,
    this.totalNumber,
    this.conversionRate,
    this.numberOfDead,
    this.id,
  });

  factory Graph.fromJson(Map<String, dynamic> json) {
    return Graph(
      ammonia: json['ammonia'] as List<dynamic>?,
      avrageWeight: json['avrage_weight'] as List<dynamic>?,
      totalNumber: json['total_number'] as List<dynamic>?,
      conversionRate: json['conversion_rate'] as List<dynamic>?,
      numberOfDead: json['number_of_dead'] as List<dynamic>?,
      id: json['id'] as List<dynamic>?,
    );
  }
}
