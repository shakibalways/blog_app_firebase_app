import 'package:blog_app_with_firebase/golobal_wieght/round_button.dart';
import 'package:blog_app_with_firebase/view/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool showSpinner = false;
  TextEditingController userController = TextEditingController();
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
          title:  const Text(
            "LogIn",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "LogIn",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                           hintText: "User Name",
                            labelText: "Email",
                            prefixIcon: const Icon(Icons.alternate_email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onChanged: (String value) {
                          email = value;
                        },
                        validator: (value) {
                          return value!.isEmpty ? "Enter Your Email" : null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                           hintText: "User Name",
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.password),
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
                  title: "Login",
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {

                        showSpinner =true;
                      });
                      try {
                        final user = await auth.signInWithEmailAndPassword(
                            email: email.toString().trim(),
                            password: password.toString().trim());
                        if (user != null) {
                          print("Success");
                          toastMessage("Successfully Created");
                          setState(() {

                            showSpinner =false;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
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
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
