import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = "loginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation, animation2;
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  void initState() {
    email = '';
    password = '';
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

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kInputTextField,
              ),
              SizedBox(
                height: animation2.value * 10.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kInputTextField.copyWith(
                    hintText: 'Password', icon: Icon(Icons.password_rounded)),
              ),
              SizedBox(
                height: animation2.value * 24,
              ),
              Hero(
                tag: 'login',
                child: RoundedButton(
                  animation: animation,
                  color: Colors.lightBlueAccent,
                  onTap: () async {
                    // await Firebase.initializeApp();

                    try {
                      setState(() {
                        showSpinner = true;
                      });
                      final oldUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      print(oldUser);
                      if (oldUser != null) {
                        setState(() {
                          showSpinner = false;
                        });
                        Navigator.pushNamed(context, ChatScreen.id);
                        email = '';
                        password = '';
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  title: 'Login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
