import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torti_go_app/infrastructure/datasources/auth/auth_local_datasource.dart';
import 'package:torti_go_app/presentation/shared/router/app_router.dart';

final logoutProvider = Provider((ref) {
  return () async {
    final localDataSource = ref.read(authLocalDataSourceProvider);
    await localDataSource.logout();
    ref.read(appRouterProvider).go('/login');
  };
});
