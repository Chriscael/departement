// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dept_com/utils/consttants.dart';
import 'package:flutter/material.dart';

class TypesDeFilierIct extends StatefulWidget {
  const TypesDeFilierIct({super.key});

  @override
  State<TypesDeFilierIct> createState() => _TypesDeFilierIctState();
}

class _TypesDeFilierIctState extends State<TypesDeFilierIct> {
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
          foregroundColor: white,
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
                        "Les Formation D'ICT4D",
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
              _buildICTForDevelopmentTab(),
              _buildListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildICTForDevelopmentTab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabTitle('ICT For Development'),
          _buildImage('assets/images/12.jpg'),
          _buildSubtitle('PRÉSENTATION ICT4D'),
          _buildText(
              'La licence en ICT4D donne la possibilité aux étudiants en fin de formation d’accéder au cycle Master professionnel, une école d’ingénierie et/ou le monde professionnel avec des connaissances tant pratiques que théoriques leur permettant de s’adapter aux grands domaines de l’informatique et de ses applications. Les titulaires du diplôme peuvent occuper des postes de responsabilités tels que : Concepteur ou développeur d’applications, analyste-programmeur, administrateur de bases de données, architecte web, ingénieur système et réseau, responsable du système informatique, adjoint ou assistant d’ingénieur ou de chef de projet.'),
          _buildSubtitle('ADMISSION'),
          _buildText('- Pré-inscription en ligne ;'),
          _buildText(
              '- Dépôts du dossier physique à la scolarité de la faculté des sciences ;'),
          _buildText('- Commission de sélection ;'),
          _buildSubtitle('SPÉCIALITÉS'),
          _buildText(
              'ICT FOR DEVELOPMENT comporte quatre (03) spécialités. Le choix de la spécialité se fait à partir du niveau L3. Les cours sont dispensés en français et/ou en anglais et les spécialités offertes sont :'),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          ListTile(
            title: Text('Système d’Information et Génie Logiciel (SIGL)'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Sécurité Informatique (SI)'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Système et Réseaux (SR)'),
            onTap: () {},
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
