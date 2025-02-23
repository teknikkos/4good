import 'package:flutter/material.dart';
import '../widgets/donation_form.dart';

class HomePage extends StatefulWidget {
  final List<String> selectedCauses;

  const HomePage({super.key, required this.selectedCauses});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  String searchQuery = '';
  List<String> filteredOrganizations = [];

  final List<String> organizations = [
    'Red Cross Philippines',
    'Pawssion Project',
    'Unicef Philippines',
  ];

  final List<Map<String, String>> posts = [
    {
      'username': 'user1',
      'avatar': 'assets/images/avatar1.png',
      'image': '../../assets/images/post1.png',
      'caption': 'Helping the community!',
    },
    {
      'username': 'user2',
      'avatar': 'assets/images/avatar2.png',
      'image': '../../assets/images/post2.png',
      'caption': 'Supporting animal shelters!',
    },
    {
      'username': 'user3',
      'avatar': 'assets/images/avatar3.png',
      'image': '../../assets/images/post3.png',
      'caption': 'Environmental cleanup drive!',
    },
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
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home Page'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.green,
          child: Column(
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.home, color: Colors.white),
                      title: const Text('Home', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _selectedIndex = 0;
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.search, color: Colors.white),
                      title: const Text('Search', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _selectedIndex = 1;
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.white),
                      title: const Text('Profile', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _selectedIndex = 2;
                        });
                      },
                    ),
                    const Divider(color: Colors.white),
                    ListTile(
                      leading: const Icon(Icons.notifications, color: Colors.white),
                      title: const Text('Notifications', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context);
                        // Navigate to Notifications page
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings, color: Colors.white),
                      title: const Text('Settings', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context);
                        // Navigate to Settings page
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text('Sign Out', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  // Implement sign out functionality
                },
              ),
            ],
          ),
        ),
      ),
      body: _selectedIndex == 0 ? _buildHomeScreen() : _selectedIndex == 1 ? _buildSearchScreen() : ProfileScreen(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.green, // Active tab color
            unselectedItemColor: Colors.white, // Inactive tab color
            backgroundColor: Colors.black, // Background color
            showUnselectedLabels: true, // Ensures labels show for all tabs
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(post['avatar']!),
                ),
                title: Text(post['username']!),
              ),
              Image.asset(post['image']!),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(post['caption']!),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Organizations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: updateSearchQuery,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
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
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.business, color: Colors.blue),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Text(
                                organization,
                                style: const TextStyle(fontSize: 18),
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
  const HomeScreen({super.key});

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
      appBar: AppBar(title: const Text('Home Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to Donation App!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
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
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Donate Now'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: donations
                    .map((donation) => ListTile(
                          leading: const Icon(Icons.favorite, color: Colors.red),
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

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Donation History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: donationHistory
                    .map((donation) => ListTile(
                          leading: const Icon(Icons.history, color: Colors.orange),
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