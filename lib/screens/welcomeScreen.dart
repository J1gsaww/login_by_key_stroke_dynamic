import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'homeScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Column(children: [
        Text(
          auth.currentUser!.email!,
          style: const TextStyle(fontSize: 25),
        ),
        ElevatedButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return const HomeScreen();
                }));
              });
            },
            child: const Text("Logout"))
      ]),
    );
  }
}
