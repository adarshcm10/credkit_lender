import 'package:credkit_lender/signin.dart';
import 'package:credkit_lender/signup.dart';
import 'package:credkit_lender/transitions.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Image.asset(
          'assets/logo-small.png',
          height: 25,
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/getstarted.png',
                //width device width - 60
                //width: MediaQuery.of(context).size.width - 60,
                //hei
              ),
              const SizedBox(
                height: 40,
              ),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Your financial\n',
                      style: TextStyle(
                        color: Color(0xFFCFD2D5),
                        fontSize: 30,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                    TextSpan(
                      text: 'freedom',
                      style: TextStyle(
                        color: Color(0xFFFF6D00),
                        fontSize: 30,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                    TextSpan(
                      text: ' starts \nhere.',
                      style: TextStyle(
                        color: Color(0xFFCFD2D5),
                        fontSize: 30,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '"Unlock limitless loan \noptions and fulfill \nyour financial needs, \nwith ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: 'zero',
                      style: TextStyle(
                        color: Color(0xFFFF6D00),
                        fontSize: 16,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: ' extra charges."',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, SlideRightRoute(page: const SignIn()));
                      },
                      child: Container(
                        width: 145,
                        height: 50,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFCFD2D5)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFCFD2D5),
                              fontSize: 20,
                              fontFamily: 'Gotham Black',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, SlideRightRoute(page: const SignUp()));
                      },
                      child: Container(
                        width: 145,
                        height: 50,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFFF6D00)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFF6D00),
                              fontSize: 20,
                              fontFamily: 'Gotham Black',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
