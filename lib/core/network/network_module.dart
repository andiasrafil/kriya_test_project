import 'package:dio/dio.dart';
import 'package:kriya_test_project/core/network/dio_module.dart';

abstract class NetworkModule {
  Dio get _dio => DioModule.getInstance();

  BaseOptions? options;
  final Map<String, String> header = Map();
  final String authorization = "Authorization";

  Future<T> _safeCallApi<T>(Future<Response<T>> call) async {
    final response = await call;
    return response.data!;
  }

  Future<T> getMethod<T>(String endpoint,
      {Map<String, dynamic>? param}) async {
    final response =
        await _safeCallApi(_dio.get(endpoint, queryParameters: param));

    return response;
  }
}
