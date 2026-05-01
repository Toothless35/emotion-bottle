import 'disagree_screen.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5), // 米色背景
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF5D4037)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              
              // ================= 【上方圓形文件圖示】 =================
              Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  color: Color(0xFFEBE3D8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.description_outlined, // 換成合約/文件的圖示
                  size: 70,
                  color: Color(0xFF5D4037),
                ),
              ),
              const SizedBox(height: 40),

              // ================= 【標題】 =================
              Text(
                AppLocalizations.of(context)!.termsTitle,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // ================= 【內文區塊】 =================
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.termsPara1,
                      style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.6),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppLocalizations.of(context)!.termsPara2,
                      style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.6),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppLocalizations.of(context)!.termsPara3,
                      style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.6),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),

              // ================= 【同意按鈕】 =================
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // 返回上一頁
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
                    AppLocalizations.of(context)!.agreeBtn, // 重複使用同意的字典代號
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ================= 【不同意按鈕】 =================
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      // 注意看這裡！我們傳入 isPrivacy: false
                      MaterialPageRoute(builder: (context) => const DisagreeScreen(isPrivacy: false)),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF5D4037),
                    side: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.disagreeBtn, // 重複使用不同意的字典代號
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