class UserModel {
  User? user;
  bool? authanticated;
  String? token;
  bool? success;
  Errors? errors;
  Msgs? msg;
  UserModel(
      {this.user,
      this.authanticated,
      this.token,
      this.success,
      this.errors,
      this.msg});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      authanticated: json['authanticated'] as bool?,
      token: json['token'] as String?,
      success: json['success'] as bool?,
      errors: json['errors'] == null
          ? null
          : Errors.fromJson(json['errors'] as Map<String, dynamic>),
      msg: json['msgs'] == null
          ? null
          : Msgs.fromJson(json['msgs'] as Map<String, dynamic>),
    );
  }
}

class User {
  String role, id, password, username, phone, email;
  List<dynamic>? notifications;
  String? img;
  int? stock, v;

  dynamic resetToken;
  User({
    required this.role,
    this.notifications,
    this.img,
    this.stock,
    required this.id,
    required this.password,
    required this.username,
    required this.phone,
    required this.email,
    this.v,
    this.resetToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      role: json['role'] as String,
      notifications: json['notifications'] as List<dynamic>?,
      img: json['img'] as String?,
      stock: json['stock'] as int?,
      id: json['_id'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      v: json['__v'] as int?,
    );
  }
}

class Errors {
  Msgs msgs;
  String? error;
  Errors({required this.msgs, this.error});
  factory Errors.fromJson(Map<String, dynamic> json) {
    return Errors(
        msgs: Msgs.fromJson(json['msgs'] as Map<String, dynamic>),
        error: json['error']);
  }
}

class Msgs {
  String ar, eng, kur;
  Msgs({required this.ar, required this.eng, required this.kur});

  factory Msgs.fromJson(Map<String, dynamic> json) {
    return Msgs(
      ar: json['ar'] as String,
      eng: json['eng'] as String,
      kur: json['kur'] as String,
    );
  }
}
