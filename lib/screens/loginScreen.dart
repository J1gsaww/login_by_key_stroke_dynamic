import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login_by_key_stroke_dynamic/screens/welcomeScreen.dart';
import 'package:lottie/lottie.dart';
import '../model/profile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: const Color(0xFFEAEDFA),
              appBar: AppBar(
                title: const Text("Login"),
                backgroundColor: const Color(0xFF95A4DE),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                           SizedBox(
                            width: 400,
                            height: 270,
                            child: Lottie.network('https://assets4.lottiefiles.com/packages/lf20_7fy2yzzs.json'),
                          ),
                          // Card(
                            Padding(
                               padding: const EdgeInsets.all(25.0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Welcome back",
                                        style: TextStyle(fontSize: 25, color: Color(0xFF576CBE),fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "Enter your credentials to continue.",
                                       style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 170, 170, 173)),
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      children: [
                                          Icon(Icons.email, color: Color(0xFF576CBE)),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "E-mail",
                                            style: TextStyle(fontSize: 20, color: Color(0xFF576CBE)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE0E4F5),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: TextFormField(
                                        validator: MultiValidator([
                                          RequiredValidator(
                                            errorText: "Please input your email!",
                                          ),
                                          EmailValidator(
                                            errorText: "Invalid Email format!",
                                          ),
                                        ]),
                                        keyboardType: TextInputType.emailAddress,
                                        onSaved: (String? email) {
                                          profile.email = email;
                                        },
                                      ),
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                        Icon(Icons.lock_outline, color: Color(0xFF576CBE)),
                                        const SizedBox(width: 10),
                                        const Text(
                                        "Password",
                                        style: TextStyle(fontSize: 20, color: Color(0xFF576CBE)),
                                      ),
                                    ],
                                 ),
                            SizedBox(height: 8),
                            Container(
                               decoration: BoxDecoration(
                                  color: Color(0xFFE0E4F5),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                  child: TextFormField(
                                  validator: RequiredValidator(
                                  errorText: "Please input your password!",),
                                  obscureText: true,
                                  onSaved: (String? password) {
                                    profile.password = password;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      // ),
                      SizedBox(height: 15),
                      Center(
                        child:SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xFF95A4DE),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: profile.email ?? "",
                                            password: profile.password ?? "")
                                        .then((value) {
                                      formKey.currentState!.reset();
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) {
                                        return const WelcomeScreen();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    // print(e.message);
                                    // print(e.code);
                                    Fluttertoast.showToast(
                                        msg: e.message ?? "",
                                        backgroundColor: Color.fromARGB(255, 181, 189, 221),
                                        gravity: ToastGravity.TOP);
                                    }
                                  }
                                },
                              ),
                            ) 
                          )
                        ],
                      ),
                    )),
                  ),
                );
              }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
