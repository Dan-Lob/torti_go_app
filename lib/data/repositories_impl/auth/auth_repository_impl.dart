import 'package:torti_go_app/data/datasources/auth/auth_datasource.dart';
import 'package:torti_go_app/data/models/auth/login_request_model.dart';
import 'package:torti_go_app/domain/entities/auth/login_response.dart';
import 'package:torti_go_app/domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<LoginResponse> login(LoginRequestModel request) {
    return datasource.login(request);
  }
}
