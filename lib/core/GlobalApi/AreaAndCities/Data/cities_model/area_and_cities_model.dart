class AreaAndCitiesModel {
  int? code;
  String? message;
  List<Cities>? data;

  AreaAndCitiesModel({this.code, this.message, this.data});

  factory AreaAndCitiesModel.fromJson(Map<String, dynamic> json) {
    return AreaAndCitiesModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Cities.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Cities {
  int? id;
  String? names, type;
  dynamic parentId, status;

  Cities({this.id, this.names, this.parentId, this.type, this.status});

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      id: json['id'] as int?,
      names: json['names'] as String?,
      parentId: json['parent_id'] as dynamic,
      type: json['type'] as String?,
      status: json['status'] as dynamic,
    );
  }
}
