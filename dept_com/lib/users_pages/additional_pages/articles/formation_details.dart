// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class FDetail extends StatefulWidget {
  final Map<String, dynamic> data;

  const FDetail({super.key, required this.data});

  @override
  State<FDetail> createState() => _FDetailState();
}

class _FDetailState extends State<FDetail> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;

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
          title: Text('Detail de formation'),
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    data['Image'] ?? 'assets/images/13.jpg',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/13.jpg',
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    data['titre'] ?? 'Unknown Title',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF363f93),
                    ),
                  ),
                ),
                Divider(
                  color: Color(0xFF363f93),
                  thickness: 2,
                  height: 40,
                ),
                _buildInfoSection(
                  context,
                  icon: Icons.description,
                  title: 'Présentation',
                  content: data['presentation'] ?? 'No Presentation',
                ),
                _buildInfoSection(
                  context,
                  icon: Icons.school,
                  title: 'Admission',
                  content: data['admission'] ?? 'No Admission Information',
                ),
                _buildInfoSection(
                  context,
                  icon: Icons.map,
                  title: 'Parcours',
                  content: data['parcours'] ?? 'No Parcours Information',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, {required IconData icon, required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Color(0xFF363f93), size: 30),
                  SizedBox(width: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF363f93),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                content,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}