import 'package:flutter/material.dart';
import 'bottle_inside_screen.dart'; // 為了讀取我們的 globalMoodHistory 日記本

class CategoryDetailScreen extends StatelessWidget {
  final String categoryName; // 接收你點了哪個類別

  const CategoryDetailScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // 🌟 核心邏輯：從日記本裡，篩選出屬於這個類別的所有球！
    List<MoodRecord> categoryRecords = globalMoodHistory
        .where((record) => record.category == categoryName)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EE),
      body: Stack(
        children: [
          // 🌊 背景圖 (解開註解並換成你截圖裡的波浪背景)
          // Image.asset('assets/inside_background.png', fit: BoxFit.cover, width: double.infinity, height: double.infinity),

          SafeArea(
            child: Column(
              children: [
                // 返回鍵
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_circle_left_outlined, size: 32, color: Color(0xFF5D4037)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 20),
                
                // 顯示現在在看哪個類別
                Text(
                  categoryName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
                ),
                const SizedBox(height: 40),

                // 🎈 畫出所有被選過的球和日期
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      spacing: 30, // 球與球的左右間距
                      runSpacing: 40, // 上下的間距
                      alignment: WrapAlignment.center,
                      children: categoryRecords.map((record) {
                        
                        // 🌟 防破圖魔法：把大寫轉小寫，把空格換成底線！
                        // 例如 'At Ease' 會自動變成 'at_ease'
                        // 如果你的圖檔名不是這種格式，請把圖檔名改成跟這轉換後一樣！
                        String safeFileName = record.moodName.toLowerCase().replaceAll(' ', '_');

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 1. 情緒球圖片 (套用防破圖魔法路徑)
                            SizedBox(
                              width: 80,
                              height: 80,
                              // 👇 改用 safeFileName 來尋找圖片！
                              child: Image.asset('assets/$safeFileName.png', fit: BoxFit.contain),
                            ),
                            const SizedBox(height: 10),
                            
                            // 🌟 2. 新增：顯示情緒的名字！
                            Text(
                              record.moodName,
                              style: const TextStyle(fontSize: 15, color: Color(0xFF5D4037), fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4), // 名字跟日期中間留一點點空隙
                            
                            // 3. 顯示日期 (月/日)
                            Text(
                              '${record.time.month}/${record.time.day}',
                              style: const TextStyle(fontSize: 14, color: Color(0xFF5D4037)),
                            )
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}