import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../app_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.onSaved});
  final VoidCallback onSaved;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final _first = TextEditingController(text: appState.admin.firstName);
  late final _last = TextEditingController(text: appState.admin.lastName);
  late final _user = TextEditingController(text: appState.admin.username);
  late final _email = TextEditingController(text: appState.admin.email);
  late final _phone = TextEditingController(text: appState.admin.phone);
  late final _addr = TextEditingController(text: appState.admin.address);

  final _newPass = TextEditingController();
  final _confirm = TextEditingController();

  File? _profileImage; // Store the selected profile image

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Edit Profile',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            _profileImage != null ? FileImage(_profileImage!) : null,
                        child: _profileImage == null
                            ? const Icon(Icons.person, size: 40)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      TextButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.upload),
                        label: const Text('Upload Photo'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _field('First Name', _first),
                      _field('Last Name', _last),
                      _field('Email Address', _email,
                          icon: Icons.email_outlined),
                      _field('Username', _user),
                      _field('Password (new)', _newPass, obscure: true),
                      _field('Confirm Password', _confirm, obscure: true),
                      _field('Phone Number', _phone, icon: Icons.phone_outlined),
                      _field('Address', _addr, icon: Icons.place_outlined),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      // For now, we ignore password change (no backend)
                      appState.updateAdmin(
                        first: _first.text,
                        last: _last.text,
                        user: _user.text,
                        addr: _addr.text,
                        mail: _email.text,
                        phone: _phone.text,
                      );
                      widget.onSaved();
                    },
                    child: const Text('Save Changes'),
                  ),
                ],
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
      constraints: const BoxConstraints(minWidth: 250, maxWidth: 320),
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
