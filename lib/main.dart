import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'map_screen.dart';
import 'pages/chat_screen.dart';
import 'weather_screen.dart'; // Import weather_screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login & Register',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(), // Removed const
        '/register': (context) => RegisterScreen(), // Removed const
        '/home': (context) => HomeScreen(email: ModalRoute.of(context)!.settings.arguments as String),
        '/profile': (context) => ProfileScreen(email: ModalRoute.of(context)!.settings.arguments as String),
        '/map': (context) => OSMFlutterMap(), // Removed const
        '/chat': (context) => ChatScreen(), // Removed const
        '/weather': (context) => WeatherScreen(), // Removed const
      },
    );
  }
}
