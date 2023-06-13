import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/providers/user_provider.dart';

class OnboardingWidget extends StatelessWidget {
  final String name;
  final String role;

  const OnboardingWidget({super.key, required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Miaooo!', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, $name!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Role: $role',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                userProvider.setUser(name, role);
                Navigator.of(context).pop();
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}