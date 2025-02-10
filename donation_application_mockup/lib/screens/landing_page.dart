import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Landing Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to,',
              style: TextStyle(fontSize: 24),
            ),
            Image.asset('assets/images/logo.png', height: 100), // Add the logo
            SizedBox(height: 20),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/setup');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Change the button color here
              ),
              child: Text(
                'Get Started',
                style: TextStyle(color: Colors.white), // Change the text color here
              ),
            ),
          ],
        ),
      ),
    );
  }
}