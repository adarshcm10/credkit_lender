import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import cloud_firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRequest extends StatefulWidget {
  const AddRequest({super.key});

  @override
  State<AddRequest> createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  //text editing controllers for the 3 textfields
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _paController = TextEditingController();
  final String email = FirebaseAuth.instance.currentUser!.email.toString();
  bool _isChecked = false;
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                Image.asset('assets/request-post.png'),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Post Offer',
                  style: TextStyle(
                    color: Color(0xFFFF6900),
                    fontSize: 21,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  //height: 50,
                  child: TextField(
                    controller: _amountController,
                    cursorColor: const Color.fromARGB(133, 255, 255, 255),
                    // controller: _usernameController,
                    decoration: InputDecoration(
                      // hintText: 'Amount',
                      labelText: 'Amount',
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(129, 255, 255, 255),
                        fontSize: 16,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w300,
                      ),
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
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  //height: 50,
                  child: TextField(
                    controller: _paController,
                    cursorColor: const Color.fromARGB(133, 255, 255, 255),
                    // controller: _usernameController,
                    decoration: InputDecoration(
                      // hintText: 'Amount',
                      labelText: 'Interest Rate',
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(129, 255, 255, 255),
                        fontSize: 16,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w300,
                      ),
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
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  //height: 50,
                  child: TextField(
                    cursorColor: const Color.fromARGB(133, 255, 255, 255),
                    controller: _durationController,
                    decoration: InputDecoration(
                      // hintText: 'Amount',
                      labelText: 'Duration in months',
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(129, 255, 255, 255),
                        fontSize: 16,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w300,
                      ),
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
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                //gesture detector for the button post
                const SizedBox(
                  height: 30,
                ),
                //check box for terms and conditions
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: const Color(0xFFFF6900),
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    const Text(
                      'I agree to the terms and conditions',
                      style: TextStyle(
                        color: Color(0xFFFF6900),
                        fontSize: 13,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: _isChecked
                      ? () {
                          //add amount, interest rate, duration to collection 'requests' and document email
                          if (_amountController.text.isEmpty ||
                              _paController.text.isEmpty ||
                              _durationController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Soem fields are empty! Please fill all fields.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                backgroundColor: Color(0xFFFF6900),
                              ),
                            );
                          } else {
                            FirebaseFirestore.instance
                                .collection('offers')
                                .doc(email)
                                .set({
                              'amount': int.parse(_amountController.text),
                              'pa': int.parse(_paController.text),
                              'duration': int.parse(_durationController.text),
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Offer posted successfully!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                backgroundColor: Color(0xFFFF6900),
                              ),
                            );
                            //clear the textfields
                            _amountController.clear();
                            _paController.clear();
                            _durationController.clear();
                            //pop
                            Navigator.pop(context);
                          }
                        }
                      : () {
                          //snackbar to show accept terms and conditions
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please accept the terms and conditions',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              backgroundColor: Color(0xFFFF6900),
                            ),
                          );
                        },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6900),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'Post',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Gotham',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
