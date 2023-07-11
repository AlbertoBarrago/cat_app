import 'package:flutter/material.dart';
import 'package:app_cats/widgets/features/email_modal.dart';

class TabHome extends StatelessWidget {
  const TabHome({super.key, required this.username});

  final String username;

  void onCollaboratePressed(BuildContext context) {

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EmailSender(),
      ),
    );
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
            "Welcome to the Cat Application! \n \n In this cat-filled paradise, you can immerse yourself in the adorable world of cats. Our application offers a delightful collection of cat images that will surely bring a smile to your face. \n \n You can explore a wide variety of cat photos, ranging from cute and cuddly kittens to majestic and regal felines. Feel free to browse through the gallery and discover your favorite cat breeds, playful antics, and heart-melting poses. \n \n Do you want to spread the joy of cats with your friends and family? We've got you covered! You can easily share your favorite cat images directly from the app to various social media platforms, allowing others to experience the cuteness overload.",
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

