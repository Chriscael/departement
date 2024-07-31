// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, avoid_print, use_build_context_synchronously, prefer_const_literals_to_create_immutables
import 'package:dept_com/users_pages/additional_pages/pdf/pdf_page.dart';
import 'package:dept_com/users_pages/additional_pages/pdf/receipt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';




class ReceiptView extends StatefulWidget {
  const ReceiptView({super.key});

  @override
  _ReceiptViewState createState() => _ReceiptViewState();
}

class _ReceiptViewState extends State<ReceiptView> {
  List<Map<String, dynamic>> receipts = [];
  final storage = FlutterSecureStorage();

  Future<void> fetchData() async {
    try {
      final token = await storage.read(key: 'jwt'); // Read the stored token
      if (token == null) {
        throw 'Token is null. Please log in again.';
      }
      print('Token: $token'); // Debugging output

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/viewreceipts'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include the token in the headers
        },
      );

      print('Response status: ${response.statusCode}'); // Debugging output
      print('Response body: ${response.body}'); // Debugging output

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          receipts = data.map((item) => item as Map<String, dynamic>).toList();
        });
      } else {
        print('Failed to load data: ${response.body}');
        throw Exception('Failed to load data: ${response.body}');
      }
    } catch (error) {
      print('Error fetching data: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void navigateToPdfPage(Map<String, dynamic> receipt) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfPage(
          fullName: receipt['fullName'],
          emailAddress: receipt['emailAddress'],
          subject: receipt['subject'],
          agency: receipt['agency'],
          currency: receipt['currency'],
          reason: receipt['reason'],
          phoneNumber: receipt['phoneNumber'],
          operationNumber: receipt['operationNumber'],
          amount: receipt['amount'],
          date: receipt['date'],
          merchantName: receipt['merchantName'],
          qrCode: receipt['qrCode'],
          schoolSignature: receipt['schoolSignature'], // Add this line
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Color(0xFF363f93),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Receipt View'),
          backgroundColor: Color(0xFF363f93),
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: receipts.isEmpty
              ? CircularProgressIndicator() // Show loading indicator
              : ListView.builder(
                  itemCount: receipts.length,
                  itemBuilder: (context, index) {
                    final receipt = receipts[index];
                    return Card(
                      margin: EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Text('Receipt ${index + 1}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${receipt['date']}'),
                            Text('Full Name: ${receipt['fullName']}'),
                            Text('Email: ${receipt['emailAddress']}'),
                            Text('Subject: ${receipt['subject']}'),
                            Text('Agency: ${receipt['agency']}'),
                            Text('Currency: ${receipt['currency']}'),
                            Text('Reason: ${receipt['reason']}'),
                            Text('Phone Number: ${receipt['phoneNumber']}'),
                            Text(
                                'Operation Number: ${receipt['operationNumber']}'),
                            Text('Amount: ${receipt['amount']}'),
                            Text('Merchant Name: ${receipt['merchantName']}'),
                            //Text('School Signature: ${receipt['schoolSignature']}'), // Add this line
                            SizedBox(height: 10),
                          ],
                        ),
                        onTap: () => navigateToPdfPage(receipt),
                      ),
                    );
                  },
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReceiptGenerator(),
              ),
            );
          },
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF363f93),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
