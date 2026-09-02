import 'package:flutter/material.dart';

void main() {
  runApp(const AcuteFlowApp());
}

class AcuteFlowApp extends StatelessWidget {
  const AcuteFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AcuteFlow',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(),
    );
  }
}