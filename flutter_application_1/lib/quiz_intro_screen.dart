import 'quiz_pager_screen.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

class QuizIntroScreen extends StatelessWidget {
  // 🌟 1. 宣告要從上一頁（暱稱頁）接過來的四個變數
  final String name;
  final String username;
  final String password;
  final String email;

  // 🌟 2. 修改建構子，要求跳轉過來時一定要帶上這四個資料
  const QuizIntroScreen({
    super.key,
    required this.name,
    required this.username,
    required this.password,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5), // 米色背景
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF5D4037)),
      ),
      body: Stack(
        children: [
          // ================= 【背景波浪】 =================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: QuizWaveClipper(),
              child: Container(
                height: 380, // 這個波浪比較深，高度設大一點
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFBBAA), Color(0xFFFFE4C4)],
                  ),
                ),
              ),
            ),
          ),

          // ================= 【主要內容區塊】 =================
          // 🌟 關鍵在這裡！在 SafeArea 和 Column 之間，加入 SingleChildScrollView
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView( // <--- 加入這個！！！
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // 整體置中對齊
                children: [
                  const SizedBox(height: 120), // 往下推，讓標題壓在波浪邊緣

                  // 標題
                  Text(
                    AppLocalizations.of(context)!.quizIntroTitle,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF5D4037), letterSpacing: 2),
                  ),
                  const SizedBox(height: 16),

                  // 說明文字
                  Text(
                    AppLocalizations.of(context)!.quizIntroSubtitle1,
                    style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.5),
                  ),
                  Text(
                    AppLocalizations.of(context)!.quizIntroSubtitle2,
                    style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.5),
                  ),
                  
                  const SizedBox(height: 40), // 👈 上方空間佔 2 份，星星會被往下推

                  // --- 替換原本的 Image.asset 部分 ---
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 1), // 動進度從 0 到 1
                    duration: const Duration(milliseconds: 1200), // 動畫持續 1.2 秒
                    curve: Curves.easeOutBack, // 帶有一點點回彈的優雅曲線
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: (value - 1) * 0.5, // 這裡控制轉動角度：從 -0.5 弧度轉到 0 (正向)
                        child:Opacity(
                                  opacity: value.clamp(0.0, 1.0), // 👈 加上 .clamp(0.0, 1.0) 強制鎖定範圍
                                  child: SizedBox(
                            width: 450,  // 👈 在這裡調整星星的「寬度」
                            height: 450, // 👈 在這裡調整星星的「高度」
                            child: Image.asset(
                              'assets/star.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // --------------------------------

                  // ❌ 刪除這行
                  // const Spacer(), // 自動撐開中間的空間

                  // ✅ 換成這行 (你可以自由調整這個數字來決定星星和按鈕之間的距離)
                  const SizedBox(height: 40), // 自動撐開中間的空間

                  // ================= 【開始探索按鈕】 =================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          // 點擊後，推入 (push) 我們的滑動問卷總司令頁面
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              // 🌟 1. 記得把 const 拿掉！
                              builder: (context) => QuizPagerScreen( 
                                // 🌟 2. 把手上的資料交給下一棒的問卷頁！
                                name: name,             
                                username: username,
                                password: password,
                                email: email,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          // ... 底下的顏色設定維持原樣 ...
                          backgroundColor: const Color.fromARGB(255, 254, 210, 107),
                          foregroundColor: const Color(0xFF5D4037),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.startExploreBtn,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60), // 底部留白
                ],
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}

// ================= 【專屬波浪剪裁器】 =================
class QuizWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 120);
    
    // 畫出兩個起伏的波浪，還原你的設計圖
    var firstControlPoint = Offset(size.width * 0.2, size.height - 150);
    var firstEndPoint = Offset(size.width * 0.4, size.height - 80);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    
    var secondControlPoint = Offset(size.width * 0.55, size.height);
    var secondEndPoint = Offset(size.width * 0.75, size.height - 60);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    
    var thirdControlPoint = Offset(size.width * 0.9, size.height - 100);
    var thirdEndPoint = Offset(size.width, size.height - 60);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy, thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}