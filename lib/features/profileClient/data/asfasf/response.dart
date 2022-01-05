class Response {
  List<String>? area;

  Response({this.area});

  factory Response.fromCode422DataResponseAreaTheAreaFieldIsRequired(
      Map<String, dynamic> json) {
    return Response(
      area: json['area'] as List<String>?,
    );
  }

  Map<String, dynamic> toCode422DataResponseAreaTheAreaFieldIsRequired() => {
        'area': area,
      };
}
