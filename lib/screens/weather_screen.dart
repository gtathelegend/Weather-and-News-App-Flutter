
import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();
  Weather? _weather;
  bool _isLoading = false;

  Future<void> _fetchWeather(String city) async {
    if (city.isEmpty) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final weather = await _weatherService.fetchWeather(city);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error, e.g., show a snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _fetchWeather(_cityController.text),
                ),
              ),
              onSubmitted: (value) => _fetchWeather(value),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_weather != null)
              Column(
                children: [
                  Text(_weather!.cityName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('${_weather!.temperature.toStringAsFixed(1)}°C', style: const TextStyle(fontSize: 48)),
                  Text(_weather!.condition, style: const TextStyle(fontSize: 20)),
                ],
              )
            else
              const Text('Enter a city to get the weather forecast.'),
          ],
        ),
      ),
    );
  }
}
