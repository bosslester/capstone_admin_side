import 'package:flutter/material.dart';
import '../app_state.dart';
import 'subpages/dashboard_page.dart';
import 'subpages/profile_page.dart';
import 'subpages/edit_profile_page.dart';
import 'subpages/workers_page.dart';
import 'subpages/homeowners_page.dart';
import 'subpages/reports_page.dart';
import 'subpages/approval_page.dart';

enum Section {
  dashboard,
  profile,
  editProfile,
  workers,
  homeowners,
  reports,
  approval,
}

class Shell extends StatefulWidget {
  const Shell({super.key});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  Section _section = Section.dashboard;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Row(
        children: [
          _Sidebar(
            current: _section,
            onTap: (s) => setState(() => _section = s),
            onLogout: () {
              appState.logout();
              if (mounted) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (_) => false);
              }
            },
          ),
          Expanded(
            child: Column(
              children: [
                _TopBar(
                  title: _titleFor(_section),
                  onProfile: () =>
                      setState(() => _section = Section.profile),
                ),
                const Divider(height: 1),
                Expanded(child: _content()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _titleFor(Section s) {
    switch (s) {
      case Section.dashboard:
        return 'Dashboard';
      case Section.profile:
        return 'Admin Profile';
      case Section.editProfile:
        return 'Edit Profile';
      case Section.workers:
        return 'Workers';
      case Section.homeowners:
        return 'Homeowners';
      case Section.reports:
        return 'Reports';
      case Section.approval:
        return 'Approval';
    }
  }

  Widget _content() {
    switch (_section) {
      case Section.dashboard:
        return const DashboardPage();
      case Section.profile:
        return ProfilePage(
          onEdit: () => setState(() => _section = Section.editProfile),
        );
      case Section.editProfile:
        return EditProfilePage(
          onSaved: () => setState(() => _section = Section.profile),
        );
      case Section.workers:
        return const WorkersPage();
      case Section.homeowners:
        return const HomeownersPage();
      case Section.reports:
        return const ReportsPage();
      case Section.approval:
        return const ApprovalPage();
    }
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.current,
    required this.onTap,
    required this.onLogout,
  });

  final Section current;
  final ValueChanged<Section> onTap;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget btn(IconData icon, String label, Section s) {
      final active = current == s;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: InkWell(
          onTap: () => onTap(s),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: 160,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: active ? cs.primary.withOpacity(.12) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: active ? cs.primary : cs.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      width: 200,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              'FIXIT WIZARD',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 12),
            btn(Icons.dashboard_outlined, 'Dashboard', Section.dashboard),
            btn(Icons.person_outline, 'Admin', Section.profile),
            btn(Icons.handyman_outlined, 'Workers', Section.workers),
            btn(Icons.home_outlined, 'Homeowners', Section.homeowners),
            btn(Icons.flag_outlined, 'Reports', Section.reports),
            btn(Icons.verified_outlined, 'Approval', Section.approval),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: 160,
                child: OutlinedButton.icon(
                  onPressed: onLogout,
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title, required this.onProfile});

  final String title;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(width: 24),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onProfile,
            borderRadius: BorderRadius.circular(24),
            child: const CircleAvatar(child: Icon(Icons.person)),
          ),
        ],
      ),
    );
  }
}
