import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';


class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  // 🌟 核心狀態 1：控制心率 (true) 還是睡眠 (false)
  bool isHeartRate = true; 
  
  // 🌟 核心狀態 2：控制時間尺度 (0:週, 1:月, 2:年)
  int scaleIndex = 0; 
  
  // 🌟 核心狀態 3：目前的基準日期 (用來計算上下週/月/年)
  DateTime currentDate = DateTime.now();

  // 🧮 計算要顯示的日期文字 (加入 context 參數來判斷語言)
  String _getDateRangeText(BuildContext context) {
    // 🌟 判斷當前系統是否為英文
    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';

    if (scaleIndex == 0) { // 週：計算本週一到週日
      int weekday = currentDate.weekday;
      DateTime start = currentDate.subtract(Duration(days: weekday - 1));
      // 🌟 修正這裡：直接把週一加上 6 天，就是完整的禮拜日！
      DateTime end = start.add(const Duration(days: 6));
      return '${start.month}/${start.day}~${end.month}/${end.day}';
    } else if (scaleIndex == 1) { // 月
      if (isEnglish) {
        List<String> enMonths = [
          'January', 'February', 'March', 'April', 'May', 'June',
          'July', 'August', 'September', 'October', 'November', 'December'
        ];
        return enMonths[currentDate.month - 1]; 
      } else {
        return '${currentDate.month}月'; 
      }
    } else { // 年
      return '${currentDate.year}';
    }
  }

  // ⬅️ 按下左箭頭
  void _previous() {
    setState(() {
      if (scaleIndex == 0) {
        currentDate = currentDate.subtract(const Duration(days: 7));
      } else if (scaleIndex == 1) {
        currentDate = DateTime(currentDate.year, currentDate.month - 1, 1);
      } else {
        currentDate = DateTime(currentDate.year - 1, currentDate.month, 1);
      }
    });
  }

  // ➡️ 按下右箭頭
  void _next() {
    setState(() {
      if (scaleIndex == 0) {
        currentDate = currentDate.add(const Duration(days: 7));
      } else if (scaleIndex == 1) {
        currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
      } else {
        currentDate = DateTime(currentDate.year + 1, currentDate.month, 1);
      }
    });
  }

  @override
Widget build(BuildContext context) {
  final loc = AppLocalizations.of(context)!; // 🌟 呼叫字典
  
  // 🎨 定義主題色
  Color heartColor = const Color(0xFFF7D2D2); // 淺粉底
  Color heartBorder = const Color(0xFFEABDBA); // 粉紅框
  Color sleepColor = const Color(0xFFD2E4F7); // 淺藍底
  Color sleepBorder = const Color(0xFFA0C4E2); // 藍框
  
  Color currentThemeColor = isHeartRate ? heartColor : sleepColor;
  Color currentBorderColor = isHeartRate ? heartBorder : sleepBorder;

  return Scaffold(
    backgroundColor: const Color(0xFFFCF9ED),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // 🌟 1. 整體下移：增加頂部間距
            const SizedBox(height: 60), 

            // 🌟 2. 完美還原 Figma 的膠囊滑動開關
            GestureDetector(
              onTap: () => setState(() => isHeartRate = !isHeartRate),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300), // 背景變色的動畫時間
                width: 220, // 膠囊總寬度
                height: 100, // 膠囊總高度
                padding: const EdgeInsets.all(6), // 讓裡面的圓形滑塊跟邊框保持一點距離
                decoration: BoxDecoration(
                  color: currentThemeColor.withValues(alpha: 0.5), // 淺粉 / 淺藍背景
                  borderRadius: BorderRadius.circular(50), // 完美的半圓形膠囊邊緣
                  border: Border.all(
                    color: currentBorderColor, 
                    width: 3,
                  ),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 300), // 滑動動畫的時間
                  curve: Curves.easeInOut, // 滑動的節奏感（平滑加速減速）
                  // 🌟 關鍵邏輯：心率靠左，睡眠靠右
                  alignment: isHeartRate ? Alignment.centerLeft : Alignment.centerRight,
                  
                  // 裡面的圓形滑塊 (包含圖案)
                  child: Container(
                    width: 84, // 圓形滑塊的寬高
                    height: 84,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isHeartRate ? const Color(0xFFFFA3A3) : const Color(0xFFA0C4E2), // 滑塊底色
                      boxShadow: [
                        BoxShadow(
                          color: currentBorderColor.withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    // 根據狀態顯示裡面的內容 (愛心數字 or 月亮)
                    child: Center(
                      child: isHeartRate 
                        ? const Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.favorite, color: Colors.white, size: 55),
                              Text('77', style: TextStyle(color: Color(0xFFFFA3A3), fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          )
                        : const Icon(Icons.nightlight_round, color: Colors.yellow, size: 55), // 這裡可以換成你專屬的月亮圖
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),

            // 🌟 3. 週/月/年 (文字從字典抓)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildScaleButton(loc.dataWeek, 0),
                  _buildScaleButton(loc.dataMonth, 1),
                  _buildScaleButton(loc.dataYear, 2),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🌟 4. 日期切換 (< 5/4~5/6 >)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: _previous, icon: Icon(Icons.arrow_back_ios, size: 20, color: currentBorderColor)),
                Text(
                  _getDateRangeText(context), // 🌟 這裡要記得把 context 傳進去！
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 1.2)
                ),
                IconButton(onPressed: _next, icon: Icon(Icons.arrow_forward_ios, size: 20, color: currentBorderColor)),
              ],
            ),
            const SizedBox(height: 20),

            // 🌟 5. 數據圖表區 (圖片版)
            Container(
              width: 320,
              height: 220,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D), // 深色背景
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias, // 讓圖片不會超出圓角
              child: Image.asset(
                isHeartRate ? 'assets/heart_chart_mock.png' : 'assets/sleep_chart_mock.png',
                fit: BoxFit.cover, // 填滿整個框框
              ),
            ),

            const SizedBox(height: 15),
            Text(loc.dataMoreInfo, style: const TextStyle(color: Colors.grey, fontSize: 16)), // 🌟 字典

            const SizedBox(height: 30),

            // 🌟 6. 底部介紹卡片
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: currentThemeColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isHeartRate ? loc.dataAboutHeartRate : loc.dataAboutSleep, // 🌟 字典
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown[700]),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    isHeartRate ? loc.dataHeartRateDesc : loc.dataSleepDesc, // 🌟 字典
                    style: TextStyle(fontSize: 15, height: 1.6, color: Colors.brown[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 150),// 🌟 把原本的 SizedBox(height: 50) 加大到 120 或是 150
            // 這樣就可以把整個畫面往上頂，讓被導航欄蓋住的文字可以完全滑動出來！
          ],
        ),
      ),
    ),
  );
}

// 輔助方法：建立尺度按鈕
Widget _buildScaleButton(String label, int index) {
  bool isSelected = scaleIndex == index;
  return GestureDetector(
    onTap: () => setState(() => scaleIndex = index),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: BoxDecoration(
        color: isSelected ? (isHeartRate ? const Color(0xFFF7D2D2) : const Color(0xFFD2E4F7)) : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        label, 
        style: TextStyle(
          color: isSelected ? Colors.brown[800] : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
        )
      ),
    ),
  );
}
}