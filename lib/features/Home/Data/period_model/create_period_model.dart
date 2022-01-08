
class CreatePeriodModel {
	int? code;
	String? message;
	PeriodData? data;

	CreatePeriodModel({this.code, this.message, this.data});

	factory CreatePeriodModel.fromJson(Map<String, dynamic> json) {
		return CreatePeriodModel(
			code: json['code'] as int?,
			message: json['message'] as String?,
			data: json['data'] == null
						? null
						: PeriodData.fromJson(json['data'] as Map<String, dynamic>),
		);
	}




}
class PeriodData {
	String? mceeting;
	int? clientId;
	int? userId;
	String? updatedAt;
	String? createdAt;
	int? id;

	PeriodData({
		this.mceeting, 
		this.clientId, 
		this.userId, 
		this.updatedAt, 
		this.createdAt, 
		this.id, 
	});

	factory PeriodData.fromJson(Map<String, dynamic> json) {
		return PeriodData(
			mceeting: json['mceeting'] as String?,
			clientId: json['client_id'] as int?,
			userId: json['user_id'] as int?,
			updatedAt: json['updated_at'] as String?,
			createdAt: json['created_at'] as String?,
			id: json['id'] as int?,
		);
	}



}
