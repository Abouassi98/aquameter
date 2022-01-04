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

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'token': token,
      'data': data?.toJson(),
      'clients': clients?.toJson(),
      'message': message
    };
  }
}

class Data {
  int? id;
  String? name;
  String? phone;
  String? email;

  Data({this.id, this.name, this.phone, this.email});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}

class Clients {
  int? fishWieght;
  int? totalFeed;
  int? conversionRate;

  Clients({this.fishWieght, this.totalFeed, this.conversionRate});

  factory Clients.fromJson(Map<String, dynamic> json) {
    return Clients(
      fishWieght: json['fish_wieght'] as int?,
      totalFeed: json['total_feed'] as int?,
      conversionRate: json['conversion_rate'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fish_wieght': fishWieght,
      'total_feed': totalFeed,
      'conversion_rate': conversionRate,
    };
  }
}
