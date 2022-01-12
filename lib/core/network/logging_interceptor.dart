import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(
      "--> ${options.method.toUpperCase()} ${(options.baseUrl) + options.path}",
    );

    print("Headers:");
    options.headers.forEach(
      (k, v) => print('$k: $v'),
    );

    print("queryParameters:");
    options.queryParameters.forEach(
      (k, v) => print('$k: $v'),
    );

    if (options.data != null) {
      print("Body: ${options.data}");
    }

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print(
      "<-- ${response.statusCode} ${response.requestOptions.baseUrl + response.requestOptions.path}",
    );

    print("Headers:");
    response.headers.forEach(
      (k, v) => print('$k: $v'),
    );

    print("Response: ${response.data}");
    print("<-- END HTTP");
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError dioError, ErrorInterceptorHandler handler) async {
    print(
      'ERROR[${dioError.response?.statusCode}] => PATH: ${dioError.requestOptions.path}',
    );

    print(
      "<-- ${dioError.message} ${(dioError.response?.requestOptions != null ? (dioError.response!.requestOptions.baseUrl + dioError.response!.requestOptions.path) : 'URL')}",
    );

    print(
      "${dioError.response != null ? dioError.response!.data : 'Unknown Error'}",
    );

    print("<-- End error");

    return super.onError(dioError, handler);
  }
}