import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:torti_go_app/presentation/features/auth/pages/login_page.dart';
import 'package:torti_go_app/presentation/features/home/pages/home_page.dart';
import 'package:torti_go_app/presentation/features/orders/pages/hacer_pedido_page.dart';
import 'package:torti_go_app/presentation/features/orders/pages/mis_pedidos_page.dart';
import 'package:torti_go_app/presentation/features/profile/pages/perfil_page.dart';
import 'package:torti_go_app/presentation/features/schedule/pages/horarios_page.dart';
import 'package:torti_go_app/presentation/features/wallet/pages/billetera_page.dart';
import 'package:torti_go_app/presentation/features/notifications/pages/notificaciones_page.dart';
import 'package:torti_go_app/presentation/shared/pages/splash_page.dart';


final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/pedido',
        builder: (context, state) => const HacerPedidoPage(),
      ),
      GoRoute(
        path: '/mis-pedidos',
        builder: (context, state) => const MisPedidosPage(),
      ),
      GoRoute(
        path: '/horarios',
        builder: (context, state) => const HorariosPage(),
      ),
      GoRoute(
        path: '/perfil',
        builder: (context, state) => const PerfilPage(),
      ),
      GoRoute(
        path: '/billetera',
        builder: (context, state) => const BilleteraPage(),
      ),
      GoRoute(
        path: '/notificaciones',
        builder: (context, state) => const NotificacionesPage(),
      ),
    ],
  );
});
