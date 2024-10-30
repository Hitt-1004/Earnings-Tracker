import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/earnings_provider.dart';
import 'graph.dart';

class HomeScreen extends StatelessWidget {
  final _tickerController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Earnings Tracker"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Track Company Earnings",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _tickerController,
                decoration: InputDecoration(
                  labelText: 'Enter Company Ticker',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  filled: true,
                  fillColor: Colors.blue[50],
                  prefixIcon: const Icon(Icons.business, color: Colors.blueAccent),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_tickerController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid ticker symbol'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  } else {
                    final provider = Provider.of<EarningsProvider>(context, listen: false);
                    provider.fetchEarningsData(_tickerController.text.trim());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GraphScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text("View Earnings Data"),
              ),
              const SizedBox(height: 20),
              Text(
                "Enter the company's ticker symbol (e.g., AAPL, TSLA) to view recent earnings data.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
