import 'package:blog_app_with_firebase/golobal_wieght/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool showSpinner = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,

          ),
          title: const Text(
            "Create Accounts",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Register",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            // hintText: "User Name",
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onChanged: (String value) {
                          email = value;
                        },
                        validator: (value) {
                          return value!.isEmpty ? "Enter Your Email" : null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                            // hintText: "User Name",
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) {
                          return value!.isEmpty ? "Enter Your Password" : null;
                        },
                      ),
                    ],
                  )),
              RoundButton(
                  title: "Register",
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {

                        showSpinner =true;
                      });
                      try {
                        final user = await auth.createUserWithEmailAndPassword(
                            email: email.toString().trim(),
                            password: password.toString().trim());
                        if (user != null) {
                          print("Success");
                          toastMessage("Successfully Created");
                          setState(() {

                            showSpinner =false;
                          });
                        }
                      } catch (e) {
                        print(e.toString());
                        toastMessage(e.toString());
                        setState(() {

                          showSpinner =false;
                        });
                      }
                    }
                  },
                  color: Colors.deepPurple)
            ],
          ),
        ),
      ),
    );
  }
  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
