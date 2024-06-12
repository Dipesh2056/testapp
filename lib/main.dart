// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/job_listing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job Listing App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: JobListingScreen(),
    );
  }
}
