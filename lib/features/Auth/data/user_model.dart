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

  Data({
    this.id,
    this.name,
    this.phone,
    this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
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
