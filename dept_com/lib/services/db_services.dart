// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  //static const String baseUrl = 'HTTPS://BACKEND-FORM-1-5HJ5.ONRENDER.COM';
  static const String baseUrl = 'http://localhost:3000/api/proxy';

  Future<List<dynamic>> getActualite(String department) async {
    final url = '$baseUrl/Getactualite/$department';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Received actualite data: $data');

        // Sort data by updatedAt field in descending order
        data.sort((a, b) => DateTime.parse(b['updatedAt'])
            .compareTo(DateTime.parse(a['updatedAt'])));

        return data;
      } else {
        print(
            'Failed to load actualite data. Status code: ${response.statusCode}');
        throw Exception('Failed to load actualite data');
      }
    } catch (error) {
      print('Error fetching actualite data: $error');
      throw Exception('Failed to load actualite data: $error');
    }
  }

  Future<List<dynamic>> getEnseignant(String department) async {
    final url = '$baseUrl/Getenseignant/$department';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Received enseignant data: $data');

        // Sort data by updatedAt field in descending order
        data.sort((a, b) => DateTime.parse(b['updatedAt'])
            .compareTo(DateTime.parse(a['updatedAt'])));

        return data;
      } else {
        print(
            'Failed to load enseignant data. Status code: ${response.statusCode}');
        throw Exception('Failed to load enseignant data');
      }
    } catch (error) {
      print('Error fetching enseignant data: $error');
      throw Exception('Failed to load enseignant data: $error');
    }
  }

  Future<List<dynamic>> getHistorique(String department) async {
    final url = '$baseUrl/Gethistorique/$department';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Received historique data: $data');

        // Sort data by updatedAt field in descending order
        data.sort((a, b) => DateTime.parse(b['updatedAt'])
            .compareTo(DateTime.parse(a['updatedAt'])));

        return data;
      } else {
        print(
            'Failed to load historique data. Status code: ${response.statusCode}');
        throw Exception('Failed to load historique data');
      }
    } catch (error) {
      print('Error fetching historique data: $error');
      throw Exception('Failed to load historique data: $error');
    }
  }

  Future<List<dynamic>> getMission(String department) async {
    final url = '$baseUrl/Getmission/$department';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Received mission data: $data');

        // Sort data by updatedAt field in descending order
        data.sort((a, b) => DateTime.parse(b['updatedAt'])
            .compareTo(DateTime.parse(a['updatedAt'])));

        return data;
      } else {
        print(
            'Failed to load mission data. Status code: ${response.statusCode}');
        throw Exception('Failed to load mission data');
      }
    } catch (error) {
      print('Error fetching mission data: $error');
      throw Exception('Failed to load mission data: $error');
    }
  }

  Future<List<dynamic>> getPresentation(String department) async {
    final url = '$baseUrl/Getpresentation/$department';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Received presentation data: $data');

        // Sort data by updatedAt field in descending order
        data.sort((a, b) => DateTime.parse(b['updatedAt'])
            .compareTo(DateTime.parse(a['updatedAt'])));

        return data;
      } else {
        print(
            'Failed to load presentation data. Status code: ${response.statusCode}');
        throw Exception('Failed to load presentation data');
      }
    } catch (error) {
      print('Error fetching presentation data: $error');
      throw Exception('Failed to load presentation data: $error');
    }
  }

  Future<List<dynamic>> getRealisation(String department) async {
    final url = '$baseUrl/Getrealisation/$department';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Received realisation data: $data');

        // Sort data by updatedAt field in descending order
        data.sort((a, b) => DateTime.parse(b['updatedAt'])
            .compareTo(DateTime.parse(a['updatedAt'])));

        return data;
      } else {
        print(
            'Failed to load realisation data. Status code: ${response.statusCode}');
        throw Exception('Failed to load realisation data');
      }
    } catch (error) {
      print('Error fetching realisation data: $error');
      throw Exception('Failed to load realisation data: $error');
    }
  }

  Future<List<dynamic>> getEntreprise(String department) async {
    final url = '$baseUrl/Getentreprise/$department';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Received entreprise data: $data');

        // Sort data by updatedAt field in descending order
        data.sort((a, b) => DateTime.parse(b['updatedAt'])
            .compareTo(DateTime.parse(a['updatedAt'])));

        return data;
      } else {
        print(
            'Failed to load entreprise data. Status code: ${response.statusCode}');
        throw Exception('Failed to load entreprise data');
      }
    } catch (error) {
      print('Error fetching entreprise data: $error');
      throw Exception('Failed to load entreprise data: $error');
    }
  }

  Future<List<dynamic>> getFormation(String department) async {
    final url = '$baseUrl/Getformation/$department';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Received formation data: $data');

        // Sort data by updatedAt field in descending order
        data.sort((a, b) => DateTime.parse(b['updatedAt'])
            .compareTo(DateTime.parse(a['updatedAt'])));

        return data;
      } else {
        print(
            'Failed to load formation data. Status code: ${response.statusCode}');
        throw Exception('Failed to load formation data');
      }
    } catch (error) {
      print('Error fetching formation data: $error');
      throw Exception('Failed to load formation data: $error');
    }
  }
}
