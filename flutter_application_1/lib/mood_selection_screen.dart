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

    // 🌟 2. 將情緒球資料移到這裡，名稱換成字典變數
    final List<Map<String, dynamic>> warmMoods = [
      {'name': loc.moodHappy, 'colors': [const Color(0xFFE89A60), const Color(0xFFD47C45)]},
      {'name': loc.moodJoy, 'colors': [const Color(0xFFF3D23D), const Color(0xFFD1B021)]},
      {'name': loc.moodExpectant, 'colors': [const Color(0xFFF0A786), const Color(0xFFD98A66)]},
      {'name': loc.moodBlessed, 'colors': [const Color(0xFFEF7C9E), const Color(0xFFD45D81)]},
      {'name': loc.moodRelieved, 'colors': [const Color(0xFF3DF37D), const Color(0xFF21D15C)]},
      {'name': loc.moodPeaceful, 'colors': [const Color(0xFF3DF3E8), const Color(0xFF21D1C5)]},
      {'name': loc.moodHope, 'colors': [const Color(0xFF5DF33D), const Color(0xFF45D121)]},
      {'name': loc.moodLove, 'colors': [const Color(0xFFF33D5D), const Color(0xFFD12145)]},
      {'name': loc.moodTender, 'colors': [const Color(0xFFF3A4C2), const Color(0xFFD182A0)]},
      {'name': loc.moodAtEase, 'colors': [const Color(0xFF7CD4FF), const Color(0xFF5AAEE6)]},
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
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.center,
                          // 🌟 將傳入 _buildMoodSphere 的資料換成剛剛定義的 warmMoods
                          children: warmMoods.map((mood) => _buildMoodSphere(mood)).toList(),
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
    final List<Color> colors = mood['colors'];
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
        transform: Matrix4.identity()..scale(isSelected ? 1.15 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          boxShadow: isSelected
              ? [
                  const BoxShadow(color: Colors.white, blurRadius: 15, spreadRadius: 5),
                  BoxShadow(color: colors.last.withOpacity(0.6), blurRadius: 10, offset: const Offset(0, 5)),
                ]
              : [
                  const BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 3)),
                ],
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF5D4037),
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.white70, blurRadius: 2)],
            ),
          ),
        ),
      ),
    );
  }

  // 🌟 修改這裡：多接收一個 categoryName 參數
  Widget _buildCategoryIcon(int index, String categoryName) {
    final bool isSelected = _selectedCategoryIndex == index;
    return GestureDetector(
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
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              categoryName, // 🌟 使用傳入的字典文字
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