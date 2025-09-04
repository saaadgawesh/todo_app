import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/appthem.dart';
import 'package:todo_app/view/homeScreen.dart';
import 'package:todo_app/view/tasks/defaultelevatedbotton.dart';
import 'package:todo_app/view/tasks/defaulttextfield.dart';
import 'package:todo_app/viewmodel/firebasefunctions.dart';
import 'package:todo_app/viewmodel/shared/sharedpref.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      appBar: AppBar(title: const Text('Create an account'), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Defaulttextfield(
                controller: namecontroller,
                label: 'Name',
                validator: (value) {
                  if (value == null || value.length < 3) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
              ),
              SizedBox(height: height),
              Defaulttextfield(
                controller: emailcontroller,
                label: 'Email',
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.length < 3 ||
                      !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: height),
              Defaulttextfield(
                controller: passwordcontroller,
                label: 'Password',
                ispassword: true,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
              ),
              SizedBox(height: height),
              DefaultElevatedButton(
                label: 'Register',
                onpress: () async {
                  if (formkey.currentState!.validate()) {
                    try {
                      var user = await Firebasefunctions.register(
                        email: emailcontroller.text.trim(),
                        password: passwordcontroller.text.trim(),
                        name: namecontroller.text.trim(),
                      );

                      if (context.mounted) {
                        // ✅ خزّن الاسم في SharedPreferences
                        await UserPrefs.saveUser(
                          id: user.id,
                          name: user.name,
                          email: user.email,
                        );

                        // ✅ حدث الـ Provider
                        Provider.of<UserProvider>(
                          context,
                          listen: false,
                        ).setUser(user);
                        // ✅ روح للـ HomeScreen
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Homescreen(),
                          ),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.message ?? 'Something went wrong'),
                          ),
                        );
                      }
                      if (e.code == 'email-already-in-use') {
                        if (context.mounted) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Homescreen(),
                            ),
                          );
                        }
                      }
                    }
                  }
                },
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Homescreen()),
                  );
                },
                icon: const Text(
                  'Already have an account? Login',
                  style: TextStyle(color: Appthem.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
