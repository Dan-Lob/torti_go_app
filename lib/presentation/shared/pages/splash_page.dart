// lib/presentation/shared/pages/splash_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:torti_go_app/presentation/shared/init/app_initializer.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    // Animación de entrada del logo
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        _opacity = 1;
      });
    });

    // Ejecutar appInitializerProvider
    ref.read(appInitializerProvider);
  }

  @override
  Widget build(BuildContext context) {
    final init = ref.watch(appInitializerProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF7043), Color(0xFFFFAB91)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: init.when(
            data: (_) => const SizedBox.shrink(), // Nunca se muestra
            loading: () => AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: _opacity,
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 900),
                curve: Curves.elasticOut,
                tween: Tween<double>(begin: 0.6, end: 1.0),
                builder: (context, scale, child) => Transform.scale(
                  scale: scale,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/tortilla_bag.png',
                        width: 120.w,
                        height: 120.w,
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'TortiGo',
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            error: (err, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 48),
                SizedBox(height: 16.h),
                Text(
                  'Error al iniciar\n$err',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
