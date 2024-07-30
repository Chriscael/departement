// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:dept_com/utils/consttants.dart';
import 'package:flutter/material.dart';

class Organisation extends StatefulWidget {
  const Organisation({super.key});

  @override
  State<Organisation> createState() => _OrganisationState();
}

class _OrganisationState extends State<Organisation> {
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
          title: Text('Organisation'),
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
          foregroundColor: white,
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  buildContactSection(
                    'Directeur',
                    'Professeur Bastien CHOPARD',
                    'reçoit sur rendez-vous',
                    'bastien.chopard@unige.ch',
                    '+41 22 379 0219',
                  ),
                  SizedBox(height: 20),
                  buildContactSection(
                    'Conseiller aux études',
                    'Professeur Stéphane MARCHAND-MAILLET',
                    'reçoit sur rendez-vous',
                    'conseil-etu-info@unige.ch',
                    '+41 22 379 0154',
                  ),
                  SizedBox(height: 10),
//--------------------------------------------------------------------------------------
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              color: Colors.grey[850], // Deep grey color
                              child: Center(
                                child: Text(
                                  'Professeurs: 20',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              color: Colors.grey[850], // Deep grey color
                              child: Center(
                                child: Text(
                                  'Enseignants: 15',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              color: Colors
                                  .grey[850], // Consistent deep grey color
                              child: Center(
                                child: Text(
                                  'Assistant: 7',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              color: Colors
                                  .grey[850], // Consistent deep grey color
                              child: Center(
                                child: Text(
                                  'Responsable UE: 12',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  OrganisationPage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContactSection(
      String title, String name, String note, String email, String phone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          note,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 5),
        Text(
          email,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(
          'Tél.: $phone',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class OrganisationPage extends StatelessWidget {
  const OrganisationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          OrganisationCard(title: 'Responsables', value: 'Dr. John Doe'),
          OrganisationCard(title: 'Secrétariat', value: 'Ms. Jane Smith'),
          OrganisationCard(title: 'Nombre d\'Enseignants', value: '150'),
          OrganisationCard(title: 'Nombre de Chercheurs', value: '40'),
        ],
      ),
    );
  }
}

class OrganisationCard extends StatelessWidget {
  final String title;
  final String value;

  OrganisationCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
