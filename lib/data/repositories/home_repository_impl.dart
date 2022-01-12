import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kriya_test_project/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kriya_test_project/core/network/endpoint.dart';
import 'package:kriya_test_project/core/network/dio_module.dart';
import 'package:kriya_test_project/core/network/network_module.dart';
import 'package:kriya_test_project/data/model/home_data_model.dart';
import 'package:kriya_test_project/domain/entities/home_data.dart';
import 'package:kriya_test_project/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends NetworkModule implements HomeRepository {
  HomeRepositoryImpl._();
  Dio get _dio => DioModule.getInstance();

  static HomeRepositoryImpl getInstance() => HomeRepositoryImpl._();
  @override
  Future<Either<Failure, List<HomeData>>> getInitialData() async {
    final response = await getMethod(Endpoint.todos);
    //final result = homeDataFromJson(response);
    return Right(homeDatajson(response));
  }
}

List<HomeDataModel> homeDatajson(List<dynamic>? json) {
  return List<HomeDataModel>.from(json!.map((e) => HomeDataModel.fromJson(e)));
}

List<HomeDataModel> homeDataFromJson(String str) => List<HomeDataModel>.from(
    json.decode(str).map((x) => HomeDataModel.fromJson(x)));
