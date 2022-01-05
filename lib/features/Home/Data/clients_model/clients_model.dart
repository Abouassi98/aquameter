
class ClientsModel {
	int? code;
	String? message;
	List<Datum>? data;

	ClientsModel({this.code, this.message, this.data});

	factory ClientsModel.fromJson(Map<String, dynamic> json) {
		return ClientsModel(
			code: json['code'] as int?,
			message: json['message'] as String?,
			data: (json['data'] as List<dynamic>?)
						?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
						.toList(),
		);
	}



}
class AreaData {
	int? id;
	String? names;

	AreaData({this.id, this.names});

	factory AreaData.fromJson(Map<String, dynamic> json) {
		return AreaData(
			id: json['id'] as int?,
			names: json['names'] as String?,
		);
	}




}

class Datum {
	int? id;
	String? name;
	int? phone;
	int? governorate;
	int? area;
	String? address;
	int? landSize;
	String? landSizeType;
	int? startingWeight;
	int? targetWeight;
	String? createdAt;
	String? updatedAt;
	dynamic ammonia;
	dynamic avrageWeight;
	dynamic totalNumber;
	dynamic conversionRate;
	dynamic numberOfDead;
	dynamic lat;
	dynamic long;
	int? userId;
	dynamic totalFeed;
	GovernorateData? governorateData;
	AreaData? areaData;

	Datum({
		this.id,
		this.name,
		this.phone,
		this.governorate,
		this.area,
		this.address,
		this.landSize,
		this.landSizeType,
		this.startingWeight,
		this.targetWeight,
		this.createdAt,
		this.updatedAt,
		this.ammonia,
		this.avrageWeight,
		this.totalNumber,
		this.conversionRate,
		this.numberOfDead,
		this.lat,
		this.long,
		this.userId,
		this.totalFeed,
		this.governorateData,
		this.areaData,
	});

	factory Datum.fromJson(Map<String, dynamic> json) {
		return Datum(
			id: json['id'] as int?,
			name: json['name'] as String?,
			phone: json['phone'] as int?,
			governorate: json['governorate'] as int?,
			area: json['area'] as int?,
			address: json['address'] as String?,
			landSize: json['land_size'] as int?,
			landSizeType: json['land_size_type'] as String?,
			startingWeight: json['starting_weight'] as int?,
			targetWeight: json['target_weight'] as int?,
			createdAt: json['created_at'] as String?,
			updatedAt: json['updated_at'] as String?,
			ammonia: json['ammonia'] as dynamic,
			avrageWeight: json['avrage_weight'] as dynamic,
			totalNumber: json['total_number'] as dynamic,
			conversionRate: json['conversion_rate'] as dynamic,
			numberOfDead: json['number_of_dead'] as dynamic,
			lat: json['lat'] as dynamic,
			long: json['long'] as dynamic,
			userId: json['user_id'] as int?,
			totalFeed: json['total_feed'] as dynamic,
			governorateData: json['governorate_data'] == null
					? null
					: GovernorateData.fromJson(json['governorate_data'] as Map<String, dynamic>),
			areaData: json['area_data'] == null
					? null
					: AreaData.fromJson(json['area_data'] as Map<String, dynamic>),
		);
	}



}
class GovernorateData {
	int? id;
	String? names;

	GovernorateData({this.id, this.names});

	factory GovernorateData.fromJson(Map<String, dynamic> json) {
		return GovernorateData(
			id: json['id'] as int?,
			names: json['names'] as String?,
		);
	}



}
