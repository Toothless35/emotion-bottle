import 'verification_screen.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // 這次我們需要兩個開關：一個給密碼，一個給確認密碼
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      // 👇 這個超神奇！它能讓原本的 AppBar 變成透明圖層，波浪就可以畫到手機最頂部！
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF5D4037)), // 深棕色返回鍵
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= 【頂部波浪漸層背景】 =================
            ClipPath(
              clipper: RegisterWaveClipper(), // 我們在底下給註冊頁面專屬的剪裁器
              child: Container(
                height: 220,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFBBAA),
                      Color(0xFFFFE4C4),
                    ],
                  ),
                ),
              ),
            ),
            
            // ================= 【標題區塊】 =================
            Text(AppLocalizations.of(context)!.registerTitle,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF5D4037), letterSpacing: 2),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.registerSubtitle,
              style: TextStyle(fontSize: 18, color: Color(0xFF5D4037), letterSpacing: 1),
            ),
            const SizedBox(height: 40),

            // ================= 【輸入框區塊】 =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 電子信箱
                  Text(AppLocalizations.of(context)!.email, style: TextStyle(fontSize: 16, color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildTextField('Email', fieldType: 'email'),
                  const SizedBox(height: 24),

                  // 使用者名稱
                  Text(AppLocalizations.of(context)!.usersname, style: TextStyle(fontSize: 16, color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildTextField('Name', fieldType: 'name'),
                  const SizedBox(height: 24),

                  // ================= 【密碼與確認密碼並排區塊】 =================
                  Row(
                    children: [
                      // 左半邊：密碼
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.fgtpassword, style: TextStyle(fontSize: 16, color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            _buildTextField('Password', fieldType: 'password'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16), // 中間的間距
                      
                      // 右半邊：確認密碼
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.cfmpassword, style: TextStyle(fontSize: 16, color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            _buildTextField('Password', fieldType: 'confirm'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // ================= 【註冊按鈕】 =================
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // 點擊註冊後，跳轉到驗證碼頁面
                        Navigator.push(
                           context,
                          MaterialPageRoute(builder: (context) => const VerificationScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 254, 210, 107), // Figma上的黃色
                        foregroundColor: const Color(0xFF5D4037),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                        ),
                      ),
                      child: Text(AppLocalizations.of(context)!.registerText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // ================= 【底部返回登入】 =================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.haveAccountText, style: TextStyle(color: Color(0xFF5D4037))),

                // 👇 魔法在這裡：塞入一個寬度為 8 的隱形方塊來撐開它們！
                 const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // 點擊後直接返回上一頁（登入頁）
                  },
                  child: Text(AppLocalizations.of(context)!.loginBtn, style: TextStyle(color: Color(0xFF965F4F), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ================= 【多功能的輸入框生成器】 =================
  Widget _buildTextField(String hint, {required String fieldType}) {
    // 判斷當前這個輸入框是否需要隱藏文字
    bool isObscure = false;
    if (fieldType == 'password') {
      isObscure = !_isPasswordVisible;
    } else if (fieldType == 'confirm') {
      isObscure = !_isConfirmPasswordVisible;
    }

    return TextField(
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFF3E5D8),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF5D4037), width: 2.0),
        ),
        // 如果是密碼欄位，就顯示專屬的眼睛圖示
        suffixIcon: (fieldType == 'password' || fieldType == 'confirm')
            ? IconButton(
                icon: Icon(
                  (fieldType == 'password' ? _isPasswordVisible : _isConfirmPasswordVisible)
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: const Color(0xFF5D4037),
                  size: 20, // 為了並排塞得下，稍微縮小一點圖示
                ),
                onPressed: () {
                  setState(() {
                    if (fieldType == 'password') {
                      _isPasswordVisible = !_isPasswordVisible;
                    } else {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    }
                  });
                },
              )
            : null,
      ),
    );
  }
}

// ================= 【用來畫頂部波浪的剪裁器 (防止與登入頁衝突，重新命名)】 =================
class RegisterWaveClipper extends CustomClipper<Path> {
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