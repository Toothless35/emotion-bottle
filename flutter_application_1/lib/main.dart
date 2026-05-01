//import 'result_screen.dart';
import 'package:flutter/material.dart';
// 👇 1. 引入這兩個負責翻譯的魔法檔案
import 'l10n/app_localizations.dart';
import 'splash_screen.dart';
//import 'home_screen.dart';

void main() {
  runApp(const EmotionBottleApp());
}

class EmotionBottleApp extends StatelessWidget {
  const EmotionBottleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emotion Bottle',
      debugShowCheckedModeBanner: false,

      // 🌟 加上這段 builder，強制限制最大寬度！
      builder: (context, child) {
        return Container(
          color: Colors.grey[200], // 電腦大螢幕時，左右兩側的背景顏色
          child: Center(
            child: ConstrainedBox(
              // 強制最大寬度為 450 (最常見的手機寬度比例)
              constraints: const BoxConstraints(maxWidth: 450), 
              child: child,
            ),
          ),
        );
      },
      
      // 👇 2. 把翻譯管線裝上去！
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAF8F5),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE5B8B8)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      //home: const ResultScreen(score: 20),
      //home: const HomeScreen(),
    );
  }
}