import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
          backgroundColor: const Color(0xFF95A4DE),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const SizedBox(height: 110),
            SizedBox(
              width: 400,
              height: 250,
              child: Lottie.network(
                  'https://assets8.lottiefiles.com/packages/lf20_g3dzz0wz.json'),
            ),
            const Text(
              "Welcome to CosmicShield !",
              style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFF576CBE),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              auth.currentUser!.email!,
              style: const TextStyle(fontSize: 25, color: Color(0xFF95A4DE)),
            ),
            const SizedBox(height: 8),
            Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF95A4DE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      auth.signOut().then((value) {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return const HomeScreen();
                        }));
                      });
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 15),
                    )))
          ]),
        ));
  }
}
