// ignore_for_file: prefer_const_constructors

import 'package:dept_com/users_pages/additional_pages/staff/staff.dart';
import 'package:dept_com/users_pages/authentication/register.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context).user;
    return Container(
      color: Colors.white,
      width: 300,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'chris',
              //user.name, 
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              'chris',
              //user.email,
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/2.jpg"),
            ),
            decoration: BoxDecoration(
              color: Colors.indigo, // Set the background color to indigo
            ),
          ),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Log In'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.business),
                      title: Text('ADMINISTRATION'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Staff(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on_rounded),
                      title: Text('PLAN D\'ACCÈS'),
                      onTap: () {},
                    ),
                  ],
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
