import 'nickname_screen.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= 【頂部波浪漸層背景】 =================
            ClipPath(
              clipper: VerifyWaveClipper(),
              child: Container(
                height: 220,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFBBAA), Color(0xFFFFE4C4)],
                  ),
                ),
              ),
            ),
            
            // ================= 【標題區塊】 =================
            Text(
              AppLocalizations.of(context)!.verifyTitle,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF5D4037), letterSpacing: 2),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.verifySubtitle,
              style: const TextStyle(fontSize: 18, color: Color(0xFF5D4037), letterSpacing: 1),
            ),
            const SizedBox(height: 50),

            // ================= 【說明文字區塊】 =================
            Text(
              AppLocalizations.of(context)!.verifyInstruction1,
              style: const TextStyle(fontSize: 15, color: Color(0xFF5D4037)),
            ),
            const SizedBox(height: 4),
            Text(
              AppLocalizations.of(context)!.verifyInstruction2,
              style: const TextStyle(fontSize: 15, color: Color(0xFF5D4037)),
            ),
            const SizedBox(height: 32),

            // ================= 【6顆圓圈驗證碼區塊】 =================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildOtpBox(context),
                _buildOtpBox(context),
                _buildOtpBox(context),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('-', style: TextStyle(fontSize: 24, color: Color(0xFF5D4037))),
                ),
                _buildOtpBox(context),
                _buildOtpBox(context),
                _buildOtpBox(context),
              ],
            ),
            const SizedBox(height: 40),

            // ================= 【確認按鈕】 =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // 點擊確認後，跳轉到暱稱設定頁面！
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NicknameScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 254, 210, 107),
                    foregroundColor: const Color(0xFF5D4037),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 你設計圖上的確認按鈕圓角比較小，這裡設定為10
                      side: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.confirmBtn,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),

            // ================= 【底部返回登入】 =================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.haveAccountText,
                  style: const TextStyle(color: Color(0xFF5D4037)),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    // 退回最底層的登入頁面
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.loginBtn,
                    style: const TextStyle(color: Color(0xFF965F4F), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 獨立出來的工具：畫出完美的驗證碼圓形輸入框
  Widget _buildOtpBox(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5D8), // 粉米色底
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF5D4037), width: 1.5),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number, // 只允許輸入數字
        maxLength: 1, // 只能輸入1個字
        style: const TextStyle(fontSize: 20, color: Color(0xFF5D4037), fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          counterText: "", // 隱藏右下角的 0/1 字數統計
          border: InputBorder.none, // 隱藏輸入框自帶的底線
          // 👇 把 top 往下推一點點 (例如推 2~4 的距離，你可以慢慢試)
          contentPadding: EdgeInsets.only(top: -4),
        ),
        onChanged: (value) {
          // 輸入完1個數字後，焦點自動跳到下一個圓圈！
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}

// 專屬這頁的波浪剪裁器
class VerifyWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint = Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}