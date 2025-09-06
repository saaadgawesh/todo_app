import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:todo_app/view/tabs/HomeScreen.dart';
import 'package:todo_app/view/widget/appthem.dart';

class splashScrean extends StatefulWidget {
  const splashScrean({super.key});

  @override
  State<splashScrean> createState() => _splashScreanState();
}

class _splashScreanState extends State<splashScrean> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Homescreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDFECDB),
      body: Container(
        decoration: const BoxDecoration(color: Appthem.primary),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Lottie.asset('assets/t.json')],
        ),
      ),
    );
  }
}
