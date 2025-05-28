// domain/repositories/auth/auth_repository.dart
import 'package:torti_go_app/data/models/auth/login_request_model.dart';
import 'package:torti_go_app/domain/entities/auth/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginRequestModel request);
}
