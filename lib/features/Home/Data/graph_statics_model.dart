class GraphStaticsModel {
  int? code;
  String? message;
  GraphStatics? data;

  GraphStaticsModel({this.code, this.message, this.data});

  factory GraphStaticsModel.fromJson(Map<String, dynamic> json) {
    return GraphStaticsModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : GraphStatics.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class GraphStatics {
  List<Governorate> governorate;
  List<Type> type;

  GraphStatics({required this.governorate, required this.type});

  factory GraphStatics.fromJson(Map<String, dynamic> json) {
    return GraphStatics(
      governorate: (json['governorate'] as List<dynamic>)
          .map((e) => Governorate.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: (json['type'] as List<dynamic>)
          .map((e) => Type.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Governorate {
  int? governorate;
  String? names;
  int? total;

  Governorate({this.governorate, this.names, this.total});

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      governorate: json['governorate'] as int?,
      names: json['names'] as String?,
      total: json['total'] as int?,
    );
  }
}

class Type {
  String? name;
  int? clientCount;

  Type({this.name, this.clientCount});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      name: json['name'] as String?,
      clientCount: json['client_count'] as int?,
    );
  }
}
