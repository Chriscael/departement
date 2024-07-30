// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:dept_com/services/db_services.dart';

class Enterprise extends StatefulWidget {
  const Enterprise({super.key});

  @override
  State<Enterprise> createState() => _EnterpriseState();
}

class _EnterpriseState extends State<Enterprise> {
  late Future<List<dynamic>> entrepriseData;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    entrepriseData = apiService.getEntreprise('informatique');
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
          title: Text('Enterprise'),
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<dynamic>>(
              future: entrepriseData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return _buildDefaultInfoCards();
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data!.map((item) {
                      return Column(
                        children: [
                          Text('Entreprise Partenaire'),
                          _buildInfoCard('Nom', item['nom'] ?? 'Rhema Group SARL', Icons.business),
                          _buildInfoCard('Adresse', item['adresse'] ?? 'Yaoundé, Cameroon', Icons.location_on),
                          _buildInfoCard('Secteur', item['secteur'] ?? 'Travel and Tourism', Icons.work),
                          _buildInfoCard('Contact', item['contact'] ?? '658833784', Icons.phone),
                          Divider(),
                        ],
                      );
                    }).toList(),
                  );
                } else {
                  return _buildDefaultInfoCards();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultInfoCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Entreprise Partenaire'),
        _buildInfoCard('Nom', 'Rhema Group SARL', Icons.business),
        _buildInfoCard('Adresse', 'Yaoundé, Cameroon', Icons.location_on),
        _buildInfoCard('Secteur', 'Travel and Tourism', Icons.work),
        _buildInfoCard('Contact', '658833784', Icons.phone),
        Divider(),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent, size: 40),
        title: Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        subtitle: Text(
          value,
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
      ),
    );
  }
}
