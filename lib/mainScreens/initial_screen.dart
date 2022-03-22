import 'package:flutter/material.dart';
import 'package:skootta/clientApp/clientSplashScreen/client_splash_screen.dart';
import 'package:skootta/splashScreen/splash_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
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
                "Select your preferred option",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),

              ElevatedButton(
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => MySplashScreen()));

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: const Text(
                      "Rider",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      )
                  )

              ),

              ElevatedButton(
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => ClientSplashScreen()));

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: const Text(
                      "Client",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      )
                  )

              ),
            ],
          ),
        ),
      ),
    );
  }
}
