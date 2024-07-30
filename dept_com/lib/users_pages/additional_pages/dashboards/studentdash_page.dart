// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dept_com/providers/user_provider.dart';
import 'package:dept_com/users_pages/additional_pages/pdf/receipt_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart'; // Import the package

class StudentDashboardPage extends StatefulWidget {
  StudentDashboardPage({super.key});

  @override
  State<StudentDashboardPage> createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> {
  final storage = FlutterSecureStorage(); // This is the 'storage' instance

  final List<MenuItem> items = [
    // MenuItem(
    //   image: AssetImage("assets/images/46.jpeg"),
    //   title: 'Autres',
    //   route: ReceiptGenerator(),
    // ),
    MenuItem(
      image: AssetImage("assets/images/46.jpeg"),
      title: 'Create Receipt',
      route: ReceiptView(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (!authProvider.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/signin');
      });
    }

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
          leading: Navigator.canPop(context)
              ? BackButton(color: Colors.white)
              : null,
          title: Text('STUDENT', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
          actions: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(
                    context, '/home'); // Ensure this navigates as expected
              },
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => items[index].route,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final AssetImage image;
  final String title;
  final Widget route;

  MenuItem({
    required this.image,
    required this.title,
    required this.route,
  });
}
