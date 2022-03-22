import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skootta/authentication/login_screen.dart';
import 'package:skootta/authentication/signup_screen.dart';
import 'package:skootta/clientApp/clientAuthentication/client_login_screen.dart';
import 'package:skootta/clientApp/clientMainScreens/client_main_screen.dart';
import 'package:skootta/mainScreens/main_screen.dart';
import 'package:skootta/globals/global.dart';

class ClientSplashScreen extends StatefulWidget {
  const ClientSplashScreen({Key? key}) : super(key: key);

  @override
  State<ClientSplashScreen> createState() => _ClientSplashScreenState();
}

class _ClientSplashScreenState extends State<ClientSplashScreen>
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
            Navigator.push(context, MaterialPageRoute(builder: (c) => ClientMainScreen()));
          }
          else
          {
            Navigator.push(context, MaterialPageRoute(builder: (c) => ClientLoginScreen()));
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
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
