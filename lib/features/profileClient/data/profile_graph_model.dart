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
  List<num>? ammonia;
  List<num>? avrageWeight;
  List<int>? totalNumber;
  List<num>? conversionRate;
  List<int>? numberOfDead;
  List<int>? id;

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
      ammonia: json['ammonia'] as List<double>?,
      avrageWeight: json['avrage_weight'] as List<num>?,
      totalNumber: json['total_number'] as List<int>?,
      conversionRate: json['conversion_rate'] as List<double>?,
      numberOfDead: json['number_of_dead'] as List<int>?,
      id: json['id'] as List<int>?,
    );
  }
}
