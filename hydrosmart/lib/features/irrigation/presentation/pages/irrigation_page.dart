import 'package:flutter/material.dart';

class IrrigationPage extends StatefulWidget {
  const IrrigationPage({super.key});

  @override
  State<IrrigationPage> createState() => _IrrigationPageState();
}

class _IrrigationPageState extends State<IrrigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Irrigation Page'),
      ),
      body: Center(
        child: Text(
          'This is the Irrigation Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}