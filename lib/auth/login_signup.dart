import 'package:app_cats/services/models/db_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/functions/commons/generateRandomHumanName.dart';
import '../services/functions/mongo/db_connection.dart';
import '../services/models/user.dart';
import '../services/providers/user_provider.dart';
import '../services/settings/const.dart';
import '../widgets/global/input_password.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({super.key});

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  String userEmail = '';
  String userPassword = '';

  final MongoDBService mongoDBService = MongoDBService(
    mongoUrl: connectionUrl,
    dbName: dbNameCatApp,
  );

  void goToOnBoarding(String name, String role) {
    // Go Direct to Home
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUser(name, role);

    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => OnboardingWidget(name: name, role: role),
    // ));
  }

  void goToFuck() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Write something...'),
      ),
    );
  }

  fetchUserFromMongo() async {
    if(userEmail == '' || userPassword == '') {
      return goToFuck();
    }

    /// Get User and check if is Admin
    UserMongo users = await mongoDBService.findUserByEmailAndPassword(userEmail, userPassword);
    if(users.name != '') {
      return User(users.name, 'Admin');
    } else {
      return User(generateRandomHumanName(), 'Guest');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) {
                setState(() {
                  userEmail = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            PasswordField(
                onChanged: (value){
                  setState(() {
                    userPassword = value;
                  });
                }
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Perform login logic and fetch user from MongoDB
                User userLogged = await fetchUserFromMongo();
                goToOnBoarding(userLogged.user, userLogged.role);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

}
