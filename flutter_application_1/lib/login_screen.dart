import 'home_screen.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // 引入我們剛裝的品牌圖示套件
import 'register_screen.dart';
import 'auth_screens.dart'; // 引入我們剛剛做的跳轉頁面

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 👇 請在這裡加上這一行：這就是控制眼睛圖示開關的變數！
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5), // 米色背景
      body: SingleChildScrollView(
        // 讓畫面在小手機上也能滑動
        child: Column(
          children: [
            // ================= 【頂部波浪漸層背景】 =================
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 220,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFBBAA), // 頂部較深的粉橘色
                      Color(0xFFFFE4C4), // 底部較淺的米黃色
                    ],
                  ),
                ),
              ),
            ),
            
            // ================= 【標題區塊】 =================
            Text(
              AppLocalizations.of(context)!.loginTitle, // 呼叫字典裡的 loginTitle！
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF5D4037), letterSpacing: 2),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.loginSubtitle,
              style: TextStyle(fontSize: 18, color: Color(0xFF5D4037), letterSpacing: 1),
            ),
            const SizedBox(height: 40),

            // ================= 【輸入框與按鈕區塊】 =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 電子信箱
                  Text(AppLocalizations.of(context)!.email, style: TextStyle(fontSize: 16, color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildTextField('Email'),
                  const SizedBox(height: 24),

                  // 密碼
                  Text(AppLocalizations.of(context)!.password, style: TextStyle(fontSize: 16, color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildTextField('Password', isPassword: true),
                  const SizedBox(height: 24),
                  

                  // 登入按鈕 (黃色)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: 未來這裡可以加上驗證帳號密碼的邏輯
            
                        // 🌟 登入成功後，跳轉到首頁並清空歷史紀錄
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()), // 替換成你的首頁 Class
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 254, 210, 107), // Figma上的黃色
                        foregroundColor: const Color(0xFF5D4037),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // 圓角
                          side: const BorderSide(color: Color(0xFF5D4037), width: 1.5), // 深棕色邊框
                        ),
                      ),
                      child: Text(AppLocalizations.of(context)!.loginBtn, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 忘記密碼
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                    },
                    child: Text(AppLocalizations.of(context)!.fgtpassword, style: TextStyle(color: Color(0xFF5D4037), fontSize: 14)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // ================= 【第三方登入區塊】 =================
            Text(AppLocalizations.of(context)!.orLoginWith, style: TextStyle(color: Color(0xFF5D4037), fontSize: 14)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(const Icon(Icons.phone, size: 28, color: Color(0xFF5D4037)), '電話登入'),
                _buildSocialIcon(const FaIcon(FontAwesomeIcons.google, size: 28, color: Color(0xFF5D4037)), 'Google 登入'),
                _buildSocialIcon(const FaIcon(FontAwesomeIcons.facebookF, size: 28, color: Color(0xFF5D4037)), 'Facebook 登入'),
                _buildSocialIcon(const FaIcon(FontAwesomeIcons.instagram, size: 28, color: Color(0xFF5D4037)), 'Instagram 登入'),
                _buildSocialIcon(const FaIcon(FontAwesomeIcons.xTwitter, size: 28, color: Color(0xFF5D4037)), 'X 登入'),
              ],
            ),
            const SizedBox(height: 40),

            // ================= 【底部註冊按鈕】 =================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.noAccountText, style: TextStyle(color: Color(0xFF5D4037))),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                  },
                  child: Text(AppLocalizations.of(context)!.registerText, style: TextStyle(color: Color(0xFF965F4F), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 40), // 底部留白
          ],
        ),
      ),
    );
  }

// 獨立出來的小工具：用來畫輸入框 (升級版：支援眼睛圖示)
  Widget _buildTextField(String hint, {bool isPassword = false}) {
    return TextField(
      // 如果是密碼欄位，就根據 _isPasswordVisible 開關來決定是否隱藏文字
      obscureText: isPassword ? !_isPasswordVisible : false, 
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFF3E5D8), // Figma 上的粉米色底
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF5D4037), width: 2.0),
        ),
        // 👇 魔法在這裡：只有當它是密碼欄位時，才顯示右邊的眼睛圖示
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF5D4037), // 配合你設計的深棕色
                ),
                onPressed: () {
                  // 點擊時切換狀態，並重新整理畫面
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null, // 如果是一般的 Email 欄位，就不顯示任何東西
      ),
    );
  }

  // 獨立出來的小工具：用來畫底下的第三方圖示按鈕
 // 修改後：直接接收 Widget
  Widget _buildSocialIcon(Widget iconWidget, String targetPageName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: () {
          // 點擊後跳轉，為了避免型別衝突，我們統一給佔位頁面一個小星星圖示
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlaceholderScreen(title: targetPageName, icon: Icons.star_border)),
          );
        },
        child: iconWidget, // 直接把我們上面設定好的 Icon 或 FaIcon 顯示出來
      ),
    );
  }
  }

// ================= 【用來畫頂部波浪的剪裁器】 =================
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    
    // 第一個波浪
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    // 第二個波浪
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