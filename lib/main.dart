import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'presentation/shared/router/app_router.dart';
import 'presentation/shared/themes/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TortiGoApp(),
    ),
  );
}

class TortiGoApp extends StatelessWidget {
  const TortiGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Basado en iPhone X
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return const MyApp();
      },
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'TortiGo',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
