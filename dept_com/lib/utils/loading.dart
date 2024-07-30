// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

loading(context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(value: 2),
      ),
    );
