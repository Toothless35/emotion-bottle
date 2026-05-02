import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

class MoodSelectionScreen extends StatefulWidget {
  const MoodSelectionScreen({super.key});

  @override
  State<MoodSelectionScreen> createState() => _MoodSelectionScreenState();
}

class _MoodSelectionScreenState extends State<MoodSelectionScreen> {
  int _selectedCategoryIndex = 0;
  // 🌟 把這行加在這裡！這是控制瓶子有沒有裝滿的開關
  bool _isBottleFilled = false;
  final Set<String> _selectedMoods = {};

  @override
  Widget build(BuildContext context) {
    // 🌟 召喚字典
    final loc = AppLocalizations.of(context)!;

    // 🌟 1. 將類別清單升級為包含圖片路徑的 Map
    final List<Map<String, String>> categories = [
      {'name': loc.categoryWarm, 'image': 'assets/warmtime.png'},   // 請替換成你實際的圖片檔名
      {'name': loc.categoryCalm, 'image': 'assets/silentfeel.png'},
      {'name': loc.categoryStorm, 'image': 'assets/emotionstrom.png'},
      {'name': loc.categoryMixed, 'image': 'assets/weavemood.png'},
    ];

    // 🌟 1. 改寫 warmMoods (把 colors 換成 image)
    final List<Map<String, dynamic>> warmMoods = [
      {'name': loc.moodHappy, 'image': 'assets/happy.png'},         // 快樂
      {'name': loc.moodJoy, 'image': 'assets/joy.png'},             // 喜悅
      {'name': loc.moodExpectant, 'image': 'assets/expect.png'},    // 期待
      {'name': loc.moodBlessed, 'image': 'assets/happiness.png'},     // 幸福
      {'name': loc.moodRelieved, 'image': 'assets/ease.png'},         // 安心
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
      {'name': loc.moodLonely, 'image': 'assets/lonly.png'},
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
      {'name': loc.moodRelieved, 'image': 'assets/release.png'},
      {'name': loc.moodGrowth, 'image': 'assets/grow.png'},
    ];

    // 🌟 5. 最後！把這四個房間裝進一個大陣列 (超級關鍵)
    final List<List<Map<String, dynamic>>> allCategoryMoods = [
      warmMoods,   // index 0
      calmMoods,   // index 1
      stormMoods,  // index 2
      mixedMoods,  // index 3
    ];

    // 🌟 把它們貼在 return Scaffold( 的正上方！
    final screenHeight = MediaQuery.of(context).size.height;

    // 1. 決定現在要顯示的文字(使用字典變數)
    String currentPromptText = loc.homePromptText;
    if (_isBottleFilled) {
      switch (_selectedCategoryIndex) {
        case 0: currentPromptText = loc.bottleFilledWarm; break;
        case 1: currentPromptText = loc.bottleFilledCalm; break;
        case 2: currentPromptText = loc.bottleFilledStorm; break;
        case 3: currentPromptText = loc.bottleFilledMixed; break;
      }
    }

    // 2. 決定現在要顯示的瓶子圖片
    String currentBottleImage = 'assets/bottle.png'; // 預設空瓶
    if (_isBottleFilled) {
      switch (_selectedCategoryIndex) {
        case 0: currentBottleImage = 'assets/bottle_warm.png'; break;
        case 1: currentBottleImage = 'assets/bottle_calm.png'; break;
        case 2: currentBottleImage = 'assets/bottle_storm.png'; break;
        case 3: currentBottleImage = 'assets/bottle_mixed.png'; break;
      }
    }
    // 🌟 貼到這裡結束！

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
          
          // 2. 頂部內容 (綁定在畫面上半部，絕不與底板重疊)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: 0,
            left: 0,
            right: 0,
            // 🌟 關鍵：空瓶時只佔據螢幕上半部 (52%)，滿瓶時自動佔據全螢幕
            bottom: _isBottleFilled ? 0 : screenHeight * 0.48, 
            child: SafeArea(
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
                  // 漸變文字
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      currentPromptText,
                      key: ValueKey<String>(currentPromptText),
                      style: const TextStyle(fontSize: 18, color: Color(0xFF5D4037), fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // 🌟 用 Expanded 讓瓶子「自動撐滿」剩下的所有安全空間！
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40), // 底部留一點白，不跟分類球打架
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Image.asset(currentBottleImage, key: ValueKey<String>(currentBottleImage), fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.48,// 🌟 降到底部佔比 48%
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF6D9),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 70),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        // 🌟 關鍵在這裡！
                        // 把 symmetric 換成 only，並保留原本的左右 (20)，然後新增 bottom (40 或更多)
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                        child: Wrap(
                          spacing: 20,     // 🌟 間距調成 25，確保 4 個一列
                          runSpacing: 20,  // 🌟 上下間距調成 25
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
                          // 🌟 根據狀態切換字典裡的按鈕文字
                          _isBottleFilled ? loc.reselectMoodBtn : loc.putInBottleBtn,
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
            // 🌟 1. 加入水平滑動魔法，這樣超出螢幕就可以滑動了！
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, 
              padding: const EdgeInsets.symmetric(horizontal: 20), // 螢幕最左邊和最右邊留一點空白，滑動時視覺更舒適
              child: Row(
                // ⚠️ 注意：這裡不需要設定 mainAxisAlignment 了，讓它們自然往右排
                children: List.generate(categories.length, (index) {
                  return Padding(
                    // 🌟 2. 幫每一顆球單獨加上左右邊距來控制距離！
                    // 把數字調小（例如 10 甚至 8），它們就會靠得更近
                    padding: const EdgeInsets.symmetric(horizontal: 10), 
                    child: _buildCategoryIcon(index, categories[index]),
                  );
                }),
              ),
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
          // 🌟 這是情緒球原本的邏輯：點擊加入或取消
          if (isSelected) {
            _selectedMoods.remove(name);
          } else {
            _selectedMoods.add(name);
          }      // 🌟 點擊任何類別時，強制回到「挑選模式」
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
                color: Color.fromARGB(255, 244, 243, 243),
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Color.fromARGB(255, 31, 15, 15), blurRadius: 1)],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // 🌟 更新接收的參數型別為 Map<String, String>
  Widget _buildCategoryIcon(int index, Map<String, String> categoryData) {
    final bool isSelected = _selectedCategoryIndex == index;
    final String categoryName = categoryData['name']!;
    final String imagePath = categoryData['image']!; // 抓出圖片路徑

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index; // 🌟 這裡才有 index 可以切換類別
          _isBottleFilled = false;        // 點擊任何類別時，強制回到「挑選模式」
        });
      },
      child: Column(
        children: [
          // 1. 分類圖示 (使用 Figma 圖片)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 55 : 45,   // 選中時稍微放大
            height: isSelected ? 55 : 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // 如果被選中，可以加個發光陰影讓它更明顯
              boxShadow: isSelected ? [const BoxShadow(color: Colors.white70, blurRadius: 10)] : [],
            ),
            child: ClipOval(
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 5),
          // 2. 分類文字
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              // 選中時文字底下可以墊個白色背景，或是維持透明
              color: isSelected ? const Color.fromARGB(255, 255, 203, 203) : Colors.transparent,
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