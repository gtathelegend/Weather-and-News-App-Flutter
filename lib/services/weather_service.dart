import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  final String apiKey = "3cee54b1d6d041e69a3230913250209"; // 🔑 replace with your key
  final String baseUrl = "https://api.weatherapi.com/v1";

  Future<Weather> fetchWeather(String city) async {
    final url = Uri.parse("$baseUrl/current.json?key=$apiKey&q=$city");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception("Failed to load weather");
    }
  }
}
