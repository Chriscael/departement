// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetImage extends StatelessWidget {
  GetImage({super.key});

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.indigo,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile Picture',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.camera_alt_outlined),
                  onPressed: () async {
                    final result =
                        await picker.pickImage(source: ImageSource.camera);
                    Navigator.of(context).pop(File(result!.path));
                  },
                ),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.image_rounded),
                  onPressed: () async {
                    final result =
                        await picker.pickImage(source: ImageSource.gallery);
                    Navigator.of(context).pop(File(result!.path));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
