import 'bottle_inside_screen.dart';
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
      {'name': loc.moodExpectant, 'image': 'assets/expectant.png'},    // 期待
      {'name': loc.moodBlessed, 'image': 'assets/blessed.png'},     // 幸福
      {'name': loc.moodRelieved, 'image': 'assets/at_ease.png'},         // 安心
      {'name': loc.moodPeaceful, 'image': 'assets/peaceful.png'},           // 平靜
      {'name': loc.moodHope, 'image': 'assets/hope.png'},           // 希望
      {'name': loc.moodLove, 'image': 'assets/love.png'},           // 愛
      {'name': loc.moodTender, 'image': 'assets/tender.png'},       // 溫柔
      {'name': loc.moodAtEase, 'image': 'assets/free.png'},
    ];

    // 🌟 2. 新增第二頁的陣列 (靜靜感受)
    final List<Map<String, dynamic>> calmMoods = [
      {'name': loc.moodTired, 'image': 'assets/tired.png'}, 
      {'name': loc.moodBored, 'image': 'assets/bored.png'},
      {'name': loc.moodLonely, 'image': 'assets/lonely.png'},
      {'name': loc.moodAnxious, 'image': 'assets/anxious.png'},
      {'name': loc.moodNervous, 'image': 'assets/nervous.png'},
      {'name': loc.moodHesitant, 'image': 'assets/hesitant.png'},
      {'name': loc.moodAwkward, 'image': 'assets/awkward.png'}, // 如果沒有尷尬的圖，請換成你實際存的檔名
      {'name': loc.moodEnvious, 'image': 'assets/envious.png'},
      {'name': loc.moodGuilty, 'image': 'assets/guilty.png'},
      {'name': loc.moodRegretful, 'image': 'assets/regretful.png'},
    ];
    
    // 🌟 3. 新增第三頁的陣列 (情緒風暴)
    final List<Map<String, dynamic>> stormMoods = [
      {'name': loc.moodAngry, 'image': 'assets/angry.png'},
      {'name': loc.moodJealous, 'image': 'assets/jealous.png'},
      {'name': loc.moodFearful, 'image': 'assets/fearful.png'},
      {'name': loc.moodScared, 'image': 'assets/scared.png'},
      {'name': loc.moodSad, 'image': 'assets/sad.png'},
      {'name': loc.moodDesperate, 'image': 'assets/despair.png'},
      {'name': loc.moodAshamed, 'image': 'assets/ashamed.png'},
      {'name': loc.moodBreakdown, 'image': 'assets/crumble.png'},
      {'name': loc.moodIrritable, 'image': 'assets/irritable.png'},
      {'name': loc.moodStressed, 'image': 'assets/stressed.png'},
    ];

    // 🌟 4. 新增第四頁的陣列 (交織心情)
    final List<Map<String, dynamic>> mixedMoods = [
      {'name': loc.moodMissing, 'image': 'assets/missing.png'},
      {'name': loc.moodWeary, 'image': 'assets/weary.png'},
      {'name': loc.moodUnderstood, 'image': 'assets/got_it.png'},
      {'name': loc.moodIgnored, 'image': 'assets/ignored.png'},
      {'name': loc.moodFocused, 'image': 'assets/focused.png'},
      {'name': loc.moodHealed, 'image': 'assets/healed.png'},
      {'name': loc.moodRelieved, 'image': 'assets/relieved.png'},
      {'name': loc.moodGrowth, 'image': 'assets/growth.png'},
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
        case 0: currentBottleImage = 'assets/sltwarm.png'; break;
        case 1: currentBottleImage = 'assets/sltsilent.png'; break;
        case 2: currentBottleImage = 'assets/sltstrom.png'; break;
        case 3: currentBottleImage = 'assets/sltweave.png'; break;
      }
    }
    // 🌟 貼到這裡結束！

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EE),
      body: Center( // 🌟 讓 App 在大螢幕時置中顯示
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450), // 🌟 限制最大寬度為 450 (常見手機寬度)
          // 👇 🌟 加上這個 SizedBox，把 Stack 「強制撐開」到滿屏高度！
          child: SizedBox(
            height: screenHeight,
            child: Stack(
            children: [
              // 背景漸層
              Container(
                height: screenHeight * 0.6, // 🌟 讓粉紅漸層自動佔據 60% 的螢幕，完美接軌下方的黃底板！
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
                  // 👇 1. 把字往下移：這裡的 height 從 10 改成 40，字就會下降
                  const SizedBox(height: 80),
                  // 漸變文字
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      currentPromptText,
                      key: ValueKey<String>(currentPromptText),
                      style: const TextStyle(fontSize: 18, color: Color(0xFF5D4037), fontWeight: FontWeight.w500),
                    ),
                  ),
                  // 讓字跟瓶子不要太開，這裡設為 0 或 10 即可
                  const SizedBox(height: 0),
                  // 🌟 用 Expanded 讓瓶子「自動撐滿」剩下的所有安全空間！
                  // 👇 2. 把瓶子往上移：找到這個 Expanded 裡的 padding
                  Expanded(
                    child: Padding(
                      // 1. 把過大的 bottom 邊距改回正常的安全距離 (例如 20)
                      padding: const EdgeInsets.only(bottom: 20), 
                      child: Align(
                        // 🌟 2. 關鍵魔法：利用 Alignment 控制垂直位置！
                        // y 軸的範圍是 -1.0 (最頂部) 到 1.0 (最底部)，0.0 是正中間。
                        // 使用負數 (-0.2 ~ -0.6) 就可以把瓶子完美地往上提！
                        alignment: const Alignment(0.0, -0.4), 
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Image.asset(currentBottleImage, key: ValueKey<String>(currentBottleImage), fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. 底部淺黃色面板 (裝 10 顆選項球的區域)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            // 🌟 關鍵魔法：空瓶時貼齊底部 (0)；滿瓶時，把它往下推一整個螢幕的高度藏起來！
            bottom: _isBottleFilled ? -MediaQuery.of(context).size.height : 0, 
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.48, 
              decoration: const BoxDecoration(
                color: Color(0xFFFFF6D9), // 淺黃色底板
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 70), // 配合你原本設定的高度
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.center,
                          children: allCategoryMoods[_selectedCategoryIndex]
                              .map((mood) => _buildMoodSphere(mood))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100), 
                ],
              ),
            ),
          ),

          // 4. 分類按鈕列
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            // 🌟 關鍵魔法：根據狀態切換高度！
            // 滿瓶時 (_isBottleFilled = true)：降落到距離底部 130 的位置 (為了不擋住瓶子，並剛好在下方按鈕上面)
            // 空瓶時 (_isBottleFilled = false)：維持在原本淺黃色底板上方的相對高度
            bottom: _isBottleFilled ? 130 : MediaQuery.of(context).size.height * 0.48 - 50,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20), // 螢幕左右留一點空白
              child: Row(
                children: List.generate(categories.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: _buildCategoryIcon(index, categories[index]),
                  );
                }),
              ),
            ),
          ),
          
          // 🌟 5. 底部獨立操作按鈕 (放在最後面，確保它永遠在最上層！)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isBottleFilled = !_isBottleFilled; 
                    
                    // 🌟 寫入日記的紀錄魔法
                    if (_isBottleFilled) {
                      List<String> categoryNames = ['Warm Moments', 'Quiet Feelings', 'Emotional Storm', 'Mixed Moods'];
                      // 🛡️ 加上防護網：預設為第一個類別。
                      // 只有當 _selectedCategoryIndex 是合法的數字 (0, 1, 2, 3) 時，才去抓對應的名稱！
                      String currentCategory = 'Warm Moments'; 
                      if (_selectedCategoryIndex >= 0 && _selectedCategoryIndex < categoryNames.length) {
                        currentCategory = categoryNames[_selectedCategoryIndex];
                      }
                      
                      for (String mood in _selectedMoods) {
                        globalMoodHistory.add(MoodRecord(
                          category: currentCategory,
                          moodName: mood,
                          time: DateTime.now(),
                        ));
                      }
                      _selectedMoods.clear(); 
                    }
                  }); // 👈 就是這裡的括號剛剛跑丟了！
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  decoration: BoxDecoration(
                    color: _isBottleFilled ? const Color(0xFFDFEAF5) : const Color(0xFFE8F0F8),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: const Color(0xFFB0C4DE), width: 1.5),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                  ),
                  child: Text(
                    // 根據狀態切換字典裡的按鈕文字
                    _isBottleFilled ? loc.reselectMoodBtn : loc.putInBottleBtn,
                    style: const TextStyle(fontSize: 16, color: Color(0xFF5A7A94), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
         ), // 結束 Positioned
          ], // 🌟 1. 把小括號換成中括號，用來結束 Stack 的 children 清單！
        ), // 🌟 2. 補上這個小括號，用來結束 Stack 本身！
      ), // 結束 SizedBox (剛剛新加的門)
    ), // 結束 ConstrainedBox (剛剛漏關的門)
  ), // 結束 Center (剛剛漏關的門)
); // 結束 Scaffold
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
         _selectedCategoryIndex = index; // 1. 切換到你點擊的那個類別
          _isBottleFilled = false;        // 2. 🌟 強制把狀態改回「空瓶」，黃色底板就會自己滑上來！
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