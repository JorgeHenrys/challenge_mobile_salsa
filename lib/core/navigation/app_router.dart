import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const SizedBox(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const SizedBox(),
      ),
      GoRoute(
        path: '/webview',
        name: 'webview',
        builder: (context, state) => const SizedBox(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SizedBox(),
      ),
    ],
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = state.uri.path == '/login' ? false : true; // Mocked
      if (!isLoggedIn && state.uri.path != '/login') {
        return '/login';
      }
      if (isLoggedIn && state.uri.path == '/login') {
        return '/home';
      }
      return null;
    },
  );
}
