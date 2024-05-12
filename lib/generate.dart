import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/pointycastle.dart';

class generateQRCode extends StatefulWidget {
  const generateQRCode({super.key});

  @override
  State<generateQRCode> createState() => _generateQRCodeState();
}

class _generateQRCodeState extends State<generateQRCode> {
  TextEditingController senderController = TextEditingController();
  TextEditingController recipientController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Encrypted QR code'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (senderController.text.isNotEmpty &&
                  recipientController.text.isNotEmpty &&
                  amountController.text.isNotEmpty)
                generateEncryptedQRCode(),
              SizedBox(height: 10),
              buildTextField(senderController, 'Sender'),
              SizedBox(height: 10),
              buildTextField(recipientController, 'Recipient'),
              SizedBox(height: 10),
              buildTextField(amountController, 'Amount'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Generate Encrypted QR code'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Enter $labelText',
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget generateEncryptedQRCode() {
    // Extract data from text controllers
    final String sender = senderController.text;
    final String recipient = recipientController.text;
    final double amount = double.tryParse(amountController.text) ?? 0.0;

    // Create transaction object
    Map<String, dynamic> transactionData = {
      'sender': sender,
      'recipient': recipient,
      'amount': amount,
    };

    // Convert transaction data to JSON
    String transactionJson = jsonEncode(transactionData);

    // Encryption key (should be kept secure)
    final key = encrypt.Key.fromUtf8('YourEncryptionKey123');
    // final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    // final key = generateRandomKey();

    // Encrypt transaction data
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encryptedData = encrypter.encrypt(transactionJson, iv: iv);

    // Generate QR code with encrypted data
    return QrImageView(
      data: encryptedData.base64,
      version: QrVersions.auto,
      size: 200.0,
    );
  }
}
