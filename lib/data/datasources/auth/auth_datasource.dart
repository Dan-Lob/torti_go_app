// Ruta: lib/data/datasources/auth/auth_datasource.dart

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:torti_go_app/core/exceptions/server_exception.dart';
import 'package:torti_go_app/core/config/env.dart';

abstract class AuthDatasource {
  Future<String> login(String email, String password);
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<String> refreshToken(String token);
}

class AuthDatasourceImpl implements AuthDatasource {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  static const String _tokenKey = 'auth_token';

  AuthDatasourceImpl({
    required this.dio,
    required this.secureStorage,
  });

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await dio.post(
        '${Env.baseUrl}/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final token = response.data['data']['token'];
      await saveToken(token);
      return token;
    } catch (e) {
      throw ServerException.handleDioError(e);
    }
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return secureStorage.read(key: _tokenKey);
  }

  @override
  Future<void> clearToken() async {
    await secureStorage.delete(key: _tokenKey);
  }

  @override
  Future<String> refreshToken(String token) async {
    try {
      final response = await dio.post(
        '${Env.baseUrl}/auth/refresh',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final newToken = response.data['data']['token'];
      await saveToken(newToken);
      return newToken;
    } catch (e) {
      throw ServerException.handleDioError(e);
    }
  }
}
