// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class UserFormation extends StatefulWidget {
  UserFormation({super.key});

  @override
  _UserFormationState createState() => _UserFormationState();
}

class _UserFormationState extends State<UserFormation>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formation'),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            SizedBox(height: 10.0), // Add some spacing
            TabBar(
              controller: _controller,
              tabs: [
                Tab(text: 'Info Fondamental'),
                Tab(text: 'ICT For Development'),
                Tab(text: 'En General'),
              ],
            ),
            SizedBox(height: 5.0), // Add space between tabs and content
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  _buildInfoFondamentalTab(),
                  _buildICTForDevelopmentTab(),
                  _buildEnGeneralTab(),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoFondamentalTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabTitle('Info Fondamental'),
          _buildImage('assets/images/11.jpg'),
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
          _buildText('- Système d’Information et Génie Logiciel (SIGL) ;'),
          _buildText('- Sécurité Informatique (SI) ;'),
          _buildText('- Système et Réseaux (SR);'),
          _buildText('- Analyse des données.'),
        ],
      ),
    );
  }

  Widget _buildICTForDevelopmentTab() {
    return SingleChildScrollView(
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
        ],
      ),
    );
  }

  Widget _buildEnGeneralTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabTitle('En General'),
          _buildImage('assets/images/13.jpg'),
          _buildSubtitle('Enseignement'),
          _buildText(
              'Les enseignements sont organisés autour de 6 équipes pédagogiques:'),
          _buildText('- Algorithmique, Complexité et Calculabilité'),
          _buildText('- Architecture des machines, des systèmes et réseaux'),
          _buildText('- Bases de données et Systèmes d\'informations'),
          _buildText('- Langages, Programmation et Génie Logiciel'),
          _buildText(
              '- Intelligence Artificielle et Traitement du son, de l\'image et du texte'),
          _buildText('- Mathématiques pour l\'Informatique'),
          _buildSubtitle('Parcours'),
          _buildImage('assets/images/14.jpg'),
        ],
      ),
    );
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
}
