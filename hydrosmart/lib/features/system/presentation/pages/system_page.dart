import 'package:flutter/material.dart';

class SystemPage extends StatefulWidget {
  const SystemPage({super.key});

  @override
  State<SystemPage> createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Page'),
      ),
      body: Center(
        child: Text(
          'This is the System Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}