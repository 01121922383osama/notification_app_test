// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:notification_app/home/home_page.dart';
import 'package:notification_app/resources/auth_method.dart';

class LogInWithGoogle extends StatefulWidget {
  const LogInWithGoogle({super.key});

  @override
  _LogInWithGoogleState createState() => _LogInWithGoogleState();
}

class _LogInWithGoogleState extends State<LogInWithGoogle> {
  final AuthMethods authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    var image = 'assets/google.png';
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.grey,
                child: InkWell(
                  onTap: () async {
                    final res = await authMethods.signInwithGoogle(context);
                    if (res) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    }
                  },
                  child: Image.asset(image),
                ),
              ),
            ),
            const Text(
              'Sign-In-With-Google',
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
