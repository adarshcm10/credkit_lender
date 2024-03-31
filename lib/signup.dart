// ignore_for_file: use_build_context_synchronously

import 'package:credkit_lender/pan.dart';
import 'package:credkit_lender/signin.dart';
import 'package:credkit_lender/transitions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import firebase_auth
import 'package:firebase_auth/firebase_auth.dart';
//import cloud_firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;
  var icon = Icons.visibility_off;
  var icon2 = Icons.visibility_off;
  void passwordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
      if (_passwordVisible) {
        icon = Icons.visibility;
      } else {
        icon = Icons.visibility_off;
      }
    });
  }

  void passwordVisibility2() {
    setState(() {
      _passwordVisible2 = !_passwordVisible2;
      if (_passwordVisible2) {
        icon2 = Icons.visibility;
      } else {
        icon2 = Icons.visibility_off;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SafeArea(
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
                Image.asset('assets/signup-img.png'),
                const SizedBox(
                  height: 30,
                ),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Create your ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w700,
                          height: 0.05,
                        ),
                      ),
                      TextSpan(
                        text: 'account',
                        style: TextStyle(
                          color: Color(0xFFFF6D00),
                          fontSize: 23,
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, right: 30, left: 30, top: 20),
                  child: SizedBox(
                    width: double.infinity,
                    // height: 50,
                    child: TextField(
                      cursorColor: const Color.fromARGB(133, 255, 255, 255),
                      controller: fullNameController,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
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
                ),
                //textfield with eye icon to show/hide password
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, right: 30, left: 30),
                  child: SizedBox(
                    width: double.infinity,
                    // height: 50,
                    child: TextField(
                      cursorColor: const Color.fromARGB(133, 255, 255, 255),
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email address',
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
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, right: 30, left: 30),
                  child: SizedBox(
                    width: double.infinity,
                    // height: 50,
                    child: TextField(
                      cursorColor: const Color.fromARGB(133, 255, 255, 255),
                      controller: passwordController,
                      obscureText: _passwordVisible,
                      decoration: InputDecoration(
                          hintText: 'Password',
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
                          suffixIcon: GestureDetector(
                            onTap: () {
                              passwordVisibility();
                            },
                            child: Icon(icon,
                                color:
                                    const Color.fromARGB(144, 250, 250, 250)),
                          )),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, right: 30, left: 30),
                  child: SizedBox(
                    width: double.infinity,
                    //height: 50,
                    child: TextField(
                      cursorColor: const Color.fromARGB(133, 255, 255, 255),
                      controller: confirmPasswordController,
                      obscureText: _passwordVisible2,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
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
                          suffixIcon: GestureDetector(
                            onTap: () {
                              passwordVisibility2();
                            },
                            child: Icon(icon2,
                                color:
                                    const Color.fromARGB(144, 250, 250, 250)),
                          )),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: GestureDetector(
                    onTap: () {
                      //check any field is empty
                      if (fullNameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          confirmPasswordController.text.isEmpty) {
                        //show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please fill all fields',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            backgroundColor: Color(0xFFFF6D00),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        //check email is valid using regex
                        if (RegExp(
                                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                            .hasMatch(emailController.text)) {
                          //check password and confirm password are same
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            //sign up user using firebase
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) async {
                              //get device token
                              String? deviceToken =
                                  await FirebaseMessaging.instance.getToken();
                              //add fullname to collection 'userdata' to doc email address of user to firestore
                              await FirebaseFirestore.instance
                                  .collection('userdata')
                                  .doc(emailController.text)
                                  .set({
                                'name': fullNameController.text,
                                'due': 0,
                                'token': deviceToken,
                              }, SetOptions(merge: true));

                              //navigate to pan page
                              Navigator.push(context,
                                  SlideRightRoute(page: const AddPan()));

                              //store token in firestore
                            }).catchError((e) {
                              //show snackbar
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Something went wrong',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  backgroundColor: Color(0xFFFF6D00),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            });
                          } else {
                            //show snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Password and Confirm Password are not same',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                backgroundColor: Color(0xFFFF6D00),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        } else {
                          //show snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please enter a valid email address',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              backgroundColor: Color(0xFFFF6D00),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
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
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Gotham Black',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Already have an account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, SlideRightRoute(page: const SignIn()));
                  },
                  child: const Text(
                    'Sign in here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFFFF6D00),
                      decorationThickness: 5,
                      color: Color(0xFFFF6D00),
                      fontSize: 18,
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
