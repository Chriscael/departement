// ignore_for_file: prefer_const_constructors

import 'package:dept_com/users_pages/additional_pages/dashboards/admindash_page.dart';
import 'package:dept_com/users_pages/additional_pages/dashboards/cddash_page.dart';
import 'package:dept_com/users_pages/additional_pages/dashboards/teacherdash_page.dart';
import 'package:flutter/material.dart';
import 'package:dept_com/providers/user_provider.dart';
import 'package:dept_com/users_pages/additional_pages/dashboards/studentdash_page.dart';
import 'package:dept_com/users_pages/additional_pages/staff/staff.dart';
import 'package:dept_com/users_pages/authentication/login.dart';
import 'package:dept_com/users_pages/authentication/register.dart';
import 'package:dept_com/users_pages/buttom_nav_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider()..checkLoginStatus(),                        
        ),
        ChangeNotifierProvider(
          create: (_) => GradeCountProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'De-Com',
      home: Scaffold(
        body: HomePage(),
      ),
      routes: {
        '/staff': (context) => Staff(),
        '/home': (context) => HomePage(),
        '/signin': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/studentDashboard': (context) => StudentDashboardPage(),
        '/teacherDashboard': (context) => ManagerDashboardPage(),
        '/adminDashboard': (context) => AdminDashboardPage(),
        '/cdDashboard': (context) => CdDashboardPage(),
      },
    );
  }
}
