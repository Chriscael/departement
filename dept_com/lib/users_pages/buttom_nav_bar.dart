// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api

import 'package:dept_com/utils/consttants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dept_com/providers/user_provider.dart';
import 'package:dept_com/users_pages/les_formation.dart';
import 'package:dept_com/users_pages/academics.dart';
import 'package:dept_com/users_pages/additional_pages/menu.dart';
import 'package:dept_com/users_pages/departement.dart';
import 'package:dept_com/users_pages/home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigationBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<AuthProvider>(context, listen: false).checkLoginStatus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      WelcomePage(),
      AcademicsPage(),
      LesFormation(),
      StudentPage(),
    ];

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
        drawer: Menu(),
        appBar: AppBar(
          foregroundColor: white,
          title: Text(
            'CSD-Univ',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
          actions: [
            IconButton(
              icon: Icon(Icons.person_2_sharp, color: Colors.white),
              onPressed: () {
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                if (authProvider.isLoggedIn) {
                  Navigator.pushNamed(
                      context, getPageForUser(authProvider.userType));
                } else {
                  Navigator.pushNamed(context, '/signin');
                }
              },
            )
          ],
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
            child: GNav(
              backgroundColor: Colors.black38,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              gap: 8,
              padding: EdgeInsets.all(10),
              tabs: [
                GButton(
                  icon: Icons.home_sharp,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.school_sharp,
                  text: "My Academics",
                ),
                GButton(
                  icon: Icons.notifications_sharp,
                  text: "Formation",
                ),
                GButton(
                  icon: Icons.person_2_sharp,
                  text: "Le Departement",
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: _navigationBottomBar,
            ),
          ),
        ),
      ),
    );
  }

  String getPageForUser(String userType) {
    switch (userType) {
      case 'student':
        return '/studentDashboard';
      case 'manager':
        return '/managerDashboard';
      case 'admin':
        return '/adminDashboard';
      default:
        return '/signin'; // Default sign up page
    }
  }
}
