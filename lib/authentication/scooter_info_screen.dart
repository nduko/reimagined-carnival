import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skootta/globals/global.dart';
import 'package:skootta/splashScreen/splash_screen.dart';

class ScooterInfoScreen extends StatefulWidget {
  const ScooterInfoScreen({Key? key}) : super(key: key);

  @override
  State<ScooterInfoScreen> createState() => _ScooterInfoScreenState();
}

class _ScooterInfoScreenState extends State<ScooterInfoScreen>
{
  TextEditingController scooterModelEditingController = TextEditingController();
  TextEditingController scooterNumberEditingController = TextEditingController();
  TextEditingController scooterColorEditingController = TextEditingController();

  List<String> scooterTypesList = ["model-1", "model-2", "model-3"];
  String? selectedScooterType;

  saveScooterInfo()
  {
    Map riderScooterInfoMap =
        {
          "scooter_color":  scooterColorEditingController.text.trim(),
          "scooter_number": scooterNumberEditingController.text.trim(),
          "scooter_model":  scooterModelEditingController.text.trim(),
          "type": selectedScooterType,
        };

    DatabaseReference ridersRef = FirebaseDatabase.instance.ref().child("riders");
    ridersRef.child(currentFirebaseUser!.uid).child("scooter_details").set(riderScooterInfoMap);

    Fluttertoast.showToast(msg: "Scooter details saved successfully");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              const SizedBox(height: 24,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("assets/icons/scooter-front-view.png"),
              ),

              const SizedBox(height: 10),

              const Text(
                "Scooter Details",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),


              TextField(
                controller: scooterModelEditingController,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Scooter Model",
                  hintText: "scooter model",
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
                controller: scooterNumberEditingController,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Scooter number",
                  hintText: "scooter number",
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
                controller: scooterColorEditingController,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Color",
                  hintText: "color",
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

              DropdownButton(
                iconSize: 30,
                dropdownColor: Colors.pink,
                  hint: const Text(
                    "Selected your preferred scooter type",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  value: selectedScooterType,
                onChanged: (newValue){
                    setState(() {
                      selectedScooterType =newValue.toString();
                    });
                },
                items: scooterTypesList.map((scooter){
                  return DropdownMenuItem(
                    child: Text(
                      scooter,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    value: scooter,
                  );
                }).toList(),
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                  onPressed: ()
                  {
                    if(scooterColorEditingController.text.isNotEmpty
                    && scooterNumberEditingController.text.isNotEmpty
                    && scooterModelEditingController.text.isNotEmpty
                    && selectedScooterType != null)
                      {
                        saveScooterInfo();
                      }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: const Text(
                      "Save Scooter Details",
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
