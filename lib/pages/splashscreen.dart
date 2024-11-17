// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:yo_chat_ai/pages/login.dart';

//defining providers

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // Set a timer to navigate after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff008efe),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Text to display
                Text(
                  "Yo AI Chat",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),

                //logo to display
                SizedBox(
                  height: 40,
                ),
                Image.asset('images/chatbot.jpg'),

                //progress indicator
                SizedBox(
                  height: 40,
                ),
                CircularProgressIndicator(
                  strokeWidth: 6,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
