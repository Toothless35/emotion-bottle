import 'welcome_screen.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

class NicknameScreen extends StatefulWidget {
  const NicknameScreen({super.key});

  @override
  State<NicknameScreen> createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> {
  final TextEditingController _nicknameController = TextEditingController();
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
      // 這裡使用 Stack 來疊加背景波浪與前方內容
      body: Stack(
        children: [
          // ================= 【圖層 1：頂部波浪】 =================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: TopWaveClipper(),
              child: Container(
                height: 250,
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

          // ================= 【圖層 2：右下角不規則色塊】 =================
          Positioned(
            bottom: 60, // 稍微距離底部一點
            right: -50, // 讓色塊稍微超出右邊界，呈現 Figma 上的視覺效果
            child: ClipPath(
              clipper: BottomBlobClipper(),
              child: Container(
                width: 350,
                height: 300,
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

          // ================= 【圖層 3：主要內容區塊】 =================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 靠左對齊
                children: [
                  const SizedBox(height: 100), // 距離頂部一點空間
                  
                  // 標題
                  Text(
                    AppLocalizations.of(context)!.helloTitle,
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w400, color: Color(0xFF5D4037)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.helloSubtitle,
                    style: const TextStyle(fontSize: 18, color: Color(0xFF5D4037), letterSpacing: 1),
                  ),
                  
                  const SizedBox(height: 60),

                  // 暱稱輸入框
                  TextField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.nicknameHint,
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFF3E5D8),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xFF5D4037), width: 2.0),
                      ),
                    ),
                  ),

                  const Spacer(), // 佔據所有剩餘空間，把按鈕推到最下面

                  // 出發按鈕
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        // 抓取剛剛綁定遙控器的文字，傳遞給 WelcomeScreen！
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreen(
                              nickname: _nicknameController.text, // 將打好的字當作禮物包裝過去
                            ),
                          ),
                        );
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
                        AppLocalizations.of(context)!.goBtn,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60), // 底部留白
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
class TopWaveClipper extends CustomClipper<Path> {
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
class BottomBlobClipper extends CustomClipper<Path> {
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