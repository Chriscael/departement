// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, sized_box_for_whitespace

import 'package:dept_com/providers/user_provider.dart';
import 'package:dept_com/users_pages/additional_pages/list_of_receipt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:signature/signature.dart';



class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {

  final List<MenuItem> items = [
    MenuItem(
      image: AssetImage("assets/images/46.jpeg"),
      title: 'List Of Receipt',
      route: ListOfReceipt(),
    ),
  ];


  final storage = FlutterSecureStorage();
  List<Map<String, dynamic>> receipts = [];
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  Future<void> fetchReceipts() async {
    try {
      final token = await storage.read(key: 'jwt');
      if (token == null) {
        throw 'Token is null. Please log in again.';
      }

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/allreceipts'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          receipts = data.map((item) => item as Map<String, dynamic>).toList();
        });
      } else {
        throw Exception('Failed to load receipts: ${response.body}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  Future<void> saveSignature(String receiptId) async {
    try {
      final token = await storage.read(key: 'jwt');
      if (token == null) {
        throw 'Token is null. Please log in again.';
      }

      final signature = await _signatureController.toPngBytes();
      if (signature == null) {
        throw 'Signature is null. Please provide a signature.';
      }

      final base64Signature = base64Encode(signature);

      final response = await http.put(
        Uri.parse('http://127.0.0.1:8000/receipts/$receiptId/sign'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'schoolSignature': base64Signature}),
      );

      if (response.statusCode == 200) {
        fetchReceipts();
      } else {
        throw Exception('Failed to save signature: ${response.body}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchReceipts();
  }

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
          title: Text('ADMIN', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Color(0xFF363f93),
          actions: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                authProvider.logout();
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Receipts',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: receipts.length,
                itemBuilder: (context, index) {
                  final receipt = receipts[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: ListTile(
                      title: Text('Receipt: ${receipt['fullName']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Amount: ${receipt['amount']}'),
                          Text('Date: ${receipt['date']}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Add School Signature'),
                            content: Container(
                              width: double.maxFinite,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Signature(
                                      controller: _signatureController,
                                      height: 200,
                                      backgroundColor: Colors.grey[200]!,
                                    ),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await saveSignature(receipt['_id']);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Save Signature'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  _signatureController.clear();
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              //pagebuilder
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
