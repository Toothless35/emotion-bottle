import 'category_detail_screen.dart';
import 'package:flutter/material.dart';

/// 🌟 1. 定義「情緒紀錄」的專屬格式
class MoodRecord {
  final String category; // 屬於哪個類別 (例如：Warm Moments)
  final String moodName; // 具體是哪顆球 (例如：Happy, Peaceful)
  final DateTime time;   // 放入的時間

  MoodRecord({required this.category, required this.moodName, required this.time});
}

// 🌟 2. 升級版小黑板：現在它是一個可以裝無限多筆紀錄的清單！
List<MoodRecord> globalMoodHistory = [];

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
    // 🌟 1. 從日記本自動結算每個類別有幾顆球
    Map<String, int> weeklyCounts = {'Warm Moments': 0, 'Quiet Feelings': 0, 'Emotional Storm': 0, 'Mixed Moods': 0};
    for (var record in globalMoodHistory) {
      weeklyCounts[record.category] = (weeklyCounts[record.category] ?? 0) + 1;
    }

    // 🌟 2. 找出數量最多的類別
    String maxCategory = weeklyCounts.keys.first;
    int maxCount = 0;
    weeklyCounts.forEach((key, value) {
      if (value > maxCount) { 
        maxCount = value; 
        maxCategory = key; 
      }
    });

    // 🌟 3. 就是這裡！被我害你刪掉的座標清單復活了！
    final List<Alignment> positions = [
      const Alignment(0.0, 0.1),   // 0. 中間偏下 (留給最大顆的球)
      const Alignment(-0.5, -0.3), // 1. 左上
      const Alignment(0.6, 0.4),   // 2. 右下
      const Alignment(-0.6, 0.5),  // 3. 左下
      const Alignment(0.4, -0.2),  // 4. 右上
    ];
    
    int posIndex = 0;
    List<Widget> spheres = [];

    // 🌟 4. 根據數量把球分配到畫面上的座標
    weeklyCounts.forEach((category, count) {
      if (count > 0) {
        if (category == maxCategory) {
          // 🏆 第一名：一大一小 
          spheres.add(_buildSphere(category, _getSphereImage(category), 150, positions[posIndex++ % positions.length], context));
          spheres.add(_buildSphere(category, _getSphereImage(category), 80, positions[posIndex++ % positions.length], context));
        } else {
          // 🎈 其他：一顆小球
          spheres.add(_buildSphere(category, _getSphereImage(category), 80, positions[posIndex++ % positions.length], context));
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

  // 畫出一顆球的共用元件 (多加了 category 和 context 參數來做跳轉)
  Widget _buildSphere(String category, String imagePath, double size, Alignment alignment, BuildContext context) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onTap: () {
          // 🌟 點擊球體，帶著類別名稱跳轉到明細頁面！
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryDetailScreen(categoryName: category)),
          );
        },
        child: SizedBox(
          width: size,
          height: size,
          child: Image.asset(imagePath, fit: BoxFit.contain), 
        ),
      ),
    );
  }
}