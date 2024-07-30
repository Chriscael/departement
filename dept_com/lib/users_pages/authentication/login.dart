// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_build_context_synchronously

import 'package:dept_com/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>(); // GlobalKey for the Form
  final storage = FlutterSecureStorage();

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
        appBar: AppBar(
          title: Text(
            'Sign In',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF363f93), // Customizing app bar color
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Customizing text color
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _identifierController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Identifier',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "Enter your identifier",
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: validateIdentifier,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "Enter your email",
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: validateEmail,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        validator: _validatePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "Enter your password",
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            color: Colors.black.withOpacity(0.7),
                            icon: Icon(
                              hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        obscureText: hidePassword,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SIGN IN',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: _signIn,
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF363f93),
                              ),
                              child: Icon(Icons.arrow_forward,
                                  color: Colors.white, size: 30),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/signup');
                            },
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
  if (_formKey.currentState!.validate()) {
    var url = Uri.parse('http://127.0.0.1:8000/signin'); // Correct URL path
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'identifier': _identifierController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        await storage.write(key: 'jwt', value: data['token']); // Storing the token
        await storage.write(key: 'userType', value: data['userType']);
        Provider.of<AuthProvider>(context, listen: false).checkLoginStatus();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signed in successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        print('Signed IN successfully!');
        // Handling navigation based on user type
        _navigateBasedOnUserType(data['userType']);
      } else {
        print('Failed to sign in with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sign in: ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('An error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

  String? validateIdentifier(String? value) {
    RegExp studentPattern = RegExp(r'^[0-9]{2}[A-Z][0-9]{4}$');
    RegExp teacherPattern = RegExp(r'^[0-9]{2}[A-Z]{2}[0-9]{4}$');
    RegExp cdPattern = RegExp(r'^[0-9]{2}[A-Z]{3}[0-9]{3}$'); // Corrected CD pattern
    RegExp adminPattern = RegExp(r'^[0-9]{2}[A-Z]{2}[0-9]{3}$');
    if (value == null ||
        (!studentPattern.hasMatch(value) &&
            !teacherPattern.hasMatch(value) &&
            !cdPattern.hasMatch(value) &&
            !adminPattern.hasMatch(value))) {
      return 'Invalid identifier format';
    }
    return null;
  }

  String? validateEmail(String? value) {
    RegExp emailPattern = RegExp(r'^[a-zA-Z]+\.[a-zA-Z]+@facsciences-uy1\.cm$');
    if (value == null || !emailPattern.hasMatch(value)) {
      return 'Invalid university email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _navigateBasedOnUserType(String? userType) {
    switch (userType) {
      case 'student':
        Navigator.pushReplacementNamed(context, '/studentDashboard');
        break;
      case 'teacher':
        Navigator.pushReplacementNamed(context, '/teacherDashboard');
        break;
      case 'CD':
        Navigator.pushReplacementNamed(context, '/cdDashboard');
        break;
      case 'admin':
        Navigator.pushReplacementNamed(context, '/adminDashboard');
        break;
      default:
        print('Unknown or missing user type');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful but user type is unknown'),
            backgroundColor: Colors.orange,
          ),
        );
        break;
    }
  }
}
