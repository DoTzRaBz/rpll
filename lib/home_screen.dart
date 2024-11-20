import 'package:flutter/material.dart';
import 'package:myapp/profile_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ... other widgets ...
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Row(
                      children: [
                        Image.network(
                          weatherIconUrl!,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.network('https://via.placeholder.com/50'), // Default image on error
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${weatherData['weather'][0]['main']}',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              '${weatherData['weather'][0]['description']}',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
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
            Navigator.pushNamed(context, '/profile', arguments: widget.email);
          } else if (index == 2) {
            Navigator.pushNamed(context, '/map');
          }
        },
      ),
    );
  }
}
