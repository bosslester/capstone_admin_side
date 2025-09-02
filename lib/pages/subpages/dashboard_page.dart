import 'package:flutter/material.dart';
import '../../app_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Statistic Card Widget
    Widget stat(String label, int value, IconData icon) {
      return Expanded(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: cs.primary),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FittedBox(
                  child: Text(
                    value.toString().padLeft(2, '0'),
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: cs.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final noReports = appState.reports.isEmpty;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Stats row
          Row(
            children: [
              stat(
                'Workers\nTotal Accounts',
                appState.totalWorkers,
                Icons.handyman_outlined,
              ),
              const SizedBox(width: 16),
              stat(
                'Homeowners\nTotal Accounts',
                appState.totalHomeowners,
                Icons.home_outlined,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Reports section
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reports',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    if (noReports)
                      const Expanded(
                        child: Center(child: Text('No new reports')),
                      )
                    else
                      Expanded(
                        child: ListView.separated(
                          itemCount: appState.reports.length,
                          separatorBuilder: (_, __) =>
                              const Divider(height: 1),
                          itemBuilder: (_, i) {
                            final r = appState.reports[i];
                            return ListTile(
                              leading: const Icon(Icons.flag_outlined),
                              title: Text(r.title),
                              subtitle: Text(r.details),
                              trailing: Text('${r.createdAt}'),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
