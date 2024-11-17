// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Import Google Sign-In package
import 'package:yo_chat_ai/components/message.dart';
import 'package:yo_chat_ai/pages/login.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  final queryController = TextEditingController();

  // Initializing message list
  final List<Message> _messages = [
    Message(text: "Hi", isUser: true),
  ];

  // Google Sign-In instance
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Input controller
  final inputController = TextEditingController();

  // Function to log user out
  void logoutUser() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut(); // Ensure Google account is signed out
  }

  // Function to handle Google Sign-In
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase using the Google credential
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  // Call Gemini AI
  callGeminiAI() async {
    try {
      if (inputController.text.isNotEmpty) {
        _messages.add(Message(text: inputController.text, isUser: true));
      }
      final model = GenerativeModel(
          model: 'gemini-pro', apiKey: dotenv.env["GOOGLE_API_KEY"]!);
      final userPrompt = inputController.text.trim();
      final content = [Content.text(userPrompt)];
      final aiResponse = await model.generateContent(content);

      setState(() {
        _messages.add(Message(text: aiResponse.text!, isUser: false));
      });
      inputController.clear();
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: const Text(
            "Yo Chat AI",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Warning!"),
                          content: Text(
                              "Are you sure to Log out? If you intended to do so, click log out, else close"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close")),
                            ElevatedButton(
                                onPressed: () {
                                  logoutUser();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: Text("Log out"))
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
          backgroundColor: const Color(0xff008efe),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return ListTile(
                      title: Align(
                        alignment: message.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: message.isUser
                                    ? Color(0xff008efe)
                                    : Colors.grey[300],
                                borderRadius: message.isUser
                                    ? BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))
                                    : BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Text(
                              message.text,
                              style: TextStyle(
                                  color: message.isUser
                                      ? Colors.white
                                      : Colors.black),
                            )),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff008efe), width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: inputController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              hintText: "Ask YoAi..."),
                        )),
                    IconButton(onPressed: callGeminiAI, icon: Icon(Icons.send))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
