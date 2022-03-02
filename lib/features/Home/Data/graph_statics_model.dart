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
  List<Governorate>? governorate;
  List<Fishes>? fishes;

  GraphStatics({this.governorate, this.fishes});

  factory GraphStatics.fromJson(Map<String, dynamic> json) {
    return GraphStatics(
      governorate: (json['governorate'] as List<dynamic>?)
          ?.map((e) => Governorate.fromJson(e as Map<String, dynamic>))
          .toList(),
      fishes: (json['type'] as List<dynamic>?)
          ?.map((e) => Fishes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Governorate {
  int? id;
  String? names;
  dynamic parentId;
  String? type;
  dynamic status;
  int? clientsCount;

  Governorate({
    this.id,
    this.names,
    this.parentId,
    this.type,
    this.status,
    this.clientsCount,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      id: json['id'] as int?,
      names: json['names'] as String?,
      parentId: json['parent_id'] as dynamic,
      type: json['type'] as String?,
      status: json['status'] as dynamic,
      clientsCount: json['clients_count'] as int?,
    );
  }
}

class Fishes {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? image;
  int? fishesSumNumber;

  Fishes({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.fishesSumNumber,
  });

  factory Fishes.fromJson(Map<String, dynamic> json) {
    return Fishes(
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      image: json['image'] as String?,
      fishesSumNumber: json['fishes_sum_number'] as int?,
    );
  }
}
