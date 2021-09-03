import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = "welcomeScreen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation, animation2;
  bool showSpinner = false;

  @override
  void initState() {
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
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60.0,
                    ),
                  ),
                  Text(
                    'Flash Chat',
                    style: TextStyle(
                      fontSize: animation2.value * 46,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: animation2.value * 48.0,
              ),
              Hero(
                tag: 'login',
                child: RoundedButton(
                  animation: animation,
                  color: Colors.lightBlueAccent,
                  onTap: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    await Firebase.initializeApp();
                    setState(() {
                      showSpinner = false;
                    });
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  title: 'login',
                ),
              ),
              Hero(
                tag: 'register',
                child: RoundedButton(
                  animation: animation,
                  color: Colors.blueAccent,
                  onTap: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    await Firebase.initializeApp();
                    setState(() {
                      showSpinner = false;
                    });
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  title: 'Register',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
