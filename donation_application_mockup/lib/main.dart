import 'package:flutter/material.dart';
import 'screens/homepage.dart'; // Import the homepage
import 'screens/landing_page.dart'; // Import the landing page
import 'screens/setup_page.dart'; // Import the setup page

void main() {
  runApp(const DonationApp());
}

class DonationApp extends StatelessWidget {
  const DonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4Good',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(), // Set LandingPage as the initial route
        '/setup': (context) => const SetupPage(), // Define the SetupPage route
        '/home': (context) => const HomePage(selectedCauses: []), // Define the HomePage route with an empty list as default
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final args = settings.arguments as List<String>;
          return MaterialPageRoute(
            builder: (context) {
              return HomePage(selectedCauses: args);
            },
          );
        }
        return null;
      },
    );
  }
}