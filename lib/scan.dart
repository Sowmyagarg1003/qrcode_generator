import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class scanQRCode extends StatefulWidget {
  const scanQRCode({super.key});

  @override
  State<scanQRCode> createState() => _scanQRCodeState();
}

class _scanQRCodeState extends State<scanQRCode> {
  String qrResult = 'Scanned data will appear here';
  Future<void> scanqr() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (!mounted) {
        return;
      }
      setState(() {
        this.qrResult = qrCode.toString();
      });
      if (Uri.parse(this.qrResult).isAbsolute) {
        // Launch the URL
        await launch(this.qrResult);
      } else {
        // Handle the case when the scanned QR code is not a valid URL
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Invalid QR Code"),
              content: Text("The scanned QR code is not a valid URL."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } on PlatformException {
      qrResult = 'Fail to read QR code';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR code scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              qrResult,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: scanqr,
              child: Text('Scan QR code'),
            ),
          ],
        ),
      ),
    );
  }
}
