import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landing Page'),
      ),
      backgroundColor: Colors.white, // Change the background color here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo.png', height: 100), // Add the logo
            const SizedBox(height: 20),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/setup');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Change the button color here
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Times New Roman') // Change the text color here
              ),
            ),
          ],
        ),
      ),
    );
  }
}