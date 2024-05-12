import 'package:flutter/material.dart';
import 'package:qrcode_generator/generate.dart';
import 'package:qrcode_generator/scan.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR code scanner and generator'),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(
                  () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => scanQRCode()));
                  },
                );
              },
              child: Text('scan QR code'),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => generateQRCode()));
                },
                child: Text('Generate QR code')),
          ],
        ),
      ),
    );
  }
}