// ignore_for_file: file_names

import 'package:credkit_lender/addRequest.dart';
import 'package:credkit_lender/duepayment.dart';
import 'package:credkit_lender/offeraccept.dart';
import 'package:credkit_lender/profile.dart';
import 'package:credkit_lender/requests.dart';
import 'package:credkit_lender/transitions.dart';
import 'package:flutter/material.dart';
//firebase auth
import 'package:firebase_auth/firebase_auth.dart';
//firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                'assets/notification.png',
                height: 25,
              ),
              onPressed: () {
                Navigator.push(
                    context, SlideRightRoute(page: const ProfilePage()));
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff0D1D2E),
              ),
              child: Text(
                'CREDKiT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
            ),
            ListTile(
              title: Text('Profile'),
            ),
            ListTile(
              title: Text('Settings'),
            ),
            ListTile(
              title: Text('Logout'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                  return Text(
                    'Hola ${snapshot.data!['name']}!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w300,
                      height: 0.07,
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
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                //navigate to duepayment.dart
                Navigator.push(context, FadeRoute(page: const DuePage()));
              },
              child: Container(
                width: double.infinity,
                height: 160,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2, color: Color(0xFFFFDABF)),
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
                            ).format(int.parse(snapshot.data!['due'])),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFFFF6900),
                              fontSize: 33,
                              fontFamily: 'Gotham',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${DateTime.parse(snapshot.data!['duedate'].toDate().toString()).day}/${DateTime.parse(snapshot.data!['duedate'].toDate().toString()).month}/${DateTime.parse(snapshot.data!['duedate'].toDate().toString()).year}',
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
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Your Offers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //get amount, pa, duration from collection 'offers' from document name with email
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('offers')
                  .doc(email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        if (snapshot.hasData && snapshot.data!.exists)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  SlideRightRoute(page: const MyRequests()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 80,
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 2,
                                    color: Color(0xFFFFDABF),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              NumberFormat.currency(
                                                locale: 'en_IN',
                                                symbol: '₹',
                                                decimalDigits: 0,
                                              ).format(int.parse(
                                                  snapshot.data!['amount'])),
                                              style: const TextStyle(
                                                color: Color(0xFFFF6900),
                                                fontSize: 19,
                                                fontFamily: 'Gotham',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              '${snapshot.data!['duration']} months',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontFamily: 'Gotham',
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '@ ${snapshot.data!['pa']} % pa.',
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            color: Color(0xFFFF6900),
                                            fontSize: 13,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const Text(
                                          'View >>',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFFFF6900),
                                            fontSize: 11,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.w300,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  SlideRightRoute(page: const AddRequest()));
                            },
                            child: Container(
                              width: double.infinity,
                              //height: 80,
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 2,
                                    color: Color(0xFFFFDABF),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'No Offer yet!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Add an Offer >>',
                                    style: TextStyle(
                                      color: Color(0xFFFF6900),
                                      fontSize: 11,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
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

            const SizedBox(
              height: 15,
            ),
            const Text(
              'All Requests',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //get amount, pa, duration from collection 'offers' from all documents
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('requests').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.docs.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              snapshot.data!.docs.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        SlideRightRoute(
                                            page: AcceptOffer(
                                                docid: snapshot
                                                    .data!.docs[index].id)));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 80,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 2,
                                          color: Color(0xFFFFDABF),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    NumberFormat.currency(
                                                      locale: 'en_IN',
                                                      symbol: '₹',
                                                      decimalDigits: 0,
                                                    ).format(int.parse(snapshot
                                                            .data!.docs[index]
                                                        ['amount'])),
                                                    style: const TextStyle(
                                                      color: Color(0xFFFF6900),
                                                      fontSize: 19,
                                                      fontFamily: 'Gotham',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${snapshot.data!.docs[index]['duration']} months',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontFamily: 'Gotham',
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '@ ${snapshot.data!.docs[index]['pa']} % pa.',
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                  color: Color(0xFFFF6900),
                                                  fontSize: 13,
                                                  fontFamily: 'Gotham',
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                              const Text(
                                                'View >>',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFFFF6900),
                                                  fontSize: 11,
                                                  fontFamily: 'Gotham',
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          //height: 80,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 2,
                                color: Color(0xFFFFDABF),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'No Offers yet!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Stay tuned.',
                                style: TextStyle(
                                  color: Color(0xFFFF6900),
                                  fontSize: 11,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(
                                height: 10,
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
          ],
        ),
      ),
    );
  }
}
