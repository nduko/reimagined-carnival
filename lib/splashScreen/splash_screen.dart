import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skootta/authentication/login_screen.dart';
import 'package:skootta/authentication/signup_screen.dart';
import 'package:skootta/mainScreens/main_screen.dart';
import 'package:skootta/globals/global.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen>
{
  startTimer()
  {
    Timer(
      const Duration(seconds: 3),
        () async
        {
          if(await fAuth.currentUser != null)

          {
            currentFirebaseUser = fAuth.currentUser;
            Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
          }
          else
            {
              Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
            }
        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material (
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/icons/scooter-front-view.png"),

                const SizedBox(height: 10),

                const  Text(
                  "Pull up and scoot",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}
