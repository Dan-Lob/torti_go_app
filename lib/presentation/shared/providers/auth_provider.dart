import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torti_go_app/data/datasources/auth/auth_datasource.dart';
import 'package:torti_go_app/presentation/shared/state/auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:torti_go_app/core/constants/storage_keys.dart';
import 'package:torti_go_app/presentation/shared/providers/shared_providers.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authDatasource = ref.read(authDatasourceProvider);
  return AuthNotifier(authDatasource);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthDatasource _authDatasource;
  final _storage = const FlutterSecureStorage();

  AuthNotifier(this._authDatasource) : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final token = await _authDatasource.login(email, password);
      await _storage.write(key: StorageKeys.token, value: token);
      state = AuthState.authenticated(token: token);
    } catch (e) {
      state = AuthState.error(message: e.toString());
    }
  }

  Future<void> refreshToken() async {
    try {
      final oldToken = await _storage.read(key: StorageKeys.token);
      if (oldToken == null) {
        state = const AuthState.unauthenticated();
        return;
      }
      final newToken = await _authDatasource.refreshToken(oldToken);
      await _storage.write(key: StorageKeys.token, value: newToken);
      state = AuthState.authenticated(token: newToken);
    } catch (_) {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: StorageKeys.token);
    state = const AuthState.unauthenticated();
  }
}
