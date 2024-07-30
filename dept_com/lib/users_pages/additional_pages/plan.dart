// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dept_com/utils/consttants.dart';
import 'package:flutter/material.dart';

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
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
          title: Text('Plan'),
          foregroundColor: white,
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccessPage(),
            ],
          ),
        ),
      ),
    );
  }
}


class AccessPage extends StatelessWidget {
  const AccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How to Access the Facility',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'The facility is located at 123 Main St, and is accessible by both public transit and personal vehicles. Ample parking is available on-site. The nearest subway station is Central Station, a 10-minute walk away.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Coordinates',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Latitude: 40.7128 N\nLongitude: 74.0060 W',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
