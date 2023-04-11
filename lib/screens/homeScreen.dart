import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:login_by_key_stroke_dynamic/screens/loginScreen.dart';
import 'package:login_by_key_stroke_dynamic/screens/registerScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: Column(
          children: [
            Image.asset("assets/images/logo.png", height: 100, width: 100),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const RegisterScreen();
                    }));
                  },
                  icon: const Icon(Icons.add),
                  label: const Text(
                    "Register",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  },
                  icon: const Icon(Icons.login),
                  label: const Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
