// lib/domain/repositories/auth/auth_repository.dart

import 'package:torti_go_app/domain/entities/auth/login_response.dart';
import 'package:torti_go_app/domain/entities/auth/login_credentials.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginCredentials credentials);
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<String> refreshToken(String oldToken);
}
