import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login_by_key_stroke_dynamic/model/profile.dart';
import 'package:login_by_key_stroke_dynamic/screens/homeScreen.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                title: const Text("Register"),
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
                            child: Lottie.network(
                                'https://assets4.lottiefiles.com/packages/lf20_7fy2yzzs.json'),
                          ),
                          // Card(
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Create account!",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Color(0xFF576CBE),
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "Register to get started.",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          Color.fromARGB(255, 170, 170, 173)),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: const [
                                    Icon(Icons.email, color: Color(0xFF576CBE)),
                                    SizedBox(width: 10),
                                    Text(
                                      "E-mail",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF576CBE)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0E4F5),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: TextFormField(
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                              "Please input your email!"),
                                      EmailValidator(
                                          errorText: "Invalid Email format!")
                                    ]),
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (String? email) {
                                      profile.email = email;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: const [
                                    Icon(Icons.lock_outline,
                                        color: Color(0xFF576CBE)),
                                    SizedBox(width: 10),
                                    Text(
                                      "Password",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF576CBE)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0E4F5),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: TextFormField(
                                    validator: RequiredValidator(
                                      errorText: "Please input your password!",
                                    ),
                                    obscureText: true,
                                    onSaved: (String? password) {
                                      profile.password = password;
                                    },
                                    decoration: const InputDecoration(
                                      fillColor: Color(0xFFE0E4F5),
                                      filled: true,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // ),
                          ),
                          const SizedBox(height: 15),
                          Center(
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF95A4DE),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: const Text(
                                  "Registered",
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    try {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                        email: profile.email ?? "",
                                        password: profile.password ?? "",
                                      )
                                          .then((value) {
                                        Fluttertoast.showToast(
                                          msg:
                                              "Account has been created successfully.",
                                          backgroundColor: const Color.fromARGB(
                                              255, 181, 189, 221),
                                          gravity: ToastGravity.TOP,
                                        );
                                        formKey.currentState!.reset();
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) {
                                            return const HomeScreen();
                                          }),
                                        );
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      Fluttertoast.showToast(
                                        msg: e.message ?? "",
                                        gravity: ToastGravity.TOP,
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
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
