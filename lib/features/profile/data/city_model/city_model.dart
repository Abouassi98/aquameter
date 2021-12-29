class CityModel {
  int? code;
  String? message;
  List<City>? data;

  CityModel({this.code, this.message, this.data});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => City.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class City {
  int? id;
  String? names;
  dynamic parentId;
  String? type;
  dynamic status;

  City({this.id, this.names, this.parentId, this.type, this.status});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as int?,
      names: json['names'] as String?,
      parentId: json['parent_id'] as dynamic,
      type: json['type'] as String?,
      status: json['status'] as dynamic,
    );
  }
}
