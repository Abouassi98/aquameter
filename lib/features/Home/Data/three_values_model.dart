class ThreeValuesModel {
  int? code;
  String? message;
  Data? data;

  ThreeValuesModel({this.code, this.message, this.data});

  ThreeValuesModel.fromJson(Map<String, dynamic> json) {
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
  num? fishWieght;
  num? totalFeed;
  num? conversionRate;

  Data({this.fishWieght, this.totalFeed, this.conversionRate});

  Data.fromJson(Map<String, dynamic> json) {
    fishWieght = json['fish_wieght'];
    totalFeed = json['total_feed'];
    conversionRate = json['conversion_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fish_wieght'] = fishWieght;
    data['total_feed'] = totalFeed;
    data['conversion_rate'] = conversionRate;
    return data;
  }
}
