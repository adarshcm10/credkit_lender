import 'package:credkit_lender/home.dart';
import 'package:credkit_lender/transitions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import cloud_firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPan extends StatefulWidget {
  const AddPan({super.key});

  @override
  State<AddPan> createState() => _AddPanState();
}

class _AddPanState extends State<AddPan> {
  TextEditingController panController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  //get user email
  final String email = FirebaseAuth.instance.currentUser!.email.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/logo-small.png',
                height: 25,
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Image.asset('assets/pan-img.png'),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Verify your ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'PAN',
                      style: TextStyle(
                        color: Color(0xFFFF6D00),
                        fontSize: 25,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 30, left: 30),
                child: TextField(
                  cursorColor: const Color.fromARGB(133, 255, 255, 255),
                  controller: panController,
                  decoration: InputDecoration(
                    hintText: 'PAN Number',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(129, 255, 255, 255),
                      fontSize: 16,
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(170, 255, 255, 255),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color.fromARGB(206, 255, 255, 255),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 30, left: 30),
                child: TextField(
                  cursorColor: const Color.fromARGB(133, 255, 255, 255),
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(129, 255, 255, 255),
                      fontSize: 16,
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(170, 255, 255, 255),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color.fromARGB(206, 255, 255, 255),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: GestureDetector(
                  onTap: () {
                    //save pan and phone number to collection 'userdata' and doc widget.email
                    FirebaseFirestore.instance
                        .collection('userdata')
                        .doc(email)
                        .set({
                      'pan': panController.text,
                      'phone': phoneController.text
                    }, SetOptions(merge: true));

                    Navigator.push(
                        context, FadeRoute(page: const SpalshScreen()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFF6D00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      'Verify and Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Gotham Black',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to your desired screen here
      Navigator.pushReplacement(context, FadeRoute(page: const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/splash.gif',
          //
        ),
      ),
    );
  }
}
