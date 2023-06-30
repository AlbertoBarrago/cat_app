import 'package:flutter/material.dart';
import 'package:app_cats/widgets/features/email_modal.dart';

class TabHome extends StatelessWidget {
  const TabHome({super.key, required this.username});

  final String username;

  void onCollaboratePressed(BuildContext context) {
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      return const EmailSender();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome, $username!',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Thank you for testing our Flutter app. This is a friendly application where you can see funny cat images and have a good time.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => onCollaboratePressed(context), // Call the function from an event handler.
            child: const Text('Collaborate'),
          ),
        ],
      ),
    );
  }
}

