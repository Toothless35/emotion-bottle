import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // 控制第二張圖彈跳的開關
  bool _showSecondImage = false;

  @override
  void initState() {
    super.initState();
    
    // 1秒後，打開第二張圖的開關
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _showSecondImage = true; 
        });
      }
    });

    // 3.5秒後，跳轉到登入頁面
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(milliseconds: 3500));
    if (!mounted) return;
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // 我們給圖片們一個「畫布區塊」來對齊
        child: SizedBox(
          width: 600, 
          height: 600,
          child: Stack(
            clipBehavior: Clip.none, // 允許第二張圖片稍微超出這個畫布範圍
            children: [
              // ================= 【第一層：第一張圖在正中間】 =================
              Align(
                alignment: Alignment.center,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1000), 
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value, 
                      child: child,
                    );
                  },
                  child: Image.asset(
                    'assets/logo_cho.png', // 你的主 Logo
                    width: 430,
                    height: 430,
                  ),
                ),
              ),
              
              // ================= 【第二層：第二張圖在左上角】 =================
              Positioned(
                // 👇 你可以修改這裡的數字來微調第二張圖片的位置！
                // 數字越小越靠邊緣，甚至可以使用負數 (例如 top: -10) 讓它飛出去一點
                top: 143,  
                left: 38, 
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: _showSecondImage ? 1.0 : 0.0),
                  duration: const Duration(milliseconds: 800), 
                  curve: Curves.easeOutBack, 
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value, 
                      child: child,
                    );
                  },
                  child: Image.asset(
                    'assets/logo_e.png', // 左上角的點綴 Logo
                    // 通常點綴的圖案會稍微小一點，這裡幫你預設 50，可自由更改
                    width: 300,  
                    height: 300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}