import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text(
                'My Offer',
                style: TextStyle(
                  color: Color(0xFFFF6900),
                  fontSize: 21,
                  fontFamily: 'Gotham',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            //get amount, duration and pa values from collection requests and cument email
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('offers')
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
                                  height: 10,
                                ),
                                Text(
                                  'For ${snapshot.data!.docs[0]['duration']} months',
                                  style: const TextStyle(
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
                                    decimalDigits: 2,
                                  ).format(int.parse(
                                      snapshot.data!.docs[0]['amount'])),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFFFF6900),
                                    fontSize: 33,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'at ${snapshot.data!.docs[0]['pa']}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          : const Center(child: Text('No data')),
                    ));
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: GestureDetector(
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection('offers')
                      .doc(email)
                      .delete();
                  Navigator.pop(context);
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
                      'Delete Offer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Gotham Black',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //delete document email from collection requests
          ],
        ),
      ),
    );
  }
}
