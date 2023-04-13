import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login_by_key_stroke_dynamic/model/profile.dart';
import 'package:login_by_key_stroke_dynamic/screens/homeScreen.dart';

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
              appBar: AppBar(
                title: const Text("Register"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "E-mail",
                            style: TextStyle(fontSize: 20),
                          ),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Please input your email!"),
                              EmailValidator(errorText: "Invalid Email format!")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? email) {
                              profile.email = email;
                            },
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Password",
                            style: TextStyle(fontSize: 20),
                          ),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "Please input your password!"),
                            obscureText: true,
                            onSaved: (String? password) {
                              profile.password = password;
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
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
                                              "Account has been create successfully.",
                                          gravity: ToastGravity.TOP);
                                      formKey.currentState!.reset();
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) {
                                        return const HomeScreen();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    // print(e.message);
                                    // print(e.code);
                                    Fluttertoast.showToast(
                                        msg: e.message ?? "",
                                        gravity: ToastGravity.TOP);
                                  }
                                }
                              },
                            ),
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
