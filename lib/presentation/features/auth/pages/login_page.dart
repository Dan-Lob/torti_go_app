import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/login_controller.dart';
import '../controllers/login_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/auth_scaffold.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);

    // Escucha los cambios de estado para navegar o mostrar errores
    ref.listen<LoginState>(loginControllerProvider, (prev, next) {
      if (next.status == LoginStatus.success) {
        context.go('/home');
      } else if (next.status == LoginStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error ?? 'Error desconocido')),
        );
      }
    });

    return AuthScaffold(
      title: "Bienvenido",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: _emailController,
            hintText: 'Correo electrónico',
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _passwordController,
            hintText: 'Contraseña',
            obscureText: true,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Entrar',
            isLoading: state.status == LoginStatus.loading,
            onPressed: () {
              final email = _emailController.text.trim();
              final password = _passwordController.text;

              if (email.isEmpty || password.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Completa todos los campos')),
                );
                return;
              }

              ref.read(loginControllerProvider.notifier).login(email, password);
            },
          ),
        ],
      ),
    );
  }
}
