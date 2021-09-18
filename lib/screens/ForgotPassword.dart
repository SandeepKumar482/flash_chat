import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  static const id = "forgotPasswordScreen";
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> with SingleTickerProviderStateMixin {
  static late String email;
  late AnimationController controller;
  late Animation animation, animation2;
  final _auth = FirebaseAuth.instance;

  @override
  Future<void> initState() async {

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutSine);
    animation2 =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
              decoration: kInputTextField,
            ),
          ),
          SizedBox(
            height:  10.0,
          ),
          RoundedButton(animation: animation, color: Colors.blueAccent, onTap: (){
            _auth.sendPasswordResetEmail(email: email);
            Navigator.pop(context);
          }, title: 'Reset Password')
        ],
      ),
    );
  }
}

