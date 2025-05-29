// lib/data/datasources/auth/auth_datasource.dart

import 'package:dio/dio.dart';
import 'package:torti_go_app/data/models/auth/login_request_model.dart';
import 'package:torti_go_app/data/models/auth/login_response_model.dart';
import 'package:torti_go_app/data/models/common/base_response_model.dart';
import 'package:torti_go_app/domain/entities/auth/login_response.dart';
import 'package:torti_go_app/core/exceptions/api_exception.dart';

abstract class AuthDatasource {
  Future<LoginResponse> login(LoginRequestModel request);
}

class AuthDatasourceImpl implements AuthDatasource {
  final Dio dio;

  AuthDatasourceImpl(this.dio);

  @override
  Future<LoginResponse> login(LoginRequestModel request) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: request.toJson(),
      );

      final base = BaseResponseModel<LoginResponseModel>.fromJson(
        response.data,
        (data) => LoginResponseModel.fromJson(data),
      );

      if (!base.success || base.data == null) {
        throw ApiException(message: base.message);
      }

      return base.data!.toEntity();
    } on DioException catch (e) {
      final response = e.response;
      if (response != null && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        final statusCode = response.statusCode;
        final messageApi = data['message'] ?? 'Error desconocido';

        throw ApiException(
          message: '[$statusCode] $messageApi',
          code: data['error_code'],
          path: data['path'],
        );
      }

      throw ApiException(
        message: 'Error de red o servidor: ${e.message}',
      );
    }
  }
}
