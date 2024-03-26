import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DuePage extends StatefulWidget {
  const DuePage({super.key});

  @override
  State<DuePage> createState() => _DuePageState();
}

class _DuePageState extends State<DuePage> {
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
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(left: 30),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Image.asset(
                'assets/menubar.png',
                height: 25,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('userdata')
                    .where(email)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const //circulat progress indicator
                        Center(
                      child: Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    );
                  }

                  return Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Container(
                        width: double.infinity,
                        //height: 131,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 2, color: Color(0xFFFFDABF)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: snapshot.data!.docs.isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    '${snapshot.data!.docs[0]['duedate'].toDate().difference(DateTime.now()).inDays} days left for the next pay of',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'en_IN',
                                      symbol: '₹',
                                      decimalDigits: 0,
                                    ).format(double.parse(snapshot
                                        .data!.docs[0]['due']
                                        .toString())),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFFFF6900),
                                      fontSize: 33,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'On ${DateFormat('dd-MM-yyyy').format(snapshot.data!.docs[0]['duedate'].toDate())}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              )
                            : const Center(child: Text('No data')),
                      ));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Text('Recent Payments',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w300,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //display amount and date from collection userdata , document email and subcollection history
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('userdata')
                    .doc(email)
                    .collection('history')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    );
                  }

                  return snapshot.data!.docs.isNotEmpty
                      ? Column(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, bottom: 10),
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 2, color: Color(0xFFFFDABF)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'en_IN',
                                          symbol: '₹',
                                          decimalDigits: 0,
                                        ).format(double.parse(
                                            data['amount'].toString())),
                                        style: const TextStyle(
                                          color: Color(0xFFFF6900),
                                          fontSize: 16,
                                          fontFamily: 'Gotham',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('dd-MM-yyyy')
                                            .format(data['date'].toDate()),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Gotham',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 2, color: Color(0xFFFFDABF)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Center(
                              child: Text('No recent transaction',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.w300,
                                  )),
                            ),
                          ),
                        );
                },
              )
              //
            ],
          ),
        ),
      ),
    );
  }
}
