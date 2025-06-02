import 'package:flutter/material.dart';
import 'package:pr/theme/theme.dart';

class PRPage extends StatefulWidget {
  const PRPage({super.key});

  @override
  State<PRPage> createState() => _PRPageState();
}

class _PRPageState extends State<PRPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode.colorScheme.surface,
      body: const Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text("PR"),
          ),
        ],
      ),
    );
  }
}
