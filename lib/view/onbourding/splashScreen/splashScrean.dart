import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/view/HomeScreen.dart';

class splashScrean extends StatefulWidget {
  const splashScrean({super.key});

  @override
  State<splashScrean> createState() => _splashScreanState();
}

class _splashScreanState extends State<splashScrean> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const Homescreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffDFECDB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

    
        ],
      ),
    );
  }
}
