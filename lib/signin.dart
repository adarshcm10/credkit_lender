import 'package:credkit_lender/home.dart';
import 'package:credkit_lender/signup.dart';
import 'package:credkit_lender/transitions.dart';
import 'package:flutter/material.dart';
//import firebase_auth
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = true;
  var icon = Icons.visibility_off;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Image.asset('assets/signin-img.png'),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Hello again!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFF6D00),
                    fontSize: 30,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'We missed you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w400,
                      height: 0.8),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, right: 30, left: 30),
                  child: SizedBox(
                    width: double.infinity,
                    //height: 50,
                    child: TextField(
                      cursorColor: const Color.fromARGB(133, 255, 255, 255),
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Email Address',
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
                    //height: 50,
                    child: TextField(
                      cursorColor: const Color.fromARGB(133, 255, 255, 255),
                      controller: _passwordController,
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
                  padding: const EdgeInsets.only(right: 30, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'forgot password?',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w300,
                            height: 0.09,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: GestureDetector(
                    onTap: () {
                      //check if any of the fields are empty
                      if (_usernameController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        //show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please fill all the fields.',
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
                        //check if the email is valid using regex
                        RegExp emailRegex = RegExp(
                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                        if (!emailRegex.hasMatch(_usernameController.text)) {
                          //show snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              elevation: 1,
                              content: Text(
                                'Please enter a valid email address.',
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
                          //sign in the user using firebase_auth
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _usernameController.text,
                                  password: _passwordController.text)
                              .then((value) {
                            //navigate to home screen using fade transition
                            Navigator.pushReplacement(
                                context, FadeRoute(page: const SpalshScreen()));
                          }).catchError((e) {
                            //show snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                elevation: 1,
                                content: Text(
                                  'An error occured. Please try again.',
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
                          'Sign In',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Gotham Black',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Doesn\'t have an account?',
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
                        context, SlideRightRoute(page: const SignUp()));
                  },
                  child: const Text(
                    'Sign up here.',
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
    );
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
      Navigator.push(context, FadeRoute(page: const HomePage()));
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
