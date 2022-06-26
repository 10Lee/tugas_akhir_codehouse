import 'dart:io';

import 'package:get/get_connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_stenly_rachmad/config/flutter_config.dart';
import 'package:tugas_akhir_stenly_rachmad/config/logger.dart';
import 'package:tugas_akhir_stenly_rachmad/models/delete_model.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/airsoft_detail_model.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/airsoft_model.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/detail_transaction_model.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/transaction_model.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/update_model.dart';
import 'package:tugas_akhir_stenly_rachmad/models/post_api/add_airsoft_model.dart';
import 'package:tugas_akhir_stenly_rachmad/models/post_api/add_transaction_model.dart';
import 'package:tugas_akhir_stenly_rachmad/models/post_api/auth_model.dart';
import 'package:tugas_akhir_stenly_rachmad/models/post_api/res_add_transaction_model.dart';

import 'interceptor.dart';

class Repository extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    allowAutoSignedCert = true;
    httpClient.baseUrl = FlavorConfig.instance.baseUrl;
    httpClient.timeout = const Duration(milliseconds: 40000);
    httpClient.addRequestModifier((request) => requestInterceptor(request));
    httpClient.addResponseModifier(
        (request, response) => responseInterceptor(request, response));
  }

  Future<AuthModel> registerUser({
    required String email,
    required String name,
    required String password,
  }) async {
    late AuthModel? authRes;
    try {
      final response = await post(
        '/auth/register',
        {
          'email': email,
          'name': name,
          'password': password,
        },
      );
      authRes = AuthModel.fromJson(response.body);
    } catch (error, stackTrace) {
      logger.e('registerHasError', error, stackTrace);
    }
    return authRes!;
  }

  Future<AuthModel> loginUser({
    required String email,
    required String password,
  }) async {
    late AuthModel? authRes;
    try {
      final response = await post(
        '/auth/login',
        {
          'email': email,
          'password': password,
        },
      );
      authRes = AuthModel.fromJson(response.body);
      print("RESONSE LOGIN : ${response.body}");
      return authRes;
    } catch (error, stackTrace) {
      logger.e('loginHasError', error, stackTrace);

      throw Exception();
    }
  }

  Future<AirsoftModel> getAirsoftList(int page) async {
    // late AirsoftModel airsoftModel;
    try {
      final response = await get('/airsoft', query: {'page': '$page'});
      print("/AIRSOFT RESPONSE : ${response.body}");
      return AirsoftModel.fromJson(response.body);
    } catch (error, stackTrace) {
      logger.e('getAirsoftListHasError', error, stackTrace);
      print(error.toString());
      print(stackTrace.toString());
      throw Exception();
    }
    // return airsoftModel;
  }

  Future<AirsoftDetailModel> getAirsoftDetail(int id) async {
    late AirsoftDetailModel airsoftModel;
    try {
      final response = await get('/airsoft/${id}');
      airsoftModel = AirsoftDetailModel.fromJson(response.body);
    } catch (error, stackTrace) {
      logger.e('getAirsoftListHasError', error, stackTrace);
    }
    return airsoftModel;
  }

  Future<PostModel> postData({
    required String name,
    required int price,
    required String description,
    required File file,
  }) async {
    final form = FormData({
      'name': name,
      'price': price,
      'description': description,
      'file': MultipartFile(file, filename: file.path.split('/').last),
    });

    Response response = await post('/airsoft/add', form);

    logger.i('RESPONSE BODY : ${response.body}');
    if (response.body != null) {
      return PostModel.fromMap(response.body);
    } else {
      throw Exception();
    }
  }

  Future<DeleteModel> deleteData(int id) async {
    late DeleteModel dataRes;
    try {
      logger.i('TOKEN : ${GetStorage().read('auth')['token']}');

      Response response = await delete('/airsoft/delete/$id');

      logger.i('RESPONSE BODY : ${response.body}');
      if (response.body != null) {
        dataRes = DeleteModel.fromMap(response.body);
      }
    } catch (e) {
      logger.e(e.toString());
    }
    return dataRes;
  }

  Future<UpdateModel> updateData({
    required int id,
    required String name,
    required int price,
    required String description,
    required File file,
  }) async {
    dynamic form;

    if (file.path != '') {
      form = FormData({
        'id': id,
        'name': name,
        'price': price,
        'description': description,
        'file': MultipartFile(file, filename: file.path.split('/').last),
      });
    } else {
      form = FormData({
        'id': id,
        'name': name,
        'price': price,
        'description': description,
      });
    }

    Response response = await post('/airsoft/update', form);

    print('RESPONSE BODY : ${response.body}');
    if (response.body != null) {
      return UpdateModel.fromMap(response.body);
    } else {
      throw Exception();
    }
  }

  Future<Transaction> getAllTransactionData(int page) async {
    late Transaction listOfTransaction;

    try {
      Response response = await get('/transaction', query: {'page': '$page'});
      listOfTransaction = Transaction.fromJson(response.body);
    } catch (e, stackTrace) {
      logger.e('GetAllTransactionDataHasError', e, stackTrace);
      print(e.toString());
      print(stackTrace.toString());
    }
    return listOfTransaction;
  }

  Future<DetailTransactionModel> getDetailTransactionData(int id) async {
    late DetailTransactionModel detailTransactionModel;
    try {
      Response response = await get('/transaction/${id.toString()}');
      if (response.body.isNotEmpty) {
        detailTransactionModel = DetailTransactionModel.fromJson(response.body);
      }
    } catch (e, stackTrace) {
      logger.e(e.toString());
      logger.e(stackTrace.toString());
    }

    return detailTransactionModel;
  }

  Future<ResAddTransactionModel> postTransaction(
      {required List<Items> items}) async {
    late ResAddTransactionModel resAddTransactionModel;

    try {
      final form = {'items': items.map((Items e) => e.toJson()).toList()};

      Response response = await post('/transaction', form);
      if (response.body != null) {
        resAddTransactionModel = ResAddTransactionModel.fromJson(response.body);
      } else {
        throw Exception();
      }
    } catch (e, stackTrace) {
      logger.e(e.toString());
      logger.e(stackTrace.toString());
    }
    return resAddTransactionModel;
  }
}
