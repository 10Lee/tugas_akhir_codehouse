import 'package:tugas_akhir_stenly_rachmad/models/get_api/result_airsoft_model.dart';

class DataAirsoftModel {
  List<ResultsAirsoftModel>? results;
  int? total;

  DataAirsoftModel({this.results, this.total});

  DataAirsoftModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ResultsAirsoftModel>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAirsoftModel.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}
