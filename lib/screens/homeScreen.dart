import 'package:flutter/material.dart';
import 'package:login_by_key_stroke_dynamic/screens/loginScreen.dart';
import 'package:login_by_key_stroke_dynamic/screens/registerScreen.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEDFA),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF95A4DE),
      //   title: const Text("Home Screen"),
      // ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400,
                height: 300,
                child: Lottie.network('https://assets2.lottiefiles.com/packages/lf20_8zzltjyc.json'),
              ),
              const SizedBox(height: 15),
              SizedBox(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Let's get started with",
                        style: TextStyle(fontSize: 25, color: Color(0xFF576CBE),fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "CosmicShield",
                        style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 23, 32, 71),fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 32),
              Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF95A4DE), // sets the background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50), // sets the corner radius
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text('REGISTER'),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF95A4DE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text('LOGIN'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

