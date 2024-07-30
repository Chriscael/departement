// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:dept_com/users_pages/additional_pages/specialities/type_de_filier_Info.dart';
import 'package:dept_com/users_pages/additional_pages/specialities/type_de_filier_ict.dart';
import 'package:dept_com/users_pages/additional_pages/two_side_rounded_button.dart';
import 'package:dept_com/utils/consttants.dart';
import 'package:flutter/material.dart';

class LesFormation extends StatefulWidget {
  const LesFormation({super.key});

  @override
  State<LesFormation> createState() => _LesFormationState();
}

class _LesFormationState extends State<LesFormation> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset('assets/images/10.jpg'),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Formation \n 02 GRANDES Cycle au departement d\'informatique',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            BestOfTheDayCard(
              size: size,
              title: "INFORMATIQUE FONDAMENTAL",
              subtitle: "Filier Academique",
              author: "Created When the University Was Founded",
              description:
                  "When the earth was flat and everyone wanted to win the game.",
              imagePath: "assets/images/17.png",
              buttonText: 'See More',
              onButtonPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => TypesDeFilierInfo()),
                  ),
                );
              },
            ),
            BestOfTheDayCard(
              size: size,
              title: "ICT For Development",
              subtitle: "Filier Professionelle",
              author: "Founded In 2013",
              description:
                  "A comprehensive guide to learning Flutter for mobile development.",
              imagePath: "assets/images/17.png",
              buttonText: 'See more',
              onButtonPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => TypesDeFilierIct()),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class BestOfTheDayCard extends StatelessWidget {
  final Size size;
  final String title;
  final String subtitle;
  final String author;
  final String description;
  final String imagePath;
  final String buttonText;
  final VoidCallback onButtonPressed;

  BestOfTheDayCard({
    required this.size,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.description,
    required this.imagePath,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 245,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                top: 24,
                right: size.width * .35,
              ),
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 35, 93, 70).withOpacity(.45),
                borderRadius: BorderRadius.circular(29),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          color: white,
                        ),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      author,
                      style: TextStyle(color: white),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              imagePath,
              width: size.width * .37,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              width: size.width * .3,
              child: TwoSideRoundedButton(
                key: UniqueKey(),
                text: buttonText,
                radious: 24,
                press: onButtonPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
