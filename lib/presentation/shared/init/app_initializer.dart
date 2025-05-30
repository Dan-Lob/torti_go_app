// lib/presentation/shared/init/app_initializer.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torti_go_app/presentation/shared/router/app_router.dart';
import 'package:torti_go_app/presentation/shared/providers/shared_providers.dart'; 

final appInitializerProvider = FutureProvider.autoDispose<void>((ref) async {
  final authRepository = ref.read(authRepositoryProvider);
  final token = await authRepository.getToken();

  if (token == null) {
    ref.read(appRouterProvider).go('/login');
    return;
  }

  try {
    final refreshedToken = await authRepository.refreshToken(token);
    await authRepository.saveToken(refreshedToken);
    ref.read(appRouterProvider).go('/home');
  } catch (e) {
    await authRepository.clearToken();
    ref.read(appRouterProvider).go('/login');
  }
});
