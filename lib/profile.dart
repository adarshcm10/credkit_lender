// ignore_for_file: use_build_context_synchronously

import 'package:credkit_lender/addRequest.dart';
import 'package:credkit_lender/duepayment.dart';
import 'package:credkit_lender/getstarted.dart';
import 'package:credkit_lender/requests.dart';
import 'package:credkit_lender/transitions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String email = FirebaseAuth.instance.currentUser!.email.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo-small.png',
          height: 25,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        //menubar.png for opening drawer. add things to make it work on scaffold
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(left: 30),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Image.asset(
                'assets/menubar.png',
                height: 25,
              ),
              // replace 'assets/menubar.png' with your image path
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        //at right side add notification icon
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Image.asset(
                'assets/home.png',
                height: 25,
              ),
              onPressed: () {
                //pop screen
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
          child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //container of background color 0D1D2E
          Container(
            color: const Color(0xff0D1D2E),
            height: 200,
            child: Center(child: Image.asset('assets/logo-small.png')),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: //40% of drawer width
                    0.15 * MediaQuery.of(context).size.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    //pop drawer
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Color(0xff0D1D2E),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Home',
                          style: TextStyle(
                            color: Color(0xff0D1D2E),
                            fontSize: 16,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                //gesture detector for profile
                GestureDetector(
                  onTap: () {
                    //pop drawer
                    Navigator.pop(context);
                    Navigator.push(context, FadeRoute(page: const DuePage()));
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.payment,
                        color: Color(0xff0D1D2E),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Earnings',
                          style: TextStyle(
                            color: Color(0xff0D1D2E),
                            fontSize: 16,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //gesture detector for profile
                GestureDetector(
                  onTap: () {
                    //pop drawer
                    Navigator.pop(context);
                    FirebaseFirestore.instance
                        .collection('requests')
                        .doc(email)
                        .get()
                        .then((doc) {
                      if (doc.exists) {
                        Navigator.push(
                            context, FadeRoute(page: const MyRequests()));
                      } else {
                        //navigfate to add request page
                        Navigator.push(
                            context, FadeRoute(page: const AddRequest()));
                      }
                    });
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.message,
                        color: Color(0xff0D1D2E),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'My Offers',
                          style: TextStyle(
                            color: Color(0xff0D1D2E),
                            fontSize: 16,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    //pop drawer
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color(0xffFF6D00),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            color: Color(0xffFF6D00),
                            fontSize: 16,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //add logout button at bottom
          const Spacer(),
          GestureDetector(
            onTap: () {
              //signout user
              FirebaseAuth.instance.signOut();
            },
            child: Container(
              color: const Color(0xffFF6D00),
              height: 50,
              child: const Center(
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text('My Profile',
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            //get name from collection 'userdata' and document with email
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('userdata')
                  .doc(email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Name:',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              snapshot.data!['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Email:',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              email,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w300,
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, SlideRightRoute(page: const DuePage()));
                },
                child: Container(
                  width: double.infinity,
                  height: 160,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 2, color: Color(0xFFFFDABF)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                      //get due data from collection 'userdata' and document with email
                      StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('userdata')
                        .doc(email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Upcoming',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              NumberFormat.currency(
                                locale: 'en_IN',
                                symbol: '₹',
                                decimalDigits: 0,
                              ).format(double.parse(
                                  snapshot.data!['due'].toString())),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFFFF6900),
                                fontSize: 33,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              (snapshot.data!.data() as Map<String, dynamic>)
                                      .containsKey('duedate')
                                  ? '${DateTime.parse(snapshot.data!['duedate'].toDate().toString()).day}/${DateTime.parse(snapshot.data!['duedate'].toDate().toString()).month}/${DateTime.parse(snapshot.data!['duedate'].toDate().toString()).year}'
                                  : 'No Payment to receive',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const Text(
                              'View >>',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFF6900),
                                fontSize: 16,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        );
                      } else {
                        return const Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w300,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 60),
              child: GestureDetector(
                onTap: () async {
                  //sign out
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context, SlideRightRoute(page: const GetStarted()));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error signing out: $e')),
                    );
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
                      'Sign Out',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Gotham Black',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
