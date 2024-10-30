import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/earnings_provider.dart';
import '../widgets/earnings_graph.dart';
import 'transcript.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final earningsData = Provider.of<EarningsProvider>(context).earningsData;

    if (earningsData == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Earnings Graph"),
          backgroundColor: Colors.blueAccent,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Earnings Graph"),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EarningsGraph(
          earningsData: earningsData,
          onNodeTap: (date) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TranscriptScreen(date: date),
              ),
            );
          },
        ),
      ),
    );
  }
}
