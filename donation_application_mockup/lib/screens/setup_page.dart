import 'package:flutter/material.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

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
        title: const Text('Select Donation Causes'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemCount: causes.length,
                itemBuilder: (context, index) {
                  final cause = causes[index];
                  final isSelected = selectedCauses.contains(cause);
                  return GestureDetector(
                    onTap: () => toggleCause(cause),
                    child: Card(
                      color: isSelected ? Colors.green : Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: isSelected ? Colors.green : Colors.green,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (cause == 'Animals')
                              Image.asset(
                                '../../assets/images/ic_sharp-pets.png',
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            if (cause == 'Charities')
                              Image.asset(
                                '../../assets/images/mdi_kids-room.png',
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            if (cause == 'Environmental')
                              Image.asset(
                                '../../assets/images/mdi_leaf.png',
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            if (cause == 'Religion')
                              Image.asset(
                                '../../assets/images/mdi_religion-christian-outline.png',
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            if (cause == 'Education')
                              Image.asset(
                                '../../assets/images/tdesign_education-filled.png',
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            if (cause == 'Medical')
                              Image.asset(
                                '../../assets/images/Vector.png',
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            const SizedBox(height: 10),
                            Text(
                              cause,
                              style: TextStyle(
                                fontSize: 18,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
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
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.green),
                  child: const Text('Skip'),
                ),
                ElevatedButton(
                  onPressed: navigateToHomePage,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                  child: const Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}