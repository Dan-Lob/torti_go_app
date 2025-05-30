import 'package:torti_go_app/data/datasources/auth/auth_datasource.dart';
import 'package:torti_go_app/domain/entities/auth/login_response.dart';
import 'package:torti_go_app/domain/entities/auth/login_credentials.dart';
//import 'package:torti_go_app/data/models/auth/login_request_model.dart';
import 'package:torti_go_app/domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<LoginResponse> login(LoginCredentials request) async {
    final token = await datasource.login(request.email, request.password);
    return LoginResponse(token: token);
  }

  @override
  Future<void> saveToken(String token) async {
    await datasource.saveToken(token);
  }

  @override
  Future<String?> getToken() async {
    return await datasource.getToken();
  }

  @override
  Future<void> clearToken() async {
    await datasource.clearToken();
  }

  @override
  Future<String> refreshToken(String oldToken) async {
    return await datasource.refreshToken(oldToken);
  }
}
