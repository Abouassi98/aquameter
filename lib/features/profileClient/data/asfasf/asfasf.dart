import 'data.dart';

class Asfasf {
  int? code;
  Data? data;

  Asfasf({this.code, this.data});

  factory Asfasf.fromCode422DataResponseAreaTheAreaFieldIsRequired(
      Map<String, dynamic> json) {
    return Asfasf(
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromCode422DataResponseAreaTheAreaFieldIsRequired(
              json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toCode422DataResponseAreaTheAreaFieldIsRequired() => {
        'code': code,
        'data': data?.toCode422DataResponseAreaTheAreaFieldIsRequired(),
      };
}
