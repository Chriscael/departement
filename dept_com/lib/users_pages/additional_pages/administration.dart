// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dept_com/utils/consttants.dart';
import 'package:flutter/material.dart';

class Administration extends StatefulWidget {
  const Administration({super.key});

  @override
  State<Administration> createState() => _AdministrationState();
}

class _AdministrationState extends State<Administration> {
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
          title: Text('Administration'),
          foregroundColor: white,
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                  color: Color(0xFF363f93),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF363f93).withOpacity(0.3),
                        offset: Offset(-10.0, 0.0),
                        blurRadius: 20.0,
                        spreadRadius: 4.0),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 40,
                      left: 0,
                      child: Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 20,
                      child: Text(
                        "Administration",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF363f93),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'LE DÉPARTEMENT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Administration',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
