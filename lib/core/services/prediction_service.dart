import 'dart:convert';
import 'package:http/http.dart' as http;

class PredictionService {
  static const String baseUrl = 'http://localhost:5000'; // Change to your API URL

  // Get prediction from ML API
  Future<Map<String, dynamic>> getPrediction({
    required int age,
    required double weight,
    required double height,
    required double bmi,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/predict'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'age': age,
          'weight': weight,
          'height': height,
          'bmi': bmi,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get prediction: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Save prediction to Firestore
  Future<void> savePrediction(Map<String, dynamic> prediction) async {
    // TODO: Implement Firestore save functionality
  }

  // Get prediction history
  Future<List<Map<String, dynamic>>> getPredictionHistory() async {
    // TODO: Implement Firestore fetch functionality
    return [];
  }
} 