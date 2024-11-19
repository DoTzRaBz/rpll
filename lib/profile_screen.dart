import 'package:flutter/material.dart';
import 'package:myapp/database_helper.dart';

class ProfileScreen extends StatefulWidget {
  final String? email;
  const ProfileScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (widget.email != null) {
      final dbHelper = DatabaseHelper();
      final user = await dbHelper.getUserByEmail(widget.email!);
      setState(() {
        _userData = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamed(context, '/login'); 
            },
          ),
        ],
      ),
      body: _userData == null
          ? const Center(child: Text('User not found'))
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${_userData!['name']}'),
                  Text('Email: ${_userData!['email']}'),
                  Text('Password: ${_userData!['password']}'),
                ],
              ),
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
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          if (index == 1) {
            if (widget.email != null) {
              Navigator.pushReplacementNamed(context, '/home', arguments: widget.email);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please login first')),
              );
            }
          } else if (index == 2) {
            Navigator.pushNamed(context, '/map');
          }
        },
      ),
    );
  }
}
