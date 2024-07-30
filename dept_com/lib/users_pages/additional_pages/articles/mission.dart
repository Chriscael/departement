// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:dept_com/services/db_services.dart';

class MissionPage extends StatefulWidget {
  const MissionPage({super.key});

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  late Future<List<dynamic>> missionData;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    missionData = apiService.getMission('informatique');
  }

  @override
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Mission'),
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: FutureBuilder<List<dynamic>>(
              future: missionData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  // Handle all cases where there's an error, no data, or data is empty.
                  return MissionContent(
                    data: [
                      {
                        'Description':
                            'No valid data available. Failed to load or no active items.',
                        'imageUrl': 'assets/images/17.png',
                      }
                    ],
                  );
                } else {
                  // Filtering for activated items, assuming each data item has an 'activated' key.
                  var activeItems = snapshot.data!
                      .where((item) => item['activated'] == true)
                      .toList();
                  if (activeItems.isEmpty) {
                    return Text("No active mission data available.",
                        style: TextStyle(fontSize: 18));
                  } else {
                    return MissionContent(
                      data: activeItems,
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MissionContent extends StatelessWidget {
  final List<dynamic> data;

  MissionContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: data.map((item) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item['imageUrl'] ?? 'assets/images/17.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/17.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Our Mission',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF363f93),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  item['Description'] ?? 'No description available.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
