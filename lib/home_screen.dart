import 'package:flutter/material.dart';
import 'package:myapp/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final String email;
  const HomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('Home Screen')),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
        currentIndex: 1, // Start at Home tab
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/profile', arguments: email);
          } else if (index == 2) {
            Navigator.pushNamed(context, '/map');
          }
        },
      ),
    );
  }
}
