// ignore_for_file: non_constant_identifier_names, unnecessary_to_list_in_spreads, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dept_com/utils/consttants.dart';
import 'package:flutter/material.dart';
import 'lecturer_detail.dart';
import 'package:dept_com/services/db_services.dart';

class Staff extends StatefulWidget {
  const Staff({super.key});

  @override
  State<Staff> createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  late Future<List<dynamic>> enseignantData;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    enseignantData = apiService.getEnseignant('informatique');
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
          title: Text('STAFF'),
          foregroundColor: white,
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STAFF',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              FutureBuilder<List<dynamic>>(
                future: enseignantData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return _buildStaffTable(context, []);
                  } else if (snapshot.hasData) {
                    return _buildStaffTable(context, snapshot.data!);
                  } else {
                    return _buildStaffTable(context, []);
                  }
                },
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStaffTable(BuildContext context, List<dynamic> data) {
    if (data.isEmpty) {
      // Default data if API call fails
      data = [
        {
          'image': 'assets/images/50.jpg',
          'nom complet': 'Default Name',
          'grade': 'Default Grade',
          'domainesExpertise': 'N/A',
          'telephone': 'N/A',
          'adresseMail': 'N/A',
          'responsabilite': 'N/A',
        }
      ];
    }

    return Table(
      border: TableBorder.all(color: Colors.white),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[200]),
          children: [
            TableCell(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "IMAGE",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "NAME",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "GRADE",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "PLUS INFO",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "MODIFIER",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
        ...data.map(
          (item) {
            return TableRow(
              children: [
                TableCell(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: item['Image'] != null
                          ? Image.network(
                              _getFullImageUrl(item['Image']),
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/images/50.jpg');
                              },
                              fit: BoxFit.cover,
                            )
                          : Image.asset('assets/images/50.jpg',
                              fit: BoxFit.cover),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        item['nomComplet'] ?? 'Default Name',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        item['grade'] ?? 'Default Grade',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ldetail(
                              student: Student(
                                image: _getFullImageUrl(item['Image']),
                                firstName: item['nomComplet'] ?? 'Default Name',
                                grade: item['grade'] ?? 'Default Grade',
                                Domaines: item['domainesExpertise'] ?? 'N/A',
                                Telephone: item['telephone'] ?? 'N/A',
                                AdresseMail: item['email'] ?? 'N/A',
                                Adresse: item['adresse'] ?? 'N/A',
                                Responsabilite: item['responsabilite'] ?? 'N/A',
                              ),
                            ),
                          ),
                        ),
                        icon: Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ).toList(),
      ],
    );
  }
}

class Student {
  final String firstName;
  final String grade;
  final String Telephone;
  final String Domaines;
  final String AdresseMail;
  final String Adresse;
  final String Responsabilite;
  final String image;

  Student({
    required this.Adresse,
    required this.firstName,
    required this.grade,
    required this.Domaines,
    required this.Telephone,
    required this.Responsabilite,
    required this.AdresseMail,
    required this.image,
  });
}

String _getFullImageUrl(String imagePath) {
  const String baseUrl = 'https://backend-form-1-5hj5.onrender.com';
  if (imagePath.startsWith('/')) {
    return '$baseUrl$imagePath';
  } else {
    return '$baseUrl/$imagePath';
  }
}
