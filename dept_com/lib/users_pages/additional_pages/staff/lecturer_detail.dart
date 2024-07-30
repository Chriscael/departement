// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables

import 'package:dept_com/users_pages/additional_pages/staff/staff.dart';
import 'package:dept_com/utils/consttants.dart';
import 'package:flutter/material.dart';

class Ldetail extends StatefulWidget {
  final Student student;

  const Ldetail({super.key, required this.student});

  @override
  State<Ldetail> createState() => _LdetailState();
}

class _LdetailState extends State<Ldetail> {
  @override
  Widget build(BuildContext context) {
    final student = widget.student;
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
          foregroundColor: white,
          title: Text('Details on ${student.firstName}'),
          backgroundColor: Color(0xFF363f93),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BusinessCard(
                  student: student,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BusinessCard extends StatelessWidget {
  final Student student;

  const BusinessCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      elevation: 8.0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        height: 300,
        width: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatarWithFallback(
                  imageUrl: student.image,
                  fallbackAsset: 'assets/images/50.jpg',
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 150,
                        color: Colors.black54,
                        height: 2,
                      ),
                      const SizedBox(height: 4),
                      Text(student.Responsabilite, softWrap: true),
                      Text(student.AdresseMail, softWrap: true),
                      Text(student.grade, softWrap: true),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.firstName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(student.Domaines, softWrap: true),
                      Text(student.Adresse, softWrap: true),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        student.Telephone,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(student.Responsabilite, softWrap: true),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CircleAvatarWithFallback extends StatefulWidget {
  final String imageUrl;
  final String fallbackAsset;

  const CircleAvatarWithFallback({
    super.key,
    required this.imageUrl,
    required this.fallbackAsset,
  });

  @override
  _CircleAvatarWithFallbackState createState() =>
      _CircleAvatarWithFallbackState();
}

class _CircleAvatarWithFallbackState extends State<CircleAvatarWithFallback> {
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: _hasError
          ? AssetImage(widget.fallbackAsset)
          : NetworkImage(widget.imageUrl) as ImageProvider,
      onBackgroundImageError: (_, __) {
        setState(() {
          _hasError = true;
        });
      },
    );
  }
}
