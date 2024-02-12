import 'package:credkit_lender/authpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CREDKiT Lender',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff0D1D2E),
        useMaterial3: true,
      ),
      home: const AuthPage(),
    );
  }
}
