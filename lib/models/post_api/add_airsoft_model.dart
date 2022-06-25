import 'package:tugas_akhir_stenly_rachmad/models/get_api/result_airsoft_model.dart';

class PostModel {
  late String message;
  late bool success;
  late ResultsAirsoftModel data;

  PostModel({
    required this.message,
    required this.success,
    required this.data,
  });

  PostModel.fromMap(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];

    if (json['data'] != null) {
      data = ResultsAirsoftModel.fromJson(json['data']);
    }
  }
}
