import 'package:flutter/material.dart';
import 'package:project/custom_model_screen.dart';
import 'package:project/homse_screen.dart';
import 'package:project/imagepicker.dart';
import 'package:project/user_screen.dart';
import 'package:project/without_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
      body:  ImgPicker(),
    ),
    );
  }
}