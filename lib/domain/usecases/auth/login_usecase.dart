// lib/domain/usecases/auth/login_usecase.dart

//import 'package:torti_go_app/data/models/auth/login_request_model.dart';


import 'package:torti_go_app/domain/entities/auth/login_credentials.dart';
import 'package:torti_go_app/domain/entities/auth/login_response.dart';
import 'package:torti_go_app/domain/repositories/auth/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<LoginResponse> execute(LoginCredentials request) async {
    final response = await repository.login(request);
    await repository.saveToken(response.token);
    return response;
  }
}
