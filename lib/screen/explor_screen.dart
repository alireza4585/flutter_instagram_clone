import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExplorScreen extends StatefulWidget {
  const ExplorScreen({super.key});

  @override
  State<ExplorScreen> createState() => _ExplorScreenState();
}

class _ExplorScreenState extends State<ExplorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Explor Screen'),
      ),
    );
  }
}
