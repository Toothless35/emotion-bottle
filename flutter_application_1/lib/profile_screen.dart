import 'package:flutter/material.dart';

// 🌟 注意這裡！Class 名稱要是 ProfileScreen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFF9EE),
      body: Center(
        child: Text("個人設定頁面", style: TextStyle(fontSize: 24, color: Color(0xFF5D4037))),
      ),
    );
  }
}