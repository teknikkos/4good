import 'package:flutter/material.dart';
import '../widgets/donation_form.dart';

class HomePage extends StatefulWidget {
  final List<String> selectedCauses;

  HomePage({required this.selectedCauses});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String searchQuery = '';
  List<String> filteredOrganizations = [];

  final List<String> organizations = [
    'Red Cross Philippines',
    'Pawssion Project',
    'Unicef Philippines',
  ];

  @override
  void initState() {
    super.initState();
    filteredOrganizations = organizations;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredOrganizations = organizations
          .where((org) => org.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Notifications page
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Settings page
              },
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0 ? HomeScreen() : _selectedIndex == 1 ? _buildSearchScreen() : ProfileScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green, // Active tab color
        unselectedItemColor: Colors.grey, // Inactive tab color
        showUnselectedLabels: true, // Ensures labels show for all tabs
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildSearchScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Organizations'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: updateSearchQuery,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: widget.selectedCauses
                  .map((cause) => FilterChip(
                        label: Text(cause),
                        onSelected: (bool selected) {
                          // Handle filter selection
                        },
                      ))
                  .toList(),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredOrganizations.length,
                itemBuilder: (context, index) {
                  final organization = filteredOrganizations[index];
                  return GestureDetector(
                    onTap: () {
                      // TODO: Implement donation functionality
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(Icons.business, color: Colors.blue),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Text(
                                organization,
                                style: TextStyle(fontSize: 18),
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
          ],
        ),
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
      appBar: AppBar(title: Text('Home Page')),
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
                          onTap: () {
                            // Handle donation history item click
                          },
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