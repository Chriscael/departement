// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:dept_com/services/db_services.dart';
import 'package:dept_com/utils/consttants.dart';
import 'package:flutter/material.dart';

class Actualite extends StatefulWidget {
  const Actualite({super.key});

  @override
  State<Actualite> createState() => _ActualiteState();
}

class _ActualiteState extends State<Actualite> {
  late Future<List<dynamic>> actualiteData;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    actualiteData = apiService.getActualite('informatique');
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
          title: Text('Actualite'),
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
          foregroundColor: white,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<List<dynamic>>(
            future: actualiteData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data!.isEmpty) {
                // Default data if API call fails or returns no data
                return _buildEventCards([
                  {
                    'image': 'assets/images/25.jpg',
                    'titre': 'Default Title',
                    'description': 'Default description',
                    'semaine': 'Default date',
                    'location': 'Default location',
                  }
                ]);
              } else {
                return _buildEventCards(snapshot.data!);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEventCards(List<dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.map((item) {
        return EventCard(
          imageUrl: item['image'] ?? 'assets/images/25.jpg',
          titre: item['titre'] ?? 'Default Title',
          description: item['Description'] ?? 'Default description',
          semaine: item['semaine'] ?? 'Default date',
          location: item['location'] ?? 'Default location',
        );
      }).toList(),
    );
  }
}

class EventCard extends StatelessWidget {
  final String imageUrl;
  final String titre;
  final String description;
  final String semaine;
  final String location;

  EventCard({
    required this.imageUrl,
    required this.titre,
    required this.description,
    required this.semaine,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/images/25.jpg');
            },
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              titre,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(description),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text('Date: $semaine'),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text('Location: $location'),
          ),
        ],
      ),
    );
  }
}
