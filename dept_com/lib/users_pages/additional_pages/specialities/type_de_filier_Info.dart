// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:dept_com/users_pages/additional_pages/articles/formation_details.dart';
import 'package:flutter/material.dart';
import 'package:dept_com/services/db_services.dart';


class TypesDeFilierInfo extends StatefulWidget {
  const TypesDeFilierInfo({super.key});

  @override
  State<TypesDeFilierInfo> createState() => _TypesDeFilierInfoState();
}

class _TypesDeFilierInfoState extends State<TypesDeFilierInfo> {
  late Future<List<dynamic>> formationData;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    formationData = apiService.getFormation('informatique');
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
          backgroundColor: Color(0xFF363f93),
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.transparent,
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
                      spreadRadius: 4.0,
                    ),
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
                        "Les Formation D'Info",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF363f93),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildInfoFondamentalTab(),
              FutureBuilder<List<dynamic>>(
                future: formationData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return _buildDefaultListView();
                  } else if (snapshot.hasData) {
                    return _buildListView(snapshot.data!);
                  } else {
                    return _buildDefaultListView();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoFondamentalTab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabTitle('Info Fondamental'),
          _buildImage('assets/images/13.jpg'),
          _buildSubtitle('PRÉSENTATION INFO Fondamental'),
          _buildText(
              'info-fondamental est une filière académique du département informatique de la faculté des sciences de l’Université de Yaoundé 1'),
          _buildSubtitle('ADMISSION'),
          _buildText('- Pré-inscription en ligne ;'),
          _buildText(
              '- Dépôts du dossier physique à la scolarité de la faculté des sciences ;'),
          _buildText('- Commission de sélection ;'),
          _buildSubtitle('SPÉCIALITÉS'),
          _buildText(
              'INFO-FONDAMENTAL comporte quatre (04) spécialités. Le choix de la spécialité se fait à partir du niveau L3. Les cours sont dispensés en français et/ou en anglais et les spécialités offertes sont :'),
        ],
      ),
    );
  }

  Widget _buildListView(List<dynamic> data) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: ListTile.divideTiles(
        context: context,
        tiles: data.map((item) {
          return ListTile(
            title: Text(item['titre'] ?? 'Unknown Titre'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FDetail(data: item),
                ),
              );
            },
          );
        }).toList(),
      ).toList(),
    );
  }

  Widget _buildDefaultListView() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          ListTile(
            title: Text('Default Titre'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FDetail(data: {
                    'titre': 'Default Titre',
                    'presentation': 'Default Présentation',
                    'admission': 'Default Admission',
                    'parcours': 'Default Parcours',
                    'Image': 'assets/images/25.jpg',
                  }),
                ),
              );
            },
          ),
        ],
      ).toList(),
    );
  }
}

Widget _buildTabTitle(String title) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _buildSubtitle(String subtitle) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, top: 16.0),
    child: Text(
      subtitle,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _buildText(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Text(text),
  );
}

Widget _buildImage(String imagePath) {
  return Image.asset(
    imagePath,
    width: double.infinity,
  );
}
