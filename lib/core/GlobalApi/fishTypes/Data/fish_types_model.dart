class FishTypesModel {
  int? code;
  String? message;
  List<FishType>? data;

  FishTypesModel({this.code, this.message, this.data});

  factory FishTypesModel.fromJson(Map<String, dynamic> json) {
    return FishTypesModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FishType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class FishType {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? photo;

  FishType({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.photo,
  });

  factory FishType.fromJson(Map<String, dynamic> json) {
    return FishType(
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      image: json['image'] as String?,
      photo: json['photo'] as String?,
    );
  }
}
