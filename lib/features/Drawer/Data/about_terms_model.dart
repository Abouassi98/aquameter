class AboutAndTermsModel {
  int? code;
  String? message;
  Data? data;

  AboutAndTermsModel({this.code, this.message, this.data});

  AboutAndTermsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? about;
  String? termsConditions;

  Data({this.about, this.termsConditions});

  Data.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    termsConditions = json['Terms_Conditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['about'] = about;
    data['Terms_Conditions'] = termsConditions;
    return data;
  }
}
