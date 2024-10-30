import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance/providers/earnings_provider.dart';

class TranscriptScreen extends StatelessWidget {
  final String date;

  const TranscriptScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EarningsProvider>(context);
    final ticker = provider.earningsData!.isNotEmpty
        ? provider.earningsData?.first['ticker'] as String? ?? ''
        : '';

    // Only trigger fetching if there's no transcript yet
    if (provider.transcript == null) {
      provider.fetchTranscript(ticker, date);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Earnings Transcript"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: provider.transcript == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$ticker Earnings Transcript',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: $date',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Divider(height: 32, thickness: 1.5),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        provider.transcript ?? 'No transcript available',
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
