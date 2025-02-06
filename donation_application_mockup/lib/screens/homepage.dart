import 'package:flutter/material.dart';
import '../widgets/donation_form.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    OrganizationsScreen(), // Now using "Organizations"
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green, // Active tab color
        unselectedItemColor: Colors.grey, // Inactive tab color
        showUnselectedLabels: true, // Ensures labels show for all tabs
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Organizations'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// 🏠 Home Screen
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> donations = [];

  void addDonation(String name, double amount) {
    setState(() {
      donations.add('$name donated \$${amount.toStringAsFixed(2)}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donation App')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome to Donation App!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => DonationForm(onSubmit: (name, amount) {
                    addDonation(name, amount);
                    Navigator.pop(context);
                  }),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Donate Now'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: donations
                    .map((donation) => ListTile(
                          leading: Icon(Icons.favorite, color: Colors.red),
                          title: Text(donation),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🏢 Organizations You Are Donating To
class OrganizationsScreen extends StatelessWidget {
  final List<String> organizations = [
    'Greenwood Orphanage',
    'Hope Community School',
    'Elderly Care Center',
    'Food Bank Foundation',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Organizations')),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: organizations.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.business, color: Colors.blue),
              title: Text(organizations[index]),
              trailing: ElevatedButton(
                onPressed: () {
                  // TODO: Implement donation functionality
                },
                child: Text('Donate'),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 👤 Profile Screen (with Donation History)
class ProfileScreen extends StatelessWidget {
  final List<String> donationHistory = [
    'You donated \$10 to Greenwood Orphanage',
    'You donated \$20 to Elderly Care Center',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Donation History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: donationHistory
                    .map((donation) => ListTile(
                          leading: Icon(Icons.history, color: Colors.orange),
                          title: Text(donation),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
