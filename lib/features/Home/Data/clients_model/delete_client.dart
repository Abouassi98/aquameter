class DeleteClientModel {
	int? code;
	String? message;

	DeleteClientModel({this.code, this.message});

	factory DeleteClientModel.fromJson(Map<String, dynamic> json) {
		return DeleteClientModel(
			code: json['code'] as int?,
			message: json['message'] as String?,
		);
	}



	
}
