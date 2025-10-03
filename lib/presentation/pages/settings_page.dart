import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/dependency_injection.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../stores/settings_store.dart';
import '../stores/theme_store.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SettingsStore settingsStore;
  late final ThemeStore themeStore;

  @override
  void initState() {
    super.initState();
    settingsStore = SettingsStore(
      locator<SettingsRepository>(),
      locator<UserRepository>(),
    );
    themeStore = locator<ThemeStore>();
    settingsStore.loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Configurações'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (!context.canPop() && !context.mounted) {
              return;
            }

            context.go('/home');
          },
        ),
      ),
      body: Observer(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (settingsStore.currentUser != null) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informações do Usuário',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: const Text('Nome'),
                            subtitle: Text(settingsStore.currentUser!.name),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.email,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: const Text('Email'),
                            subtitle: Text(settingsStore.currentUser!.email),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aparência',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Observer(
                          builder: (context) {
                            return SwitchListTile(
                              title: const Text('Modo Escuro'),
                              subtitle: Text(
                                themeStore.isDarkMode
                                    ? 'Tema escuro ativado'
                                    : 'Tema claro ativado',
                              ),
                              value: themeStore.isDarkMode,
                              onChanged: (value) async {
                                await themeStore.toggleTheme();
                              },
                              secondary: Icon(
                                themeStore.isDarkMode
                                    ? Icons.dark_mode
                                    : Icons.light_mode,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ações',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () async {
                              await settingsStore.logout();
                              if (context.mounted) {
                                context.go('/login');
                              }
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.error,
                              foregroundColor: Theme.of(
                                context,
                              ).colorScheme.onError,
                            ),
                            child: const Text('Sair da conta'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
