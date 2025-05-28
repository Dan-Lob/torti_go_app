// lib/presentation/shared/providers/shared_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torti_go_app/presentation/shared/providers/dio_provider.dart'; // ✅ correcto
import 'package:torti_go_app/data/datasources/auth/auth_datasource.dart';
import 'package:torti_go_app/data/repositories_impl/auth/auth_repository_impl.dart';
import 'package:torti_go_app/domain/usecases/auth/login_usecase.dart';
import 'package:torti_go_app/domain/repositories/auth/auth_repository.dart';

final authDatasourceProvider = Provider<AuthDatasource>(
  (ref) => AuthDatasourceImpl(ref.watch(dioProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(authDatasourceProvider)),
);

final loginUseCaseProvider = Provider<LoginUseCase>(
  (ref) => LoginUseCase(ref.watch(authRepositoryProvider)),
);
