import 'disagree_screen.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5), // 你的米色背景
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF5D4037)), // 深棕色返回鍵
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // 讓上方的圖示和標題置中
            children: [
              const SizedBox(height: 20),
              
              // ================= 【上方圓形鎖頭圖示】 =================
              Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  color: Color(0xFFEBE3D8), // 圓圈的淺底色
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_outline_rounded, // 內建的圓潤鎖頭圖示
                  size: 80,
                  color: Color(0xFF5D4037),
                ),
              ),
              const SizedBox(height: 40),

              // ================= 【標題】 =================
              Text(
                AppLocalizations.of(context)!.privacyTitle,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // ================= 【內文區塊】 =================
              // 為了讓內文靠左對齊，我們用一個 SizedBox 包起來讓它填滿寬度
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.privacyPara1,
                      style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.6),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppLocalizations.of(context)!.privacyPara2,
                      style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.6),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppLocalizations.of(context)!.privacyPara3,
                      style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.6),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),

              // ================= 【同意按鈕 (實心黃色)】 =================
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    // 點擊同意，關閉此頁面回到歡迎頁
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 254, 210, 107),
                    foregroundColor: const Color(0xFF5D4037),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.agreeBtn,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ================= 【不同意按鈕 (空心)】 =================
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      // 注意看這裡！我們傳入 isPrivacy: true
                      MaterialPageRoute(builder: (context) => const DisagreeScreen(isPrivacy: true)),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF5D4037),
                    side: const BorderSide(color: Color(0xFF5D4037), width: 1.5), // 深棕色邊框
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.disagreeBtn,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}