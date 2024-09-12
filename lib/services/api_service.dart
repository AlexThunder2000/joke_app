import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/joke_model.dart';

class ApiService {
  Future<List<String>> fetchJokeTypes() async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/types'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((type) => type.toString()).toList();
    } else {
      throw Exception('Failed to load joke types');
    }
  }

  Future<Joke> fetchJokeByType(String type) async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/jokes/$type/random'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return Joke.fromJson(data[0]);
    } else {
      throw Exception('Failed to load joke');
    }
  }

  Future<String> fetchDogImageUrl() async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to load dog image');
    }
  }
}
