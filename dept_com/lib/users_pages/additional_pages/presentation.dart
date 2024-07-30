// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:dept_com/services/db_services.dart';
import 'package:dept_com/utils/consttants.dart';
import 'package:flutter/material.dart';

class Presentation extends StatefulWidget {
  const Presentation({super.key});

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  late Future<List<dynamic>> presentationData;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    presentationData = apiService.getPresentation('informatique');
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
        appBar: AppBar(
          title: Text('Presentation'),
          foregroundColor: white,
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: FutureBuilder<List<dynamic>>(
            future: presentationData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data!.isEmpty) {
                // Provide default data if API call fails or returns no data
                Map<String, dynamic> defaultData = {
                  'Description': 'No description available.',
                  'nombreEnseignants': 'N/A',
                  'nombreEntreprises': 'N/A',
                  'localisation': 'N/A',
                  'telephone': 'N/A',
                  'email': 'N/A',
                  'adresse': 'N/A',
                  'Image': 'assets/images/21.jpg',
                };
                return PresentationPage(data: defaultData);
              } else {
                // Extract the first item from the list as the data
                Map<String, dynamic> presentationData =
                    snapshot.data![0] as Map<String, dynamic>;
                return PresentationPage(data: presentationData);
              }
            },
          ),
        ),
      ),
    );
  }
}

class PresentationPage extends StatelessWidget {
  final Map<String, dynamic> data;

  PresentationPage({required this.data});

  @override
  Widget build(BuildContext context) {
    //final latestItem = data;
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
            _getFullImageUrl(data['Image']),
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/21.jpg',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
          InfoSection(
            title: 'Description',
            content: data['Description'] ?? 'No description available.',
          ),
          InfoSection(
            title: 'Nombre d\'Enseignants',
            content: data['nombreEnseignants']?.toString() ?? 'N/A',
          ),
          InfoSection(
            title: 'Nombre d\'Entreprises',
            content: data['nombreEntreprises']?.toString() ?? 'N/A',
          ),
          InfoSection(
            title: 'Localisation',
            content: data['localisation'] ?? 'N/A',
          ),
          InfoSection(
            title: 'Téléphone',
            content: data['telephone'] ?? 'N/A',
          ),
          InfoSection(
            title: 'Email',
            content: data['email'] ?? 'N/A',
          ),
          InfoSection(
            title: 'Adresse',
            content: data['adresse'] ?? 'N/A',
          ),
        ],
      ),
    );
  }
}

class InfoSection extends StatelessWidget {
  final String title;
  final String content;

  InfoSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(content),
          tileColor: Colors.white,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        ),
      ),
    );
  }
}

String _getFullImageUrl(String imagePath) {
  const String baseUrl = 'https://backend-form-1-5hj5.onrender.com';
  if (imagePath.startsWith('/')) {
    return '$baseUrl$imagePath';
  } else {
    return '$baseUrl/$imagePath';
  }
}
