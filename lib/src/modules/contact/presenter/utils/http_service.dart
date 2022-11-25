import 'package:dio/dio.dart';

abstract class IHttpService {
  Future<dynamic> get(final String url);

  Future<dynamic> post(final String url,
      {final Map<String, dynamic> headers, final Map<String, dynamic> data});
}

class DioClient implements IHttpService {
  final Dio dio;

  DioClient(this.dio);

  @override
  Future get(final String url) async => (await dio.get(url)).data;

  @override
  Future post(final String url,
          {final Map<String, dynamic>? headers,
          final Map<String, dynamic>? data}) async =>
      (await dio.post(url, options: Options(headers: headers), data: data))
          .data;
}
