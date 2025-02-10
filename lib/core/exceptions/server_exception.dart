class ServerException implements Exception {
  final int status;
  final String message;

  ServerException({
    this.message = "Something went wrong",
    this.status = 0,
  });
}
