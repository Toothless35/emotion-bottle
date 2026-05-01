import 'package:flutter/material.dart';

// 這是一個通用的樣板頁面，用來展示跳轉結果
class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const PlaceholderScreen({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5), // 米色背景
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF5D4037)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: const Color(0xFF5D4037)),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
            ),
            const SizedBox(height: 16),
            const Text('（此頁面為版面展示，實際登入邏輯需串接後端）', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// 忘記密碼頁面
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) => const PlaceholderScreen(title: '忘記密碼頁面', icon: Icons.lock_reset);
}