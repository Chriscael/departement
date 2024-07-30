// ignore_for_file: prefer_const_constructors_in_immutables, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
//import 'package:flutter_email_sender/flutter_email_sender.dart';

class ContactUs extends StatefulWidget {
  ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedTeacherName;
  Map<String, String> _teachers = {
    'John Doe': 'john.doe@example.com',
    'Jane Smith': 'jane.smith@example.com',
    'Alice Johnson': 'alice.johnson@example.com'
  };

  // Controllers for form fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

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
          title: Text('Contact'),
          backgroundColor: Color(0xFF363f93),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedTeacherName,
                      hint: Text('Select a teacher'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTeacherName = newValue;
                        });
                      },
                      validator: (value) => value == null ? 'Please select a teacher' : null,
                      items: _teachers.keys.map<DropdownMenuItem<String>>((String key) {
                        return DropdownMenuItem<String>(
                          value: key,
                          child: Text(key),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: 'FullName',
                        hintText: 'Enter your fullname',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your fullname';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'E-Mail Address',
                        hintText: 'Enter your email address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        labelText: 'Subject',
                        hintText: 'Enter the reason for this contact',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a subject';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _messageController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Your Message',
                        hintText: 'Enter your message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your message';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        // if (_formKey.currentState!.validate()) {
                        //   // Prepare the email
                        //   final Email email = Email(
                        //     body: 'Full Name: ${_fullNameController.text}\nEmail: ${_emailController.text}\nSubject: ${_subjectController.text}\nMessage: ${_messageController.text}',
                        //     subject: _subjectController.text,
                        //     recipients: [_teachers[_selectedTeacherName]!],
                        //     isHTML: false,
                        //   );

                        //   try {
                        //     await FlutterEmailSender.send(email);
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(content: Text('Message sent!')),
                        //     );
                        //   } catch (error) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(content: Text('Failed to send message: $error')),
                        //     );
                        //   }
                        // }
                      },
                      child: Text('SEND MESSAGE'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
