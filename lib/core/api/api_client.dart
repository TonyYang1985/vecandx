import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../services/storage_service.dart';

final baseUrl = 'http://localhost:6060/api';

class ApiClient {
  final StorageService storageService;
  Dio _client = Dio();

  ApiClient({required this.storageService}) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      // queryParameters: {'key': this.dotEnv.env['API_KEY']},
      headers: {'Content-Type': 'application/json'},
    );
    _client = Dio(options);
  }

  Map<String, dynamic> _getAuthHeaders() {
    var token = storageService.accessToken;
    if (token != null) {
      return {'Authorization': 'Bearer $token'};
    }
    return {};
  }

  Future<Response<T>> get<T>(String url, {required Map<String, dynamic> queryParameters, Options? options}) {
    if (options != null) {
      options.headers = _getAuthHeaders();
    } else {
      options = Options(headers: _getAuthHeaders());
    }
    return _client.get<T>(
      url,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<dynamic>> downloadFile(
    String url,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Function(int received, int total)? onReceiveProgress,
    Options? options,
    bool deleteOnError = true,
  }) {
    if (options != null) {
      options.headers = _getAuthHeaders();
    } else {
      options = Options(headers: _getAuthHeaders());
    }
    return _client.download(
      url,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      options: options,
      deleteOnError: true,
    );
  }

  Future<Response<T>> post<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
  }) {
    var options = Options(headers: _getAuthHeaders());
    return _client.post<T>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> put<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
  }) {
    var options = Options(headers: _getAuthHeaders());
    return _client.put<T>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> patch<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
  }) {
    var options = Options(headers: _getAuthHeaders());
    return _client.patch<T>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
  }) {
    var options = Options(headers: _getAuthHeaders());
    return _client.delete<T>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
