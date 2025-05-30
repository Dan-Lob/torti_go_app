import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:torti_go_app/core/exceptions/api_exception.dart';
//import 'package:torti_go_app/data/models/auth/login_request_model.dart';
import 'package:torti_go_app/domain/entities/auth/login_credentials.dart';
import 'package:torti_go_app/domain/usecases/auth/login_usecase.dart';
import 'package:torti_go_app/presentation/features/auth/controllers/login_state.dart';
import 'package:torti_go_app/presentation/shared/providers/secure_storage_provider.dart';
import 'package:torti_go_app/core/constants/storage_keys.dart';
import 'package:torti_go_app/presentation/shared/providers/shared_providers.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>(
  (ref) {
    final useCase = ref.watch(loginUseCaseProvider);
    final storage = ref.watch(secureStorageProvider);
    return LoginController(useCase, storage);
  },
);

class LoginController extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;
  final FlutterSecureStorage _storage;

  LoginController(this._loginUseCase, this._storage)
      : super(const LoginState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: LoginStatus.loading);

    final request = LoginCredentials(email: email, password: password);

    try {
      final response = await _loginUseCase.execute(request);

      // Guarda el token bajo la clave estandarizada
      await _storage.write(key: StorageKeys.token, value: response.token);

      state = state.copyWith(
        status: LoginStatus.success,
        token: response.token,
      );
    } on ApiException catch (e) {
      state = state.copyWith(
        status: LoginStatus.error,
        error: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        status: LoginStatus.error,
        error: 'Error inesperado: ${e.toString()}',
      );
    }
  }

  void reset() {
    state = const LoginState();
  }
}
