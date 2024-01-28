import 'package:dio/dio.dart';
import 'package:weather_app/core/api/api_calls/api_calls_interface.dart';

class ApiCallsImpl implements ApiCallsI {
  final Dio _dio;

  ApiCallsImpl(this._dio);

  @override
  Future<ApiResponse> get(String url, {ApiOptions? options}) async {
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: options?.headers,
        ),
        queryParameters: options?.queryParameters,
      );
      return ApiResponse(
        statusCode: getStatusCode(response.statusCode ?? -1),
        data: response.data,
        error: response.statusMessage,
      );
    } on DioException catch (_) {
      return ApiResponse.error('Failed to send request');
    }
  }

  @override
  Future<ApiResponse> delete(String url, {ApiOptions? options}) async {
    try {
      final response = await _dio.delete(
        url,
        options: Options(
          headers: options?.headers,
        ),
        queryParameters: options?.queryParameters,
      );
      return ApiResponse(
        statusCode: getStatusCode(response.statusCode ?? -1),
        data: response.data,
        error: response.statusMessage,
      );
    } on DioException catch (_) {
      return ApiResponse.error('Failed to send request');
    }
  }

  @override
  Future<ApiResponse> post(String url, ApiOptionsWithBody options) async {
    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: options.headers,
        ),
        queryParameters: options.queryParameters,
        data: options.body,
      );
      return ApiResponse(
        statusCode: getStatusCode(response.statusCode ?? -1),
        data: response.data,
        error: response.statusMessage,
      );
    } on DioException catch (_) {
      return ApiResponse.error('Failed to send request');
    }
  }

  @override
  Future<ApiResponse> put(String url, ApiOptionsWithBody options) async {
    try {
      final response = await _dio.put(
        url,
        options: Options(
          headers: options.headers,
        ),
        queryParameters: options.queryParameters,
        data: options.body,
      );
      return ApiResponse(
        statusCode: getStatusCode(response.statusCode ?? -1),
        data: response.data,
        error: response.statusMessage,
      );
    } on DioException catch (_) {
      return ApiResponse.error('Failed to send request');
    }
  }
}
