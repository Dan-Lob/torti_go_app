class BaseResponseModel<T> {
  final bool success;
  final String message;
  final T? data;
  final DateTime? timestamp;

  BaseResponseModel({
    required this.success,
    required this.message,
    this.data,
    this.timestamp,
  });

  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromDataJson,
  ) {
    return BaseResponseModel<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: fromDataJson != null ? fromDataJson(json['data']) : null,
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'])
          : null,
    );
  }
}
