
class CreateMettingModel {
	int? code;
	Data? data;

	CreateMettingModel({this.code, this.data});

	factory CreateMettingModel.fromJson(Map<String, dynamic> json) {
		return CreateMettingModel(
			code: json['code'] as int?,
			data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
		);
	}




}
class Data {
	String? meeting;
	int? clientId;
	int? userId;
	String? updatedAt;
	String? createdAt;
	int? id;

	Data({
		this.meeting, 
		this.clientId, 
		this.userId, 
		this.updatedAt, 
		this.createdAt, 
		this.id, 
	});

	factory Data.fromJson(Map<String, dynamic> json) {
		return Data(
			meeting: json['meeting'] as String?,
			clientId: json['client_id'] as int?,
			userId: json['user_id'] as int?,
			updatedAt: json['updated_at'] as String?,
			createdAt: json['created_at'] as String?,
			id: json['id'] as int?,
		);
	}



	
}
