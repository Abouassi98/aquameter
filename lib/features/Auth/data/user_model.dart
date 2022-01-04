class UserModel {
  bool? success;
  String? token, message;
  Data? data;
  Clients? clients;

  UserModel({this.success, this.token, this.data, this.clients, this.message});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        success: json['success'] as bool?,
        token: json['token'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        clients: json['clients'] == null
            ? null
            : Clients.fromJson(json['clients'] as Map<String, dynamic>),
        message: json['message'] as String?);
  }
}

class Data {
  int? id;
  String? name, phone, email;

  List<Client>? clients;

  Data({this.id, this.name, this.phone, this.email, this.clients});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      clients: (json['clients'] as List<dynamic>?)
          ?.map((e) => Client.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Clients {
  int? fishWieght, totalFeed, conversionRate;

  Clients({this.fishWieght, this.totalFeed, this.conversionRate});

  factory Clients.fromJson(Map<String, dynamic> json) {
    return Clients(
      fishWieght: json['fish_wieght'] as int?,
      totalFeed: json['total_feed'] as int?,
      conversionRate: json['conversion_rate'] as int?,
    );
  }
}

class Client {
  int? id,
      phone,
      governorate,
      area,
      startingWeight,
      targetWeight,
      userId,
      landSize;
  String? name, address, landSizeType, createdAt, updatedAt;

  dynamic ammonia,
      avrageWeight,
      totalNumber,
      conversionRate,
      numberOfDead,
      lat,
      long,
      totalFeed;

  Client({
    this.id,
    this.name,
    this.phone,
    this.governorate,
    this.area,
    this.address,
    this.landSize,
    this.landSizeType,
    this.startingWeight,
    this.targetWeight,
    this.createdAt,
    this.updatedAt,
    this.ammonia,
    this.avrageWeight,
    this.totalNumber,
    this.conversionRate,
    this.numberOfDead,
    this.lat,
    this.long,
    this.userId,
    this.totalFeed,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as int?,
      governorate: json['governorate'] as int?,
      area: json['area'] as int?,
      address: json['address'] as String?,
      landSize: json['land_size'] as int?,
      landSizeType: json['land_size_type'] as String?,
      startingWeight: json['starting_weight'] as int?,
      targetWeight: json['target_weight'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      ammonia: json['ammonia'] as dynamic,
      avrageWeight: json['avrage_weight'] as dynamic,
      totalNumber: json['total_number'] as dynamic,
      conversionRate: json['conversion_rate'] as dynamic,
      numberOfDead: json['number_of_dead'] as dynamic,
      lat: json['lat'] as dynamic,
      long: json['long'] as dynamic,
      userId: json['user_id'] as int?,
      totalFeed: json['total_feed'] as dynamic,
    );
  }
}
