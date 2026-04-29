import 'package:dio/dio.dart';

class NetworkService {
  NetworkService({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 20),
    Duration receiveTimeout = const Duration(seconds: 20),
    Duration sendTimeout = const Duration(seconds: 20),
    Map<String, dynamic>? defaultHeaders,
    Iterable<Interceptor> interceptors = const <Interceptor>[],
  })
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout,
          sendTimeout: sendTimeout,
          headers: defaultHeaders,
        ),
      ) {
    _dio.interceptors.addAll(interceptors);
  }

  final Dio _dio;

  Dio get client => _dio;

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) {
    return _dio.get<T>(path, queryParameters: query);
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? query,
  }) {
    return _dio.post<T>(path, data: data, queryParameters: query);
  }
}
