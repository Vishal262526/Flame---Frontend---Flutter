class ResponseData {
  final int status;
  final bool success;
  final String message;

  ResponseData({
    required this.status,
    required this.message,
    required this.success,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      status: json['status'] as int,
      message: json['message'] as String,
      success: json['success'] as bool,
    );
  }
}
