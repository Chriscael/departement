// ignore_for_file: prefer_const_constructors_in_immutables, use_super_parameters, prefer_const_constructors, use_build_context_synchronously, avoid_print, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ReceiptGenerator extends StatefulWidget {
  ReceiptGenerator({Key? key}) : super(key: key);

  @override
  State<ReceiptGenerator> createState() => _ReceiptGeneratorState();
}

class _ReceiptGeneratorState extends State<ReceiptGenerator> {
  final _formKey = GlobalKey<FormState>();
  String? _qrCodeData;
  final storage = FlutterSecureStorage();

  final Map<String, TextEditingController> _controllers = {
    'FullName': TextEditingController(),
    'E-Mail Address': TextEditingController(),
    'Subject': TextEditingController(),
    'agency': TextEditingController(),
    'currency': TextEditingController(),
    'reason': TextEditingController(),
    'phoneNumber': TextEditingController(),
    'operationNumber': TextEditingController(),
    'amount': TextEditingController(),
    'date': TextEditingController(),
    'merchantName': TextEditingController(),
  };

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  Widget buildDateFormField(String labelText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: 'Select a date',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.black, // Set border color to black
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.black, // Set focused border color to black
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context, controller),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
      readOnly: true, // Prevent user from manually editing the field
    );
  }

  Widget buildTextFormField(String labelText, String hintText, {bool isEmail = false}) {
    return TextFormField(
      controller: _controllers[labelText],
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.black, // Set border color to black
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.black, // Set focused border color to black
          ),
        ),
      ),
      validator: isEmail
          ? _validateEmail
          : (value) {
              if (value!.isEmpty) {
                return 'Please enter $labelText';
              }
              return null;
            },
    );
  }

  Future<void> _generateQRCode() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _qrCodeData = jsonEncode({
          'fullName': _controllers['FullName']!.text,
          'emailAddress': _controllers['E-Mail Address']!.text,
          'subject': _controllers['Subject']!.text,
          'agency': _controllers['agency']!.text,
          'currency': _controllers['currency']!.text,
          'reason': _controllers['reason']!.text,
          'phoneNumber': _controllers['phoneNumber']!.text,
          'operationNumber': _controllers['operationNumber']!.text,
          'amount': _controllers['amount']!.text,
          'date': _controllers['date']!.text,
          'merchantName': _controllers['merchantName']!.text,
        });
      });
    }
  }

  Future<void> _sendMessage() async {
  if (_formKey.currentState!.validate()) {
    final receiptData = {
      'fullName': _controllers['FullName']!.text,
      'emailAddress': _controllers['E-Mail Address']!.text,
      'subject': _controllers['Subject']!.text,
      'agency': _controllers['agency']!.text,
      'currency': _controllers['currency']!.text,
      'reason': _controllers['reason']!.text,
      'phoneNumber': _controllers['phoneNumber']!.text,
      'operationNumber': _controllers['operationNumber']!.text,
      'amount': double.tryParse(_controllers['amount']!.text),
      'date': _controllers['date']!.text, // Date is already in correct format
      'merchantName': _controllers['merchantName']!.text,
      'qrCode': _qrCodeData,
    };

    try {
      final token = await storage.read(key: 'jwt'); // Read the stored token
      if (token == null) {
        throw 'Token is null. Please log in again.';
      }
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/receipts/submitreceipt'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include the token in the headers
        },
        body: jsonEncode(receiptData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Receipt submitted successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit receipt')),
        );
        print('Failed to submit receipt: ${response.body}');
      }
    } catch (error) {
      print('Error occurred: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Contact'),
          backgroundColor: Color(0xFF363f93),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTextFormField('FullName', 'Enter your fullname'),
                    SizedBox(height: 16),
                    buildTextFormField('E-Mail Address', 'Enter your email address', isEmail: true),
                    SizedBox(height: 16),
                    buildTextFormField('Subject', 'Enter the reason for this contact'),
                    SizedBox(height: 16),
                    buildTextFormField('agency', 'Enter the agency'),
                    SizedBox(height: 16),
                    buildTextFormField('currency', 'Enter the currency'),
                    SizedBox(height: 16),
                    buildTextFormField('reason', 'Enter the reason'),
                    SizedBox(height: 16),
                    buildTextFormField('phoneNumber', 'Enter the phone number'),
                    SizedBox(height: 16),
                    buildTextFormField('operationNumber', 'Enter the operation number'),
                    SizedBox(height: 16),
                    buildTextFormField('amount', 'Enter the amount'),
                    SizedBox(height: 16),
                    buildDateFormField('Date', _controllers['date']!),
                    SizedBox(height: 16),
                    buildTextFormField('merchantName', 'Enter the merchant name'),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _generateQRCode,
                      child: Text('Generate QR Code'),
                    ),
                    SizedBox(height: 16),
                    if (_qrCodeData != null)
                      Container(
                        alignment: Alignment.center,
                        child: QrImageView(
                          data: _qrCodeData!,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _sendMessage,
                      child: Text('SEND MESSAGE'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
