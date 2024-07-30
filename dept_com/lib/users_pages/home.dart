// ignore_for_file: prefer_const_constructors, use_super_parameters, prefer_interpolation_to_compose_strings, non_constant_identifier_names, avoid_unnecessary_containers, unnecessary_to_list_in_spreads

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dept_com/services/db_services.dart';
import 'package:dept_com/users_pages/additional_pages/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late Future<List<dynamic>> historiqueData;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    historiqueData = apiService.getHistorique('informatique');
  }

  DateTime today = DateTime.now();
  DateTime? selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  // Example events map
  Map<DateTime, List<Event>> events = {
    DateTime.utc(2024, 5, 20): [
      Event(
        name: "Event 1",
        time: "10:00 AM",
        image: AssetImage('assets/images/1.jpg'),
      ),
      Event(
        name: "Event 2",
        time: "2:00 PM",
        image: AssetImage('assets/images/2.jpg'),
      ),
    ],
    DateTime.utc(2024, 5, 21): [
      Event(
        name: "Event 3",
        time: "1:00 PM",
        image: AssetImage('assets/images/3.jpg'),
      ),
    ],
  };

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      setState(() {
        selectedDay = day;
        today = day;
      });
    }
  }

  void _onFormatChanged(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Slider
          CarouselSlider(
            items: [
              _buildImageWithContent(
                'assets/images/1.jpg',
                'Description for image 1. Mauris ut dapibus velit cras\n interdum nisi ac. Tempor mollis. Pellentesque habitant \nmorbi tristique senectus et netus et malesuada fames ac turpis\n egestas.',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs())),
              ),
              _buildImageWithContent(
                'assets/images/2.jpg',
                'Description for image 2. Mauris ut dapibus velit cras i\nterdum nisi ac. Tempor mollis. Pellentesque habitant morbi \ntristique senectus et\n netus et malesuada fames ac turpis \negestas.',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs())),
              ),
              _buildImageWithContent(
                'assets/images/3.jpg',
                'Description for image 3. Mauris ut dapibus velit cras \ninterdum nisi ac. Tempor mollis. Pellentesque habitant morbi\n tristique senectus et netus et malesuada fames ac turpis egestas.',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs())),
              ),
            ],
            options: CarouselOptions(
              height: 225.0,
              autoPlay: true,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
            ),
          ),

          // Calendar & events
          Content(),
          SizedBox(height: 10),
          ..._buildEventList(),

          // Container that presents the department
          Text(
            'Nous vous presentons le le Departement',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          FutureBuilder<List<dynamic>>(
            future: historiqueData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data!.isEmpty) {
                return HistoriqueCard(
                  imageUrl: 'assets/images/17.png',
                  description:
                      'Default description you you you yu you you you you you you you you you you you you you you you',
                );
              } else {
                var activeItems = snapshot.data!
                    .where((item) => item['activated'] == true)
                    .toList();
                if (activeItems.isEmpty) {
                  return Text("No active historique data available.");
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: activeItems.map<Widget>((item) {
                        return HistoriqueCard(
                          imageUrl: _getFullImageUrl(item['Image']),
                          description:
                              item['Description'] ?? 'No description available',
                        );
                      }).toList(),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  // Calendar.
  Widget Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Events of " + today.toString().split(" ")[0],
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF363f93),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(80.0),
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
          padding: EdgeInsets.all(10.0),
          child: TableCalendar(
            locale: "en_US",
            rowHeight: 43,
            headerStyle: HeaderStyle(
              formatButtonDecoration: BoxDecoration(),
              titleCentered: true,
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
              titleTextStyle: TextStyle(color: Colors.white),
              formatButtonTextStyle: TextStyle(color: Colors.white),
            ),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            focusedDay: today,
            firstDay: DateTime.utc(2020, 05, 25),
            lastDay: DateTime.utc(2025, 05, 25),
            onDaySelected: _onDaySelected,
            onFormatChanged: _onFormatChanged,
            calendarFormat: _calendarFormat,
            eventLoader: (day) {
              return events[day] ?? [];
            },
            calendarStyle: CalendarStyle(
              defaultTextStyle: TextStyle(color: Colors.white),
              weekendTextStyle: TextStyle(color: Colors.orange),
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.rectangle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
              ),
              outsideTextStyle: TextStyle(color: Colors.white60),
              disabledTextStyle: TextStyle(color: Colors.grey),
              holidayTextStyle: TextStyle(color: Colors.orange),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.white),
              weekendStyle: TextStyle(color: Colors.orange),
            ),
            startingDayOfWeek: StartingDayOfWeek.monday,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildEventList() {
    if (selectedDay == null || events[selectedDay!] == null) {
      return [
        Text(
          "No events for this day",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )
      ];
    }

    return events[selectedDay!]!.map((event) {
      return Container(
        height: 300,
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Color(0xFF363f93),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(80.0),
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(8.0),
          leading: Container(
            width: 150, // Adjusted width
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: event.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            event.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            event.time,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }).toList();
  }
}

// Carousel content
Widget _buildImageWithContent(
    String imagePath, String description, Function onPressed) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20.0), // Adjust corner radius as needed
      bottomRight: Radius.circular(20.0),
    ),
    child: Stack(
      children: [
        Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
        Positioned(
          top: 20.0,
          left: 16.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () => onPressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),
                child: Text(
                  'Learn more',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    //(0, 0) // 1. point
    path.lineTo(0, h); //2. point
    path.lineTo(w, h); //4. point //4. point
    path.lineTo(w, 0); //5. point
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class Event {
  final String name;
  final String time;
  final AssetImage image;

  Event({
    required this.name,
    required this.time,
    required this.image,
  });
}

// Contains the code for historique du departement
class HistoriqueCard extends StatelessWidget {
  final String imageUrl;
  final String description;

  const HistoriqueCard({
    Key? key,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCardShape(),
      child: Card(
        color: Color(0xFF363f93),
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/17.png', fit: BoxFit.cover);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCardShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);
    path.lineTo(size.width, size.height - 20);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 20, size.height);
    path.lineTo(20, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

String _getFullImageUrl(String imagePath) {
  const String baseUrl = 'https://backend-form-1-5hj5.onrender.com';
  if (imagePath.startsWith('/')) {
    return '$baseUrl$imagePath';
  } else {
    return '$baseUrl/$imagePath';
  }
}
