import 'package:flutter/material.dart';

class SoilPage extends StatefulWidget {
  const SoilPage({super.key});

  @override
  State<SoilPage> createState() => _SoilPageState();
}

class _SoilPageState extends State<SoilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Page'),
      ),
      body: Center(
        child: Text(
          'This is the Soil Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}