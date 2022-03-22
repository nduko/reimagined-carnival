import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skootta/clientApp/clientAuthentication/client_signup_screen.dart';
import 'package:skootta/clientApp/clientGlobals/client_globals.dart';
import 'package:skootta/clientApp/clientSplashScreen/client_splash_screen.dart';
import 'package:skootta/clientApp/clientWidgets/client_progress_dialog.dart';

class ClientLoginScreen extends StatefulWidget {
  const ClientLoginScreen({Key? key}) : super(key: key);

  @override
  State<ClientLoginScreen> createState() => _ClientLoginScreenState();
}

class _ClientLoginScreenState extends State<ClientLoginScreen>
{
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm()
  {
    if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not valid");
    }

    else if(passwordTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password is required");
    }
    else
    {
      loginClient();
    }
  }

  loginClient() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, please wait ",);
        }
    );

    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Log in successful");
      Navigator.push(context, MaterialPageRoute(builder: (c) => const ClientSplashScreen()));
    }
    else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Log in failed. Please try again");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(20.0,),
                child: Image.asset("assets/icons/scooter.png"),
              ),

              Text(
                "Login as Client",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),


              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Email address",
                  hintText: "Email address",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                  onPressed: ()
                  {
                    validateForm();

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      )
                  )

              ),

              TextButton(
                child: const Text(
                  "Don't have an account? Sign up here",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c) => ClientSignupScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
