import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

class DisagreeScreen extends StatelessWidget {
  // 👇 這個開關用來判斷：現在是要顯示「隱私政策」還是「使用條款」？
  final bool isPrivacy; 

  const DisagreeScreen({super.key, required this.isPrivacy});

  @override
  Widget build(BuildContext context) {
    // 為了讓底下的程式碼短一點，我們先把字典存成一個叫做 loc 的變數
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF5D4037)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 150),

              // ================= 【標題】 =================
              // 如果 isPrivacy 是 true，就顯示隱私標題，否則顯示條款標題
              Text(
                isPrivacy ? loc.disagreePrivacyTitle : loc.disagreeTermsTitle,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
              ),
              const SizedBox(height: 40),

              // ================= 【內文區塊】 =================
              // 這裡也是一樣，根據開關決定要抓哪三段文字！
              Text(
                isPrivacy ? loc.privacyPara1 : loc.termsPara1,
                style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.6),
              ),
              const SizedBox(height: 24),
              Text(
                isPrivacy ? loc.privacyPara2 : loc.termsPara2,
                style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.6),
              ),
              const SizedBox(height: 24),
              Text(
                isPrivacy ? loc.privacyPara3 : loc.termsPara3,
                style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.6),
              ),

              const Spacer(), // 把按鈕推到最底下

              // ================= 【再想想按鈕 (黃色實心)】 =================
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    // 點擊再想想：只退回上一頁（回到條款或隱私頁面）
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
                    loc.thinkAgainBtn,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ================= 【不同意並退出按鈕 (空心)】 =================
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () {
                    // 點擊退出：直接把人踢回最一開始的登入/歡迎畫面！
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF5D4037),
                    side: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    loc.exitBtn,
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