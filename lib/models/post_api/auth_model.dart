import 'package:tugas_akhir_stenly_rachmad/models/post_api/data_auth_model.dart';

class AuthModel {
  bool? success;
  DataAuthModel? data;
  String? message;

  AuthModel({this.success, this.data, this.message});

  AuthModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? new DataAuthModel.fromJson(json['data']) : null;
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
