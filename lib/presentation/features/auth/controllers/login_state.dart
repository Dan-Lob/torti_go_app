// lib/presentation/features/auth/controllers/login_state.dart

import 'package:torti_go_app/domain/entities/auth/login_response.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState {
  final LoginStatus status;
  final LoginResponse? user;
  final String? error;

  const LoginState({
    this.status = LoginStatus.initial,
    this.user,
    this.error,
  });

  LoginState copyWith({
    LoginStatus? status,
    LoginResponse? user,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
