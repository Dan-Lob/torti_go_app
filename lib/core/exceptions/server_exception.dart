// Ruta: lib/core/exceptions/server_exception.dart

import 'package:dio/dio.dart';
import 'api_exception.dart';

class ServerException {
  static ApiException handleDioError(dynamic error) {
    if (error is DioException) {
      final response = error.response;
      final statusCode = response?.statusCode ?? 500;

      final message = response?.data['message'] ??
          'Error del servidor. Código: $statusCode';

      return ApiException(
        message: message,
        code: response?.data['error_code'] ?? 'ERROR_DESCONOCIDO',
        path: response?.requestOptions.path,
      );
    }

    return ApiException(message: 'Error desconocido en la conexión');
  }
}
