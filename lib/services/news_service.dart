import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = "6bdf337abcf242bb9428169a2247f9a4";
  final String baseUrl = "https://newsapi.org/v2";

  Future<List<dynamic>> fetchTopHeadlines() async {
    final response = await http.get(
      Uri.parse("$baseUrl/top-headlines?country=us&apiKey=$apiKey"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // return articles list instead of raw string
      return data["articles"];
    } else {
      throw Exception("Failed to load news");
    }
  }
}
