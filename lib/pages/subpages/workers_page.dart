import 'package:flutter/material.dart';
import '../../app_state.dart';

class WorkersPage extends StatefulWidget {
  const WorkersPage({super.key});

  @override
  State<WorkersPage> createState() => _WorkersPageState();
}

class _WorkersPageState extends State<WorkersPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final items = appState.workers.where((p) {
      final q = _query.toLowerCase();
      return p.fullName.toLowerCase().contains(q) ||
          p.username.toLowerCase().contains(q);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _search(
            hint: 'Search worker',
            onChanged: (v) => setState(() => _query = v),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Card(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, i) {
                  final p = items[i];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(p.fullName),
                    subtitle: Text('${p.username} • ${p.email}'),
                    trailing: IconButton(
                      tooltip: 'Delete',
                      icon: const Icon(Icons.delete_forever, color: Colors.red),
                      onPressed: () {
                        appState.deleteWorker(p);
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _search({
    required String hint,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _query.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() => _query = '');
                },
              ),
      ),
    );
  }
}
