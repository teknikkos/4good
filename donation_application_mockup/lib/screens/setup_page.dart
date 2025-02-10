import 'package:flutter/material.dart';
import 'homepage.dart'; // Import HomePage

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final List<String> causes = [
    'Animals',
    'Charities',
    'Environmental',
    'Religion',
    'Education',
    'Medical',
  ];

  final Set<String> selectedCauses = {};

  void toggleCause(String cause) {
    setState(() {
      if (selectedCauses.contains(cause)) {
        selectedCauses.remove(cause);
      } else {
        selectedCauses.add(cause);
      }
    });
  }

  void navigateToHomePage() {
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: selectedCauses.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Donation Causes'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: causes.length,
                itemBuilder: (context, index) {
                  final cause = causes[index];
                  final isSelected = selectedCauses.contains(cause);
                  return GestureDetector(
                    onTap: () => toggleCause(cause),
                    child: Card(
                      color: isSelected ? Colors.green : Colors.white,
                      child: Center(
                        child: Text(
                          cause,
                          style: TextStyle(
                            fontSize: 18,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: navigateToHomePage,
                  child: Text('Skip'),
                ),
                ElevatedButton(
                  onPressed: navigateToHomePage,
                  child: Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}