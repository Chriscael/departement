// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:dept_com/utils/consttants.dart';
import 'package:flutter/material.dart';
import 'package:dept_com/users_pages/additional_pages/articles/articles_details.dart';
import 'package:dept_com/services/db_services.dart';

class UserArticle extends StatefulWidget {
  const UserArticle({super.key, Key? Key});

  @override
  State<UserArticle> createState() => _UserArticleState();
}

class _UserArticleState extends State<UserArticle> {
  late Future<List<dynamic>> realisationData;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    realisationData = apiService.getRealisation('informatique');
  }

  final List<Articles> article = [
    Articles(
      title: 'ICT4D',
      description:
          'Information and Communication Technologies For Development!',
      image: AssetImage('assets/images/18.jpg'),
      route: ArticleDetail(
        titre: 'Default Title',
        annee: 'Default Year',
        description: 'Default Description',
      ),
    ),
    Articles(
      title: 'INFO',
      description: 'Informatique Fondamental',
      image: AssetImage('assets/images/34.jpeg'),
      route: ArticleDetail(
        titre: 'Default Title',
        annee: 'Default Year',
        description: 'Default Description',
      ),
    ),
  ];

  final List<OtherArticles> otherarticles = [
    OtherArticles(
      title: 'The Play',
      author: 'chris cael',
      imagePath: 'assets/images/31.png',
      route: ArticleDetail(
        titre: 'Default Title',
        annee: 'Default Year',
        description: 'Default Description',
      ),
    ),
    OtherArticles(
      title: 'TE-SEA',
      author: 'Generation de rapport',
      imagePath: 'assets/images/30.jpg',
      route: ArticleDetail(
        titre: 'Default Title',
        annee: 'Default Year',
        description: 'Default Description',
      ),
    ),
  ];

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
          title: Text('Articles'),
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
          foregroundColor: white,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            height: 900,
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF363f93),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: SearchBar(),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 00, right: 00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Articles',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF363f93),
                          ),
                        ),
                      ),
                      SizedBox(width: 05),
                      Row(
                        children: [
                          Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF363f93),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF363f93),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                FutureBuilder<List<dynamic>>(
                  future: realisationData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError || !snapshot.hasData) {
                      return Text("An error occurred!");
                    } else {
                      var activeRealisations = snapshot.data!
                          .where((data) => data['activated'] == true)
                          .toList();
                      if (activeRealisations.isEmpty) {
                        return Text("No active realisation data available.");
                      } else {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: activeRealisations.map((data) {
                              return ReadingListCard(
                                image:
                                    "assets/images/17.png", // Assuming you have a default image, modify as necessary
                                title: data['titre'] ?? 'No Title',
                                auth: data['Description'] ?? 'No Description',
                                pressDetails: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArticleDetail(
                                        titre: data['titre'] ?? 'No Title',
                                        annee: data['annee'].toString(),
                                        description: data['Description'] ??
                                            'No Description',
                                      ),
                                    ),
                                  );
                                },
                                pressRead: () {
                                  // Define action for Read button
                                },
                              );
                            }).toList(),
                          ),
                        );
                      }
                    }
                  },
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 00, right: 00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'New Book List',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: "Avenir",
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF363f93),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF363f93),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF363f93),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: otherarticles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      otherarticles[index].route,
                                ),
                              );
                            },
                            child: Container(
                              height: 230,
                              width: 150,
                              margin: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 5,
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      child: Image.asset(
                                        otherarticles[index].imagePath,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    otherarticles[index].title,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Avenir",
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF363f93),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    otherarticles[index].author,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Avenir",
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF363f93),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtherArticles {
  final String imagePath;
  final String title;
  final String author;
  final Widget route;

  OtherArticles({
    required this.imagePath,
    required this.author,
    required this.title,
    required this.route,
  });
}

class Articles {
  final String title;
  final String description;
  final AssetImage image;
  final Widget route;

  Articles({
    required this.title,
    required this.description,
    required this.image,
    required this.route,
  });
}

class ReadingListCard extends StatelessWidget {
  final String image;
  final String title;
  final String auth;
  final VoidCallback pressDetails;
  final VoidCallback pressRead;

  const ReadingListCard({
    super.key,
    required this.image,
    required this.title,
    required this.auth,
    required this.pressDetails,
    required this.pressRead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 40),
      height: 245,
      width: 202,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 221,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 33,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            image,
            width: 125,
            height: 160,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 35,
            right: 10,
            child: Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                  ),
                  onPressed: () {},
                ),
                //BookRating(key: UniqueKey(), score: rating),
              ],
            ),
          ),
          Positioned(
            top: 160,
            child: Container(
              height: 85,
              width: 202,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(color: kBlackColor),
                        children: [
                          TextSpan(
                            text: "$title\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: auth,
                            style: TextStyle(
                              color: kLightBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: pressDetails,
                        child: Container(
                          width: 101,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text('Details'),
                        ),
                      ),
                      Expanded(
                        child: TwoSideRoundedButton(
                          key: UniqueKey(),
                          text: 'Read',
                          radius: 24, // Optional: default radius value
                          radious: 24, // Required radius parameter
                          press: pressRead,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TwoSideRoundedButton extends StatelessWidget {
  final String text;
  final double radius;
  final void Function()? press;

  const TwoSideRoundedButton({
    required Key key,
    required this.text,
    this.radius = 29,
    required this.press,
    required int radious,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: deepblue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
