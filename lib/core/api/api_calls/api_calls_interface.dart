abstract class ApiCallsI {
  //get
  Future<ApiResponse> get(String url, {ApiOptions? options});

  //post
  Future<ApiResponse> post(String url, ApiOptionsWithBody options);

  //put
  Future<ApiResponse> put(String url, ApiOptionsWithBody options);

  //delete
  Future<ApiResponse> delete(String url, {ApiOptions? options});
}

class ApiOptions {
  Map<String, dynamic>? queryParameters;
  Map<String, dynamic>? headers;
  ApiOptions({this.queryParameters, this.headers});
}

class ApiOptionsWithBody extends ApiOptions {
  Object body;
  ApiOptionsWithBody({required this.body, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) : super() {
    this.queryParameters = queryParameters;
    this.headers = headers;
  }
}

enum StatusCode {
  success,
  error,
  unAuthorized,
  notFound,
  badRequest,
  internalServerError,
  serviceUnavailable,
  gatewayTimeout,
  unknownError
}

class ApiResponse {
  final StatusCode statusCode;
  final dynamic data;
  final String? error;

  ApiResponse({
    required this.data,
    this.error,
    required this.statusCode,
  });

  factory ApiResponse.success(dynamic data) {
    return ApiResponse(data: data, statusCode: StatusCode.success);
  }

  factory ApiResponse.error(String error) {
    return ApiResponse(error: error, statusCode: StatusCode.error, data: {});
  }
}
StatusCode getStatusCode(int statusCode) {
  switch (statusCode) {
    case 200:
      return StatusCode.success;
    case 400:
      return StatusCode.badRequest;
    case 401:
      return StatusCode.unAuthorized;
    case 404:
      return StatusCode.notFound;
    case 500:
      return StatusCode.internalServerError;
    case 503:
      return StatusCode.serviceUnavailable;
    case 504:
      return StatusCode.gatewayTimeout;
    default:
      return StatusCode.unknownError;
  }
}