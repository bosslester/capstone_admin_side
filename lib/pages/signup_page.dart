import 'package:flutter/material.dart';
import '../app_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _user = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  final _phone = TextEditingController();

  Role _role = Role.homeowner;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _field('First Name', _first),
                        _field('Last Name', _last),
                        _field('Username', _user),
                        _field('Email Address', _email,
                            icon: Icons.email_outlined),
                        _field('Password', _pass,
                            obscure: true, icon: Icons.lock_outline),
                        _field('Confirm Password', _confirm,
                            obscure: true, icon: Icons.lock_reset),
                        _field('Phone Number', _phone,
                            icon: Icons.phone_outlined),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('Role: '),
                        DropdownButton<Role>(
                          value: _role,
                          items: const [
                            DropdownMenuItem(
                                value: Role.homeowner,
                                child: Text('Homeowner')),
                            DropdownMenuItem(
                                value: Role.worker, child: Text('Worker')),
                          ],
                          onChanged: (r) =>
                              setState(() => _role = r ?? Role.homeowner),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (_error != null)
                      Text(
                        _error!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () {
                        if (_pass.text != _confirm.text) {
                          setState(
                              () => _error = 'Passwords do not match.');
                          return;
                        }
                        final p = Person(
                          firstName: _first.text.trim(),
                          lastName: _last.text.trim(),
                          username: _user.text.trim(),
                          email: _email.text.trim(),
                          phone: _phone.text.trim(),
                          role: _role,
                          approved: false,
                        );
                        appState.addSignup(p);
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Submitted'),
                            content: const Text(
                                'Your account is awaiting approval.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop(); // back to login
                                },
                                child: const Text('OK'),
                              )
                            ],
                          ),
                        );
                      },
                      child: const Text('Create Account'),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Back to Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController c,
      {bool obscure = false, IconData? icon}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 230, maxWidth: 520),
      child: TextField(
        controller: c,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }
}
