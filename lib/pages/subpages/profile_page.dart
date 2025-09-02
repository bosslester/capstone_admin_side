import 'package:flutter/material.dart';
import '../../app_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.onEdit});
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final a = appState.admin;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      child: Icon(Icons.person, size: 36),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodyMedium!,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Admin',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text('First Name: ${a.firstName}'),
                            Text('Last Name: ${a.lastName}'),
                            Text('Email Address: ${a.email}'),
                            Text('Username: ${a.username}'),
                            Text('Phone Number: ${a.phone}'),
                            Text('Address: ${a.address}'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    FilledButton(
                      onPressed: onEdit,
                      child: const Text('Edit Profile'),
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
