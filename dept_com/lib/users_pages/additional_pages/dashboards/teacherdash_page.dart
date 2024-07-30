// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dept_com/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class ManagerDashboardPage extends StatefulWidget {
  const ManagerDashboardPage({super.key});

  @override
  State<ManagerDashboardPage> createState() => _ManagerDashboardPageState();
}

class _ManagerDashboardPageState extends State<ManagerDashboardPage> {
  final storage = FlutterSecureStorage(); // This is the 'storage' instance

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (!authProvider.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/signin');
      });
    }
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
          leading: Navigator.canPop(context)
              ? BackButton(color: Colors.white)
              : null,
          title: Text('TEACHER', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
          actions: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(
                    context, '/home'); // Ensure this navigates as expected
              },
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(),
      ),
    );
  }
}
