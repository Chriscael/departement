// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:dept_com/users_pages/additional_pages/actualite.dart';
import 'package:dept_com/users_pages/additional_pages/articles/organisation.dart';
import 'package:dept_com/users_pages/additional_pages/entreprise.dart';
import 'package:dept_com/users_pages/additional_pages/pdf/receipt_view.dart';
import 'package:dept_com/users_pages/additional_pages/articles/mission.dart';
import 'package:dept_com/users_pages/additional_pages/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dept_com/users_pages/additional_pages/articles/article.dart';

class AcademicsPage extends StatefulWidget {
  const AcademicsPage({super.key});

  @override
  State<AcademicsPage> createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {
  @override
  Widget build(BuildContext context) {

    final List<TechnicItem> techs = [
      TechnicItem(
        AssetImage("assets/images/36.gif"),
        'Reçu',
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReceiptView(),
          ),
        ),
      ),
    ];

    final List<MenuItem> items = [
      MenuItem(
        AssetImage("assets/images/48.webp"),
        'Recherche/Article',
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserArticle(),
          ),
        ),
      ),
      MenuItem(
        AssetImage("assets/images/41.gif"),
        'Mission',
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MissionPage(),
          ),
        ),
      ),
      MenuItem(
        AssetImage("assets/images/45.gif"),
        'Organisation',
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Organisation(),
          ),
        ),
      ),
      MenuItem(
        AssetImage("assets/images/40.webp"),
        'Actualite',
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Actualite(),
          ),
        ),
      ),
      MenuItem(
        AssetImage("assets/images/5.png"),
        'Acces',
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Plan(),
          ),
        ),
      ),
      MenuItem(
        AssetImage("assets/images/45.gif"),
        'Entreprise',
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Enterprise(),
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
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
                      "LES RUBRIQUE",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF363f93),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Les Rubrique du departement',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.5,
                  mainAxisSpacing: 0.5),
              itemBuilder: (BuildContext context, int index) {
                return SafeArea(
                  child: CupertinoButton(
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: items[index].image,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                        child: Text(
                          items[index].title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    onPressed: () => items[index].navigateToNextPage(context),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            Text(
              'Utile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: techs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.5,
                  mainAxisSpacing: 0.5),
              itemBuilder: (BuildContext context, int index) {
                return SafeArea(
                  child: CupertinoButton(
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: techs[index].image,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                        child: Text(
                          techs[index].title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    onPressed: () => techs[index].navigateToNextPage(context),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  MenuItem(
    this.image,
    this.title,
    this.onPressed,
  );
  final AssetImage image;
  final String title;
  final VoidCallback onPressed;

  void navigateToNextPage(BuildContext context) {
    if (onPressed != null) {
      onPressed(); // Call the provided onPressed function
    } else {
      // Handle potential case where onPressed is not set:
      // - Show a message or provide alternative behavior
      print('No navigation function defined for this MenuItem.');
    }
  }
}

class TechnicItem {
  TechnicItem(
    this.image,
    this.title,
    this.onPressed,
  );
  final AssetImage image;
  final String title;
  final VoidCallback onPressed;

  void navigateToNextPage(BuildContext context) {
    if (onPressed != null) {
      onPressed(); // Call the provided onPressed function
    } else {
      // Handle potential case where onPressed is not set:
      // - Show a message or provide alternative behavior
      print('No navigation function defined for this MenuItem.');
    }
  }
}
