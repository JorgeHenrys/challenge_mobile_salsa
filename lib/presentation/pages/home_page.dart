import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/dependency_injection.dart';
import '../../domain/repositories/settings_repository.dart';
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
    store = HomeStore(locator<SettingsRepository>());
    store.loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: [
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

          return Column(
            children: [
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
                        leading: CircleAvatar(child: Text(item.id)),
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
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
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
