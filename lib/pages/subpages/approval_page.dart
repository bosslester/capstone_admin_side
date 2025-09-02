import 'package:flutter/material.dart';
import '../../app_state.dart';

class ApprovalPage extends StatefulWidget {
  const ApprovalPage({super.key});

  @override
  State<ApprovalPage> createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    // Filter pending list by query
    final items = appState.pending.where((p) {
      final q = _query.toLowerCase();
      return p.fullName.toLowerCase().contains(q) ||
          p.username.toLowerCase().contains(q);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search bar
          TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Search pending users',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _query.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _query = ''),
                    ),
            ),
          ),
          const SizedBox(height: 12),

          // Pending list
          Expanded(
            child: Card(
              child: items.isEmpty
                  ? const Center(child: Text('No pending approvals'))
                  : ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, i) {
                        final p = items[i];
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(
                            '${p.fullName} • ${roleLabel(p.role)}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text('${p.username} • ${p.email}'),
                          trailing: Wrap(
                            spacing: 8,
                            children: [
                              IconButton(
                                tooltip: 'Approve',
                                icon: const Icon(Icons.check_circle,
                                    color: Colors.green),
                                onPressed: () {
                                  appState.approve(p);
                                  setState(() {});
                                },
                              ),
                              IconButton(
                                tooltip: 'Reject',
                                icon: const Icon(Icons.cancel,
                                    color: Colors.red),
                                onPressed: () {
                                  appState.reject(p);
                                  setState(() {});
                                },
                              ),
                            ],
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
}
