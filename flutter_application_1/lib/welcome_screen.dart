import 'quiz_intro_screen.dart';
import 'terms_screen.dart';
import 'privacy_screen.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  // 👇 這裡準備接收從上一頁傳過來的暱稱！
  final String nickname;

  const WelcomeScreen({super.key, required this.nickname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF5D4037)),
      ),
      body: Stack(
        children: [
          // ================= 【圖層 1：頂部波浪】 =================
          Positioned(
            top: 0, left: 0, right: 0,
            child: ClipPath(
              clipper: WelcomeTopWaveClipper(),
              child: Container(
                height: 250,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFBBAA), Color(0xFFFFE4C4)],
                  ),
                ),
              ),
            ),
          ),

          // ================= 【圖層 2：右下角不規則色塊】 =================
          Positioned(
            bottom: -40, right: -50,
            child: ClipPath(
              clipper: WelcomeBottomBlobClipper(),
              child: Container(
                width: 350, height: 300,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFBBAA), Color(0xFFFFE4C4)],
                  ),
                ),
              ),
            ),
          ),

          // ================= 【圖層 3：主要文字區塊】 =================
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 90),
                  
                  // 歡迎標題 + 傳遞過來的暱稱
                  Text(
                    AppLocalizations.of(context)!.welcomeJoin,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
                  ),
                  Text(
                    // 如果使用者沒輸入暱稱就按下一步，預設給他一個驚嘆號
                    nickname.isEmpty ? '!' : '$nickname!',
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
                  ),
                  const SizedBox(height: 50),

                  // 第一段詩意文字
                  Text(
                    AppLocalizations.of(context)!.welcomePara1,
                    style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.8), // height 增加行距，讓文字有呼吸感
                  ),
                  const SizedBox(height: 32),

                  // 第二段詩意文字
                  Text(
                    AppLocalizations.of(context)!.welcomePara2,
                    style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), height: 1.8),
                  ),
                  const SizedBox(height: 90),

                  // 我準備好了按鈕
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        // 點擊後進入測驗前導頁面！
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QuizIntroScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  const Color.fromARGB(255, 254, 210, 107),
                        foregroundColor: const Color(0xFF5D4037),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.readyBtn,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // 👇 剛剛加上去的「使用條款」點擊事件
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TermsScreen()),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.termsOfUse, 
                          style: const TextStyle(color: Color(0xFF5D4037), fontSize: 12, decoration: TextDecoration.underline),
                        ),
                      ),
                      
                      // 👇 這是我們上一回合做好的「隱私政策」
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PrivacyScreen()),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.privacyPolicy, 
                          style: const TextStyle(color: Color(0xFF5D4037), fontSize: 12, decoration: TextDecoration.underline), 
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.consentText,
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= 【上方波浪剪裁器】 =================
class WelcomeTopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    var firstControlPoint = Offset(size.width / 3, size.height);
    var firstEndPoint = Offset(size.width / 1.5, size.height - 40);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height - 60);
    var secondEndPoint = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// ================= 【右下角不規則色塊剪裁器】 =================
class WelcomeBottomBlobClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.2, size.width * 0.5, size.height * 0.1);
    path.quadraticBezierTo(size.width * 0.9, 0, size.width, size.height * 0.3);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.5, size.height);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.9, 0, size.height * 0.7);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}