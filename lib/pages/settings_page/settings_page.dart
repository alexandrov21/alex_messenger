import 'package:flutter/material.dart';

import '../../services/auth_services/auth_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await AuthService.signOut();

            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/sign_in', (route) => false);
          },
          child: const Text('exit'),
        ),
      ),
    );
  }
}
