import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torti_go_app/presentation/shared/providers/secure_storage_provider.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<String?> (
      future: ref.read(secureStorageProvider).read(key: 'token'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final token = snapshot.data;
        Future.microtask(() {
          if (token != null && token.isNotEmpty) {
            context.go('/home');
          } else {
            context.go('/login');
          }
        });

        return const SizedBox();
      },
    );
  }
}
