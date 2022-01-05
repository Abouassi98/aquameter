import 'response.dart';

class Data {
  Response? response;

  Data({this.response});

  factory Data.fromCode422DataResponseAreaTheAreaFieldIsRequired(
      Map<String, dynamic> json) {
    return Data(
      response: json['response'] == null
          ? null
          : Response.fromCode422DataResponseAreaTheAreaFieldIsRequired(
              json['response'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toCode422DataResponseAreaTheAreaFieldIsRequired() => {
        'response': response?.toCode422DataResponseAreaTheAreaFieldIsRequired(),
      };
}
