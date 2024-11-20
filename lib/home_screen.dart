import 'package:flutter/material.dart';
import 'package:myapp/profile_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/pages/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  const HomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Placeholder for weather data from OpenStreetMap (replace with actual API call)
  Map<String, dynamic> weatherData = {
    "weather": [
      {
        "id": 800,
        "main": "Clear",
        "description": "clear sky",
        "icon": "01d"
      },
    ]
  };
  String? weatherIconUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    // Replace this with your actual API call to fetch weather data from OpenStreetMap or a compatible source
    //  await Future.delayed(Duration(seconds: 2)); // Simulate API call delay

    final icon = weatherData['weather'][0]['icon'] as String?;
    if (icon != null) {
      weatherIconUrl = 'http://openweathermap.org/img/w/$icon.png';
    } else {
      weatherIconUrl = 'https://via.placeholder.com/50'; // Default image URL
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
          },
          icon: const Icon(Icons.chat),
          label: const Text('Go to Chat'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Go to Chat',
        onPressed: () {
          Navigator.pushNamed(context, '/chat');
        },
        child: const Icon(Icons.chat, color: Colors.white, size: 28),
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
            Navigator.pushNamed(context, '/profile', arguments: widget.email);
          } else if (index == 2) {
            Navigator.pushNamed(context, '/map');
          }
        },
      ),
    );
  }
}
