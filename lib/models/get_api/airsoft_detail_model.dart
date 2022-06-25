import 'package:tugas_akhir_stenly_rachmad/models/get_api/result_airsoft_model.dart';

class AirsoftDetailModel {
  bool? success;
  ResultsAirsoftModel? data;
  String? message;

  AirsoftDetailModel({this.success, this.data, this.message});

  AirsoftDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? new ResultsAirsoftModel.fromJson(json['data'])
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
