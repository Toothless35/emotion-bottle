import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

class MoodSelectionScreen extends StatefulWidget {
  const MoodSelectionScreen({super.key});

  @override
  State<MoodSelectionScreen> createState() => _MoodSelectionScreenState();
}

class _MoodSelectionScreenState extends State<MoodSelectionScreen> {
  int _selectedCategoryIndex = 0;
  final Set<String> _selectedMoods = {};

  @override
  Widget build(BuildContext context) {
    // 🌟 召喚字典
    final loc = AppLocalizations.of(context)!;

    // 🌟 1. 將類別清單移到這裡，並換成字典變數
    final List<String> categories = [
      loc.categoryWarm,
      loc.categoryCalm,
      loc.categoryStorm,
      loc.categoryMixed,
    ];

    // 🌟 1. 改寫 warmMoods (把 colors 換成 image)
    final List<Map<String, dynamic>> warmMoods = [
      {'name': loc.moodHappy, 'image': 'assets/happy.png'},         // 快樂
      {'name': loc.moodJoy, 'image': 'assets/joy.png'},             // 喜悅
      {'name': loc.moodExpectant, 'image': 'assets/expect.png'},    // 期待
      {'name': loc.moodBlessed, 'image': 'assets/happiness.png'},     // 幸福
      {'name': loc.moodAtEase, 'image': 'assets/ease.png'},         // 安心
      {'name': loc.moodPeaceful, 'image': 'assets/calm.png'},           // 平靜
      {'name': loc.moodHope, 'image': 'assets/hope.png'},           // 希望
      {'name': loc.moodLove, 'image': 'assets/love.png'},           // 愛
      {'name': loc.moodTender, 'image': 'assets/gentle.png'},       // 溫柔
      {'name': loc.moodAtEase, 'image': 'assets/free.png'},
    ];

    // 🌟 2. 新增第二頁的陣列 (靜靜感受)
    final List<Map<String, dynamic>> calmMoods = [
      {'name': loc.moodTired, 'image': 'assets/tired.png'}, 
      {'name': loc.moodBored, 'image': 'assets/boring.png'},
      {'name': loc.moodLonely, 'image': 'assets/lonely.png'},
      {'name': loc.moodAnxious, 'image': 'assets/anxious.png'},
      {'name': loc.moodNervous, 'image': 'assets/nervous.png'},
      {'name': loc.moodHesitant, 'image': 'assets/hesitate.png'},
      {'name': loc.moodAwkward, 'image': 'assets/embrassing.png'}, // 如果沒有尷尬的圖，請換成你實際存的檔名
      {'name': loc.moodEnvious, 'image': 'assets/envy.png'},
      {'name': loc.moodGuilty, 'image': 'assets/guiltyconsience.png'},
      {'name': loc.moodRegretful, 'image': 'assets/regret.png'},
    ];
    
    // 🌟 3. 新增第三頁的陣列 (情緒風暴)
    final List<Map<String, dynamic>> stormMoods = [
      {'name': loc.moodAngry, 'image': 'assets/angry.png'},
      {'name': loc.moodJealous, 'image': 'assets/jealous.png'},
      {'name': loc.moodFearful, 'image': 'assets/afraid.png'},
      {'name': loc.moodScared, 'image': 'assets/dread.png'},
      {'name': loc.moodSad, 'image': 'assets/sad.png'},
      {'name': loc.moodDesperate, 'image': 'assets/desperation.png'},
      {'name': loc.moodAshamed, 'image': 'assets/ashamed.png'},
      {'name': loc.moodBreakdown, 'image': 'assets/crumble.png'},
      {'name': loc.moodIrritable, 'image': 'assets/upset.png'},
      {'name': loc.moodStressed, 'image': 'assets/stress.png'},
    ];

    // 🌟 4. 新增第四頁的陣列 (交織心情)
    final List<Map<String, dynamic>> mixedMoods = [
      {'name': loc.moodMissing, 'image': 'assets/miss.png'},
      {'name': loc.moodWeary, 'image': 'assets/easebuttired.png'},
      {'name': loc.moodUnderstood, 'image': 'assets/understood.png'},
      {'name': loc.moodIgnored, 'image': 'assets/neglect.png'},
      {'name': loc.moodFocused, 'image': 'assets/focus.png'},
      {'name': loc.moodHealed, 'image': 'assets/cure.png'},
      {'name': loc.moodRelieved, 'image': 'assets/reliease.png'},
      {'name': loc.moodGrowth, 'image': 'assets/grow.png'},
    ];

    // 🌟 5. 最後！把這四個房間裝進一個大陣列 (超級關鍵)
    final List<List<Map<String, dynamic>>> allCategoryMoods = [
      warmMoods,   // index 0
      calmMoods,   // index 1
      stormMoods,  // index 2
      mixedMoods,  // index 3
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EE),
      body: Stack(
        children: [
          // 背景漸層
          Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0x66F79A8B), Color(0x66FFD194)],
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_circle_left_outlined, size: 32, color: Color(0xFF5D4037)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 10),
                // 🌟 使用字典的提示文字 (我們直接沿用首頁的 homePromptText)
                Text(
                  loc.homePromptText,
                  style: const TextStyle(fontSize: 18, color: Color(0xFF5D4037), fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset('assets/bottle.png', fit: BoxFit.contain), 
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF6D9),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Wrap(
                          spacing: 25,     // 🌟 間距調成 25，確保 4 個一列
                          runSpacing: 25,  // 🌟 上下間距調成 25
                          alignment: WrapAlignment.center,
                          // 🌟 換成這個！這樣它才會根據你點的類別去抓對應的球
                          children: allCategoryMoods[_selectedCategoryIndex]
                              .map((mood) => _buildMoodSphere(mood))
                              .toList(),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 40, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F0F8),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: const Color(0xFFB0C4DE), width: 1.5),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                        ),
                        // 🌟 使用字典的按鈕文字
                        child: Text(
                          loc.putInBottleBtn,
                          style: const TextStyle(fontSize: 16, color: Color(0xFF5A7A94), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.45 - 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // 🌟 將傳入 _buildCategoryIcon 的資料換成 categories
              children: List.generate(categories.length, (index) => _buildCategoryIcon(index, categories[index])),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodSphere(Map<String, dynamic> mood) {
    final String name = mood['name'];
    final String imagePath = mood['image']; // 🌟 關鍵：這裡改成讀取圖片路徑！
    final bool isSelected = _selectedMoods.contains(name);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedMoods.remove(name);
          } else {
            _selectedMoods.add(name);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        width: 65,
        height: 65,
        transform: Matrix4.diagonal3Values(isSelected ? 1.15 : 1.0, isSelected ? 1.15 : 1.0, 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
                  const BoxShadow(color: Colors.white, blurRadius: 15, spreadRadius: 5),
                  BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10, offset: const Offset(0, 5)),
                ]
              : [
                  const BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 3)),
                ],
        ),
        // 🌟 使用 Stack 把你的 Figma 圖片墊在底層，文字疊在上面
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipOval(
              child: Image.asset(imagePath, fit: BoxFit.cover, width: 65, height: 65),
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF5D4037),
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.white70, blurRadius: 2)],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // 🌟 把它貼在檔案的最下面，補回你遺失的分類按鈕函數！
  Widget _buildCategoryIcon(int index, String categoryName) {
    final bool isSelected = _selectedCategoryIndex == index;
    return GestureDetector(
      // 👇 就是這行程式碼讓上面的藍線消失的！它負責切換頁面
      onTap: () => setState(() => _selectedCategoryIndex = index),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.white : Colors.white60,
              border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
              boxShadow: isSelected ? [const BoxShadow(color: Colors.black12, blurRadius: 5)] : [],
            ),
            // 💡 小提醒：如果你在 Figma 也有匯出上面那四顆代表分類的大圖示
            // 之後可以把這個 Container 換成 Image.asset 喔！
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              categoryName, 
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF5D4037),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}