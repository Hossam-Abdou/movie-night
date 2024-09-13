class DeleteRateModel {
  DeleteRateModel({
      this.success, 
      this.statusCode, 
      this.statusMessage,});

  DeleteRateModel.fromJson(dynamic json) {
    success = json['success'];
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
  }
  bool? success;
  int? statusCode;
  String? statusMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status_code'] = statusCode;
    map['status_message'] = statusMessage;
    return map;
  }

}