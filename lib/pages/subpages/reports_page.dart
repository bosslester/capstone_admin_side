import 'package:flutter/material.dart';
import '../../app_state.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final q = _query.toLowerCase();
    final items = appState.reports.where((r) {
      return r.title.toLowerCase().contains(q) ||
          r.details.toLowerCase().contains(q);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _searchBox(),
          const SizedBox(height: 12),
          Expanded(
            child: Card(
              child: items.isEmpty
                  ? const Center(child: Text('No reports found'))
                  : ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, i) {
                        final r = items[i];
                        return ListTile(
                          leading: const Icon(Icons.flag_outlined),
                          title: Text(r.title),
                          subtitle: Text(r.details),
                          trailing: Text(
                            '${r.createdAt.year}-${r.createdAt.month.toString().padLeft(2, '0')}-'
                            '${r.createdAt.day.toString().padLeft(2, '0')}',
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

  Widget _searchBox() {
    return TextField(
      onChanged: (value) => setState(() => _query = value),
      decoration: InputDecoration(
        hintText: 'Search reports',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _query.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => setState(() => _query = ''),
              ),
      ),
    );
  }
}
