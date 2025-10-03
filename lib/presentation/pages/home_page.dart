import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/dependency_injection.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeStore store;

  @override
  void initState() {
    super.initState();
    store = HomeStore(locator<SettingsRepository>(), locator<UserRepository>());
    _initializeData();
  }

  Future<void> _initializeData() async {
    await store.loadCurrentUser();
    await store.loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          Observer(
            builder: (context) {
              if (store.currentUser != null) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    child: Text(
                      store.currentUser!.name[0],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.public),
            onPressed: () => context.go('/webview'),
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          if (store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (store.currentUser == null) {
            return const Center(child: Text('Usuário não encontrado'));
          }

          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          store.currentUser!.name[0],
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Olá, ${store.currentUser!.name}!',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              store.currentUser!.email,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Chip(
                        label: Text(
                          '${store.favoriteItems.length} favoritos',
                          style: const TextStyle(fontSize: 12),
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: store.categories.length,
                  itemBuilder: (context, index) {
                    final category = store.categories[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: Text(category),
                        selected: store.filterCategory == category,
                        onSelected: (selected) {
                          store.setFilterCategory(category);
                        },
                      ),
                    );
                  },
                ),
              ),
              const Divider(),

              Expanded(
                child: ListView.builder(
                  itemCount: store.filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = store.filteredItems[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primaryContainer,
                          child: Text(
                            item.id,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        title: Text(item.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.description),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Chip(
                                  label: Text(item.category),
                                  visualDensity: VisualDensity.compact,
                                ),
                                const Spacer(),
                                Text(
                                  'R\$${item.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            item.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: item.isFavorite ? Colors.red : null,
                          ),
                          onPressed: () => store.toggleFavorite(item.id),
                          tooltip: item.isFavorite
                              ? 'Remover dos favoritos'
                              : 'Adicionar aos favoritos',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
