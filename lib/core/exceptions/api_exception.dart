class ApiException implements Exception {
  final String message;
  final String? code;
  final String? path;

  ApiException({
    required this.message,
    this.code,
    this.path,
  });

  @override
  String toString() =>
      'ApiException: $message (${code ?? 'SIN_CODIGO'}) en ${path ?? 'ruta desconocida'}';
}