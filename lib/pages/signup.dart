import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yo_chat_ai/components/my_textfield.dart';
import 'package:yo_chat_ai/components/mybutton.dart';
import 'package:yo_chat_ai/pages/login.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();

  //user sign up method
  void signupUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), password: pwController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //form title

                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                //Email textfield
                const SizedBox(
                  height: 30,
                ),
                MyTextfield(
                    myhinttext: "Email",
                    obscureText: false,
                    myController: emailController),

                //password textfield
                const SizedBox(
                  height: 15,
                ),
                MyTextfield(
                    myhinttext: "Password",
                    obscureText: true,
                    myController: pwController),

                // confirm password textfield
                const SizedBox(
                  height: 15,
                ),
                MyTextfield(
                    myhinttext: "Confirm Password",
                    obscureText: true,
                    myController: confirmPwController),

                // sign up button
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                    onTap: () {
                      signupUser();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: const Mybutton(btnTitle: "Sign Up")),
                // alternative sign in
                const SizedBox(
                  height: 25,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      )),

                      //text btn dividers
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Or continue with"),
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      ))
                    ],
                  ),
                ),

                //sign up with google option
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Google",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Image.asset(
                        'images/google-icon.png',
                        height: 30,
                      )
                    ],
                  ),
                ),

                //sign up instead
                const SizedBox(
                  height: 25,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Already have an account?",
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: const Text(
                          "Sign In",
                          style:
                              TextStyle(color: Color(0xff008efe), fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
