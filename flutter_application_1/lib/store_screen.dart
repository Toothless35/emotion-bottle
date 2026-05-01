import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFF9EE),
      body: Center(
        child: Text("療癒商城頁面", style: TextStyle(fontSize: 24, color: Color(0xFF5D4037))),
      ),
    );
  }
}