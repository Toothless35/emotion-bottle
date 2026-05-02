import 'package:flutter/material.dart';

// 🌟 1. 建立一個全域的「共用資料庫」，預設大家的球數都是 0
Map<String, int> globalWeeklyData = {
  'Warm Moments': 0,
  'Quiet Feelings': 0,
  'Emotional Storm': 0,
  'Mixed Moods': 0,
};

class BottleInsideScreen extends StatelessWidget {
    const BottleInsideScreen({super.key});

  // 🌟 根據類別取得對應的圖片路徑 (請替換成你實際的圖片名稱)
  String _getSphereImage(String category) {
    switch (category) {
      case 'Warm Moments': return 'assets/warmtime.png'; 
      case 'Quiet Feelings': return 'assets/silentfeel.png';
      case 'Emotional Storm': return 'assets/emotionstrom.png';
      case 'Mixed Moods': return 'assets/weavemood.png';
      default: return 'assets/warm_sphere.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. 邏輯運算：找出數量最多的類別
    String maxCategory = globalWeeklyData.keys.first;
    int maxCount = 0;
    globalWeeklyData.forEach((key, value) {
      if (value > maxCount) {
        maxCount = value;
        maxCategory = key;
      }
    });

    // 2. 準備裝所有球的清單
    List<Widget> spheres = [];
    
    // 預先設定幾個在畫面中的位置 (使用 Align 的 Alignment，0.0 是正中間)
    // 這樣球就不會全部疊在一起
    final List<Alignment> positions = [
      const Alignment(-0.8, 0.1),   // 0. 中間偏下 (留給最大顆的球)
      const Alignment(0.1, 0.1), // 1. 左上
      const Alignment(0.7, 0.2),   // 2. 右下
      const Alignment(-0.4, 0.4),  // 3. 左下
      const Alignment(0.2, 0.35),  // 4. 右上
    ];
    int posIndex = 0;

    // 3. 根據邏輯把球放進畫面上
    globalWeeklyData.forEach((category, count) {
      if (count > 0) {
        if (category == maxCategory) {
          // 🏆 如果是第一名的類別：放一顆巨大球 (150) + 一顆普通球 (80)
          spheres.add(_buildSphere(_getSphereImage(category), 150, positions[posIndex++ % positions.length]));
          spheres.add(_buildSphere(_getSphereImage(category), 80, positions[posIndex++ % positions.length]));
        } else {
          // 🎈 其他類別：放一顆普通球 (80)
          spheres.add(_buildSphere(_getSphereImage(category), 80, positions[posIndex++ % positions.length]));
        }
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EE), // 預設背景底色
      body: Stack(
        children: [
          // 🌊 1. 背景圖 (這裡放你截圖裡那張波浪粉黃背景)
          // 如果你有把背景存成圖片，請解開下面這行的註解並改對路徑
          Image.asset('assets/background.png', fit: BoxFit.cover, width: double.infinity, height: double.infinity),

          // 🎈 2. 散落的情緒球
          ...spheres,

          // 🔙 3. 左上角返回按鈕
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_circle_left_outlined, size: 32, color: Color(0xFF5D4037)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 畫出一顆球的共用元件
  Widget _buildSphere(String imagePath, double size, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        width: size,
        height: size,
        // ⚠️ 這裡先用 Container 暫代，等你確定圖片路徑後，改成下面那行 Image.asset
        // 👇 這裡才是魔法的關鍵！它會自動吃上面傳進來的 imagePath 變數！
        child: Image.asset(imagePath, fit: BoxFit.contain), 
      ),
    );
  }
}