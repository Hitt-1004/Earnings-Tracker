// lib/providers/earnings_provider.dart
import 'package:flutter/material.dart';
import 'package:finance/services/api_service.dart';

class EarningsProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Map<String, dynamic>>? earningsData;
  String? transcript;

  Future<void> fetchEarningsData(String ticker) async {
    try {
      earningsData = await _apiService.getEarningsData(ticker);
      notifyListeners();
    } catch (error) {
      print("Error fetching earnings data: $error");
    }
  }

  // In your EarningsProvider
Future<void> fetchTranscript(String ticker, String date) async {
    if (transcript == null) { // Only fetch if transcript is not already loaded
      transcript = await _apiService.getTranscript(ticker, date);
      notifyListeners();
    }
}

}
