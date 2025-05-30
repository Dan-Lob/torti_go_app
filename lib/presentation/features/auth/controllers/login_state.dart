enum LoginStatus {
  initial,
  loading,
  success,
  error,
}

class LoginState {
  final LoginStatus status;
  final String? token;
  final String? error;

  const LoginState({
    this.status = LoginStatus.initial,
    this.token,
    this.error,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? token,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      token: token ?? this.token,
      error: error ?? this.error,
    );
  }

  bool get isLoading => status == LoginStatus.loading;
  bool get isSuccess => status == LoginStatus.success;
  bool get isError => status == LoginStatus.error;
  bool get isInitial => status == LoginStatus.initial;
}
