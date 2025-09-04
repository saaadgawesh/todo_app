import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/appthem.dart';
import 'package:todo_app/view/HomeScreen.dart';
import 'package:todo_app/view/authentication/register.dart';

import 'package:todo_app/view/tasks/defaultelevatedbotton.dart';
import 'package:todo_app/view/tasks/defaulttextfield.dart';
import 'package:todo_app/viewmodel/firebasefunctions.dart';
import 'package:todo_app/viewmodel/shared/sharedpref.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool password = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Defaulttextfield(
                controller: emailcontroller,
                label: 'Email',
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.length < 3 ||
                      !value.contains('@')) {
                    return 'Email cannot be empty';
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
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.length < 8) {
                    return 'Password cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: height),
              DefaultElevatedButton(
                label: 'Login',
                onpress: () async {
                  if (formkey.currentState!.validate()) {
                    try {
                      var user = await Firebasefunctions.login(
                        email: emailcontroller.text.trim(),
                        password: passwordcontroller.text.trim(),
                      );

                      if (context.mounted) {
                        // ✅ خزّن الاسم والبريد في SharedPreferences
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
                    } catch (error) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login failed: $error')),
                        );
                      }
                    }
                  }
                },
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Register()),
                  );
                },
                icon: const Text(
                  'Don’t have an account? Sign up',
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
