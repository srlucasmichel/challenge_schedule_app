import 'package:dio/dio.dart';

abstract class IHttpService {
  Future<dynamic> get(String url);

  Future<dynamic> post(String url,
      {Map<String, dynamic> headers, Map<String, dynamic> data});
}

class DioClient implements IHttpService {
  final Dio dio;

  DioClient(this.dio);

  @override
  Future get(String url) async => (await dio.get(url)).data;

  @override
  Future post(String url,
          {Map<String, dynamic>? headers, Map<String, dynamic>? data}) async =>
      (await dio.post(url, options: Options(headers: headers), data: data)).data;
}
