import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'core/di/dependency_injection.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'domain/repositories/settings_repository.dart';
import 'presentation/stores/theme_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouter appRouter;
  late final SettingsRepository settingsRepository;
  final themeStore = locator<ThemeStore>();

  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    appRouter = locator<AppRouter>();
    settingsRepository = locator<SettingsRepository>();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final darkMode = await settingsRepository.isDarkMode();
    setState(() {
      isDarkMode = darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp.router(
          title: 'Salsa Challenge App',
          theme: themeStore.isDarkMode
              ? AppTheme.darkTheme
              : AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: appRouter.router,
          debugShowCheckedModeBanner: false,
          themeMode: themeStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
