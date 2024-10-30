import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.api-ninjas.com/v1';
  final String apiKey = 'Enter API Key here';

  Future<List<Map<String, dynamic>>> getEarningsData(String ticker) async {
    print("Make sure to check if the API KEY is initialized correctly."); 
    // A message for other developers so that they can check the functioning by putting in their own API key from api-ninjas

    final url = Uri.parse('$baseUrl/earningscalendar?ticker=$ticker');
    final response = await http.get(url, headers: {
      'X-Api-Key': apiKey,
    });

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>(); // Casting the list elements as maps
    } else {
      throw Exception('Failed to load earnings data');
    }
  }

  Future<String> getTranscript(String ticker, String date) async {
    // print(ticker + " " + date);
    // print(date.split("-")[0] + " " + date.split("-")[1]);
    final month = int.parse(date.split("-")[1]); // Extract the month from the date
    String quarter;

    // Determine the quarter based on the month
    if (month >= 1 && month <= 3) {
        quarter = '1'; // Q1
    } else if (month >= 4 && month <= 6) {
        quarter = '2'; // Q2
    } else if (month >= 7 && month <= 9) {
        quarter = '3'; // Q3
    } else {
        quarter = '4'; // Q4
    }

    final year = date.split("-")[0]; // Extract the year
    print("$year $quarter");
    final url = Uri.parse('https://api.api-ninjas.com/v1/earningstranscript?ticker=$ticker&year=$year&quarter=$quarter');
    final response = await http.get(
      url,
      headers: {
        'X-Api-Key': apiKey,
      },
    );
    // print(response.statusCode);
    // print(response);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // print(data);
      return data['transcript'];
    } else {
      throw Exception('Failed to load transcript');
    }
  }
}
