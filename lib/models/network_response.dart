enum Status { success, loading, error, timeout, internetError }

class NetworkResponse {
  final Status status;
  final Map<String, dynamic>? data;
  final String? message;

  NetworkResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  static NetworkResponse success(data) {
    return NetworkResponse(
      status: Status.success,
      data: data,
      message: null,
    );
  }
  
  static NetworkResponse error(data, message) {
    return NetworkResponse(
      status: Status.error,
      data: data,
      message: message,
    );
  }
  
  static NetworkResponse internetError() {
    return NetworkResponse(
      status: Status.internetError,
      data: null,
      message: null,
    );
  }
}
