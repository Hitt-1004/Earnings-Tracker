import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/earnings_provider.dart';
import 'views/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => EarningsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Earnings Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
