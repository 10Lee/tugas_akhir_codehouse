import 'data_airsoft_model.dart';

class AirsoftModel {
  bool? success;
  DataAirsoftModel? data;
  String? message;

  AirsoftModel({this.success, this.data, this.message});

  AirsoftModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? new DataAirsoftModel.fromJson(json['data'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}
