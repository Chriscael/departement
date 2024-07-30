// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:dept_com/utils/consttants.dart';
import 'package:flutter/material.dart';

class ArticleDetail extends StatelessWidget {
  final String titre;
  final String annee;
  final String description;

  const ArticleDetail({
    super.key,
    required this.titre,
    required this.annee,
    required this.description,
  });

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
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: deepblue,
            foregroundColor: white,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            // Added SingleChildScrollView here
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Material(
                        elevation: 0.0,
                        child: Container(
                          height: 180,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage('assets/images/17.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                titre,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF363f93),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Year: $annee",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF7b8ea3),
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Divider(color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Divider(color: Color(0xFF7b8ea3)),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.favorite,
                                  color: Color(0xFF7b8ea3), size: 40),
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  "Like",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Avenir",
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF363f93),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10), // Add spacing between the columns
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.share,
                                  color: Color(0xFF7b8ea3), size: 40),
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  "Share",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Avenir",
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF363f93),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10), // Add spacing between the columns
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.bookmarks_sharp,
                                  color: Color(0xFF7b8ea3), size: 40),
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  "Bookshelf",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Avenir",
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF363f93),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF363f93),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 300,
                    child: Text(
                      description,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  Divider(color: Color(0xFF7b8ea3)),
                  GestureDetector(
                    onTap: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>AllBooks()));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          Text(
                            "Check the directory",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(child: Container()),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Color(0xFF7b8ea3)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
