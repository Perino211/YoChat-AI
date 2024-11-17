// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  const Mybutton({super.key, required this.btnTitle});

  final String btnTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(
          btnTitle,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
