import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // Data cuaca
  double temperature = 0.0;
  double windSpeed = 0.0;
  int humidity = 0;
  String weatherCondition = '';

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    // Koordinat Tahura Bandung
    final latitude = -6.8441;
    final longitude = 107.6381;

    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,relative_humidity_2m,wind_speed_10m&hourly=weather_code&timezone=Asia%2FJakarta'
    );

    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        setState(() {
          temperature = data['current']['temperature_2m'];
          windSpeed = data['current']['wind_speed_10m'];
          humidity = data['current']['relative_humidity_2m'];
          
          // Mapping kode cuaca
          weatherCondition = _mapWeatherCode(
            data['hourly']['weather_code'][0]
          );
        });
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  // Fungsi untuk mapping kode cuaca
  String _mapWeatherCode(int code) {
    switch (code) {
      case 0:
        return 'Cerah';
      case 1:
      case 2:
      case 3:
        return 'Sebagian Berawan';
      case 45:
      case 48:
        return 'Berkabut';
      case 51:
      case 53:
      case 55:
        return 'Gerimis';
      case 61:
      case 63:
      case 65:
        return 'Hujan';
      default:
        return 'Kondisi Tidak Diketahui';
    }
  }

  // Fungsi untuk mendapatkan ikon cuaca
  String _getWeatherIcon(String condition) {
    switch (condition) {
      case 'Cerah':
        return 'assets/icons/sunny.png';
      case 'Sebagian Berawan':
        return 'assets/icons/partly_cloudy.png';
      case 'Berkabut':
        return 'assets/icons/foggy.png';
      case 'Gerimis':
        return 'assets/icons/drizzle.png';
      case 'Hujan':
        return 'assets/icons/rainy.png';
      default:
        return 'assets/icons/unknown.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuaca di Tahura Bandung'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar cuaca di tengah
            Image.asset(
              _getWeatherIcon(weatherCondition),
              width: 200,
              height: 200,
            ),
            
            // Kondisi cuaca
            Text(
              weatherCondition,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            // Detail cuaca
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Suhu
                Column(
                  children: [
                    Icon(Icons.thermostat),
                    Text('${temperature.toStringAsFixed(1)}°C'),
                    Text('Temperatur')
                  ],
                ),

                // Kelembapan
                Column(
                  children: [
                    Icon(Icons.water_drop),
                    Text('$humidity%'),
                    Text('Kelembapan')
                  ],
                ),

                // Kecepatan Angin
                Column(
                  children: [
                    Icon(Icons.air),
                    Text('${windSpeed.toStringAsFixed(1)} km/h'),
                    Text('Kecepatan Angin')
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}