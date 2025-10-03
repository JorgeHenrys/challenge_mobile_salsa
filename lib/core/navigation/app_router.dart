import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/repositories/user_repository.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/settings_page.dart';
import '../../presentation/pages/webview_page.dart';
import '../di/dependency_injection.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/webview',
        name: 'webview',
        builder: (context, state) => const WebViewPage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    initialLocation: '/login',
    redirect: (context, state) async {
      final userRepository = locator<UserRepository>();

      final isLoggedIn = await userRepository.isLoggedIn();

      final goingToLogin = state.uri.path == '/login';

      if (isLoggedIn && goingToLogin) {
        return '/home';
      }

      if (!isLoggedIn && !goingToLogin) {
        return '/login';
      }

      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Página não encontrada',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'A rota ${state.uri.path} não existe.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go('/home'),
              child: const Text('Ir para Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
