// 🌟 記得在最上面引入你的首頁檔案
import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'quiz_pager_screen.dart';

class GuardianAnimal {
  final String name;
  final String imagePath;
  final String description1;
  final String description2;

  GuardianAnimal({
    required this.name,
    required this.imagePath,
    required this.description1,
    required this.description2,
  });
}

class ResultScreen extends StatelessWidget {
  final int score;

  const ResultScreen({super.key, required this.score});

  // 🌟 2. 讓這個函數接收 loc (字典) 作為參數
  GuardianAnimal _getGuardian(AppLocalizations loc) {
    if (score <= 4) {
      return GuardianAnimal(
        name: loc.guardianQuokkaName, // 替換為字典變數
        imagePath: "assets/quokka.png",
        description1: loc.guardianQuokkaDesc1,
        description2: loc.guardianQuokkaDesc2,
      );
    } else if (score <= 9) {
      return GuardianAnimal(
        name: loc.guardianPenguinName,
        imagePath: "assets/penquin.png",
        description1: loc.guardianPenguinDesc1,
        description2: loc.guardianPenguinDesc2,
      );
    } else if (score <= 14) {
      return GuardianAnimal(
        name: loc.guardianRabbitName,
        imagePath: "assets/rabbit.png",
        description1: loc.guardianRabbitDesc1,
        description2: loc.guardianRabbitDesc2,
      );
    } else {
      return GuardianAnimal(
        name: loc.guardianHedgehogName,
        imagePath: "assets/hedgedog.png",
        description1: loc.guardianHedgehogDesc1,
        description2: loc.guardianHedgehogDesc2,
      );
    }
  }

@override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final guardian = _getGuardian(loc);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      body: Stack(
        children: [
          // 頂部漸層波浪 (維持原樣)
          ClipPath(
            clipper: QuizWaveClipper(),
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0x66F79A8B), Color(0x66FFD194)], 
                ),
              ),
            ),
          ),

          SafeArea(
            // 🌟 破解黃黑條紋的法寶：加上 SingleChildScrollView，讓畫面可以上下滑動！
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 90), // 標題下移
                  
                  Text(
                    loc.resultTitle,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
                  ),
                  
                  const SizedBox(height: 5), // 拉近標題與名稱的距離
                  
                  Text(
                    guardian.name,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D4037),
                      shadows: [
                        Shadow(offset: Offset(2.0, 2.0), blurRadius: 4.0, color: Colors.black26),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40), // 拉近名稱與動物的距離
                  
                  // 🌟 動物圖片區塊
                  SizedBox(
                    height: 280, // 👈 這裡設定高度，寬度讓它自動適應
                    child: Image.asset(
                      guardian.imagePath,
                      fit: BoxFit.contain,
                      // 🌟 破解巨大空白的法寶：強制圖片「向上對齊」，讓牠乖乖貼著名稱！
                      alignment: Alignment.topCenter, 
                    ),
                  ),
                  
                  const SizedBox(height: 40), // 拉近動物與描述的距離
                  
                  // 描述段落 1
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      guardian.description1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.3), // 行距 1.3
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // 描述段落 2
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      guardian.description2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.3, fontWeight: FontWeight.w600),
                    ),
                  ),
                  
                  const SizedBox(height: 45),
                  
                  // 開啟通知按鈕
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: 未來這裡可以加上向系統要求開啟通知的程式碼
                          
                          // 🌟 跳轉到首頁並清空歷史紀錄
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()), // 替換成你的首頁 Class
                            (route) => false, // false 代表清空所有先前的頁面
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 254, 210, 107), 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Color(0xFF5D4037), width: 1.5), 
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          loc.enableNotifBtn, 
                          style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 3),
                  
                  // 不開啟通知按鈕
                  TextButton(
                    onPressed: () {
                      // 🌟 直接跳轉到首頁並清空歷史紀錄
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()), // 替換成你的首頁 Class
                        (route) => false,
                      );
                    },
                    child: Text(
                      loc.skipNotifBtn, 
                      style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037)),
                    ),
                  ),
                  
                  const SizedBox(height: 40), // 底部多加一點留白，滑動時更順眼
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  }