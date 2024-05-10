import 'package:flutter/material.dart';

class PriereScreen extends StatefulWidget {
  const PriereScreen({super.key});

  @override
  State<PriereScreen> createState() => _PriereScreenState();
}

class _PriereScreenState extends State<PriereScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('priere time'),
      ),
    );
  }
}
