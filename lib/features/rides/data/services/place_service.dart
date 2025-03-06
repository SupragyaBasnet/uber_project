import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../app/constants/api_endpoints.dart';
import '../../domain/models/place_suggestion.dart';

class PlaceService {
  final http.Client _client = http.Client();
  
  // Auth token for API requests
  final Map<String, String> _headers = {
    'Authorization': "Bearer "
  };

  Future<List<PlaceSuggestion>> getPlaceSuggestions(String input) async {
    if (input.isEmpty) {
      return [];
    }

    final uri =
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.getSuggestions}')
            .replace(queryParameters: {'input': input});

    try {
      final response = await _client.get(uri, headers: _headers);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((json) =>
                PlaceSuggestion.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to get suggestions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching place suggestions: $e');
    }
  }
}
