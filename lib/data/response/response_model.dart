class ResponseModel<T> {
  final String status;
  final String message;
  final T data;

  ResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json['status'] ?? 'unknown',
      message: json['message'],
      data: json['data'],
    );
  }
}