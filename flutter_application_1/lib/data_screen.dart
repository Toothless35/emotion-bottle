import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFF9EE), // 維持溫暖米色背景
      body: Center(
        child: Text("數據中心頁面", style: TextStyle(fontSize: 24, color: Color(0xFF5D4037))),
      ),
    );
  }
}