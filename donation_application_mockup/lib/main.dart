import 'package:flutter/material.dart';
import 'screens/homepage.dart'; // Import the homepage

void main() {
  runApp(DonationApp());
}

class DonationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Navigate to the HomePage from homepage.dart
    );
  }
}
