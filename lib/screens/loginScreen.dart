import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  FocusNode mainFocusNode = FocusNode();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

//timer
  int dwelltime = 0;
  int flighttime = 0;
  int downdown = 0;
  int _milliseconds = 0;
  int KST = 0;
  int KSTavg = 0;

  List<int> sigmaKST = <int>[];

  bool _isRunning = false;
  late Stopwatch _stopwatch;

  int ncount = 0;

  String downdowndisplay = "-";
  String KSTdisplay = "-";
  String Dwelldisplay = "-";
  String Flightdisplay = "-";
  String Keydisplay = "-";
  String KSTavgdisplay = "-";

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    _stopwatch.start();
    _stopwatch.start();
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {
        _milliseconds = _stopwatch.elapsedMilliseconds;
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });
    _stopwatch.stop();
  }

  void _resetTimer() {
    setState(() {
      _milliseconds = 0;
    });
    _stopwatch.reset();
  }

//timer
  int KST_compute(int _down, int _ncount, int dwell) {
    double KSTx = 0;
    if (_ncount > 0) {
      KSTx = _down / _ncount;
      KSTx = KSTx - dwell;
      return KSTx.round();
    }
    return 0;
  }

  int KSTavg_compute(int _KST, int _ncount) {
    int sum = 0;
    if (_ncount > 0) {
      sigmaKST.add(_KST);
      sigmaKST.forEach((e) => sum += e);
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          //initState();
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
          //initState();
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
<<<<<<< HEAD
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Welcome back",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Color(0xFF576CBE),
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "Enter your credentials to continue.",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          Color.fromARGB(255, 170, 170, 173)),
                                ),
                                ///////////////////////////////////////////////
                                const SizedBox(height: 10),
                                Text(
                                  "Button = $Keydisplay |Dwell time = $Dwelldisplay |Flight time = $Flightdisplay |KST = $KSTdisplay",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF576CBE),
                                      fontWeight: FontWeight.bold),
                                ),

                                const SizedBox(height: 5),
                                Text(
                                  "Current KST average: $KSTavgdisplay",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF576CBE),
                                      fontWeight: FontWeight.bold),
                                ),
                                //////////////////////////////////////////////
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
                                    //Algorithm----------------------------------------
                                    child: RawKeyboardListener(
                                      focusNode: mainFocusNode,
                                      autofocus: true,
                                      onKey: (RawKeyEvent event) {
                                        //
                                        final key = event.logicalKey;
                                        if (event is RawKeyDownEvent) {
                                          downdown = _milliseconds;
                                          flighttime = downdown - dwelltime;
                                          ncount++;
                                          //int KST_compute(int _down, int _ncount, int dwell)
                                          KST = KST_compute(
                                              downdown, ncount, dwelltime);
                                          KSTavg = KSTavg_compute(KST, ncount);
                                          //////////////setState//////////////
                                          setState(() {
                                            KSTavgdisplay = "$KSTavg";
                                            downdowndisplay = "$downdown";
                                            Flightdisplay = "$flighttime";
                                            Keydisplay = key.keyLabel;
                                            Dwelldisplay = "$dwelltime";
                                            KSTdisplay = "$KST";
                                          });
                                          ///////////////////////////////////

                                          _stopTimer();
                                          _resetTimer();
                                          //initState();
                                          _startTimer();
                                        }
                                        if (event is RawKeyUpEvent) {
                                          dwelltime = _milliseconds;
                                        }
                                        //test //print(event.runtimeType.toString());
                                      },
                                      //Algorithm--------------------------------------

                                      child: TextFormField(
                                        validator: MultiValidator([
                                          RequiredValidator(
                                            errorText:
                                                "Please input your email!",
                                          ),
                                          EmailValidator(
                                            errorText: "Invalid Email format!",
                                          ),
                                        ]),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onSaved: (String? email) {
                                          profile.email = email;
                                        },
                                      ),
                                    )),
                                const SizedBox(height: 15),
                                Row(
                                  children: const [
                                    Icon(Icons.lock_outline,
                                        color: Color(0xFF576CBE)),
                                    SizedBox(width: 10),
                                    //////////////////////////////////////
                                    Text(
                                      //"$KST",
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
=======
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
>>>>>>> ce32c03eddea770b005d750ee3ffb3bbbc23641d
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
<<<<<<< HEAD

                          const SizedBox(height: 15),
                          Center(
                              child: SizedBox(
=======
                        ),
                      // ),
                      SizedBox(height: 15),
                      Center(
                        child:SizedBox(
>>>>>>> ce32c03eddea770b005d750ee3ffb3bbbc23641d
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
