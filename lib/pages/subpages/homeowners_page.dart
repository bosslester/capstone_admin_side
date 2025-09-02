import 'package:flutter/material.dart';
import '../../app_state.dart';

class HomeownersPage extends StatefulWidget {
  const HomeownersPage({super.key});

  @override
  State<HomeownersPage> createState() => _HomeownersPageState();
}

class _HomeownersPageState extends State<HomeownersPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final items = appState.homeowners.where((p) {
      final q = _query.toLowerCase();
      return p.fullName.toLowerCase().contains(q) ||
          p.username.toLowerCase().contains(q);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 🔍 Search Bar
          TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Search homeowner',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _query.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _query = ''),
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          const SizedBox(height: 16),

          // 📋 Homeowner List
          Expanded(
            child: items.isEmpty
                ? const Center(
                    child: Text("No homeowners found"),
                  )
                : ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final p = items[i];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: ListTile(
                          leading: const CircleAvatar(
                            radius: 24,
                            child: Icon(Icons.person),
                          ),
                          title: Text(
                            p.fullName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: Text("${p.username} • ${p.email}"),
                          trailing: IconButton(
                            tooltip: 'Delete',
                            icon: const Icon(Icons.delete_forever,
                                color: Colors.red),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Delete Homeowner"),
                                  content: Text(
                                      "Are you sure you want to delete ${p.fullName}?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, false),
                                        child: const Text("Cancel")),
                                    FilledButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, true),
                                        child: const Text("Delete")),
                                  ],
                                ),
                              );
                              if (confirm ?? false) {
                                appState.deleteHomeowner(p);
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
