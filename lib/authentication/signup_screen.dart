import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skootta/authentication/login_screen.dart';
import 'package:skootta/authentication/scooter_info_screen.dart';
import 'package:skootta/globals/global.dart';
import 'package:skootta/widgets/progress_dialog.dart';


class SignupScreen extends StatefulWidget
{
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
{

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm()
  {
    if(nameTextEditingController.text.length < 3)
      {
        Fluttertoast.showToast(msg: "name must be at least 3 characters");
      }
    else if(!emailTextEditingController.text.contains("@"))
      {
        Fluttertoast.showToast(msg: "Email address is not valid");
      }
    else if(phoneTextEditingController.text.isEmpty)
      {
        Fluttertoast.showToast(msg: "Phone number is required");
      }
    else if(passwordTextEditingController.text.length < 6)
      {
        Fluttertoast.showToast(msg: "Password must be at least 6 characters");
      }
    else
      {
          saveDriverInfo();
      }
  }

  saveDriverInfo() async
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
        await fAuth.createUserWithEmailAndPassword(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
        Map ridersMap =
            {
              "id" : firebaseUser.uid,
              "name" : nameTextEditingController.text.trim(),
              "email" : emailTextEditingController.text.trim(),
              "phone" : phoneTextEditingController.text.trim(),
            };

        DatabaseReference ridersRef = FirebaseDatabase.instance.ref().child("riders");
        ridersRef.child(firebaseUser.uid).set(ridersMap);

        currentFirebaseUser = firebaseUser;
        Fluttertoast.showToast(msg: "Account created successfully");
        Navigator.push(context, MaterialPageRoute(builder: (c) => ScooterInfoScreen()));
    }
    else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Failed to create account");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("assets/icons/scooter-front-view.png"),
              ),

              const SizedBox(height: 10),

              Text(
                "Register as a rider",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),


              TextField(
                controller: nameTextEditingController,
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
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "phone number",
                  hintText: "phone number",
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ScooterInfoScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    )
                  )

              ),

              TextButton(
                child: const Text(
                  "Already have an account? Log in here",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
