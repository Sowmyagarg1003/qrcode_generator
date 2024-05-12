import 'package:flutter/material.dart';
import 'package:qrcode_generator/generate.dart';
import 'package:qrcode_generator/homepage.dart';
import 'package:qrcode_generator/scan.dart';
import 'package:qrcode_generator/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initialisedApp();

  runApp(MyApp());
}

class Firebase {
  static initialisedApp() {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code generator',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: SignInScreen(),
    );
  }
}
