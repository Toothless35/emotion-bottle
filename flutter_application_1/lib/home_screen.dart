import 'mood_selection_screen.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'quiz_pager_screen.dart'; // 🌟 引入波浪剪裁器

// 🌟 引入其他三個分頁檔案
import 'data_screen.dart';
import 'store_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 記錄目前底部導覽列選中的項目
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // 🌟 定義這四個導航按鈕對應的頁面
    final List<Widget> pages = [
      const HomeContent(), // 首頁內容 (我們把它獨立寫在檔案最下方)
      const DataScreen(),  // 數據頁
      const StoreScreen(), // 商城頁
      const ProfileScreen(),// 個人頁
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EE),
      body: Stack(
        children: [
          // ================= 1. 頁面內容切換區 =================
          // 🌟 這裡使用 IndexedStack，它會根據 _currentIndex 顯示對應的頁面，且不會忘記之前的滑動狀態！
          IndexedStack(
            index: _currentIndex,
            children: pages,
          ),

          // ================= 2. 自訂底部導覽列 =================
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // 🌟 1. 我們把原本的 height: 80 刪掉了！
              // 🌟 2. 改用 padding 來把空間自然撐開，特別是底部留 25 像素避開手機的手勢橫線
              padding: const EdgeInsets.only(top: 10, bottom: 15), 
              decoration: const BoxDecoration(
                color: Color(0xFFFAF8F5),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(icon: Icons.home_outlined, label: loc.navHome, index: 0),
                  _buildNavItem(icon: Icons.smartphone_outlined, label: loc.navData, index: 1),
                  _buildNavItem(icon: Icons.shopping_bag_outlined, label: loc.navStore, index: 2),
                  _buildNavItem(icon: Icons.person_outline, label: loc.navProfile, index: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 建立底部導覽按鈕的小工具
  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      // 🌟 點擊導航按鈕時，更新 _currentIndex，畫面就會瞬間切換！
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        color: Colors.transparent, // 讓點擊範圍變大
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE1F0FF) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? const Color(0xFF5A7A94) : const Color(0xFF5D4037),
                size: 28,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? const Color(0xFF5A7A94) : const Color(0xFF5D4037),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// ================= 獨立出來的「首頁專屬內容區塊」 ========================
// =====================================================================

// 🌟 1. 定義健康狀態的列舉 (Enum)，讓邏輯更清晰
enum HealthStatus { normal, warning, sleep, alert }

// 🌟 2. 將 StatelessWidget 改為 StatefulWidget，讓畫面可以隨數據更新
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // 模擬從穿戴裝置傳來的即時數據 (預設 72)
  int _currentHeartRate = 72;

  // 🌟 3. 根據數據判斷當前的狀態區間
  HealthStatus get _currentStatus {
      if (_currentHeartRate <= 60) {
        return HealthStatus.sleep;   // 🌟 告訴大腦：小於等於 60 是睡眠狀態！
      } else if (_currentHeartRate > 60 && _currentHeartRate < 85) {
        return HealthStatus.normal;  // 61 ~ 84 是正常
      } else if (_currentHeartRate >= 85 && _currentHeartRate < 110) {
        return HealthStatus.warning; // 85 ~ 109 是稍微異常
      } else {
        return HealthStatus.alert;   // 110 以上是極度異常
      }
    }

  // 🌟 4. 定義不同狀態下的「漸層顏色」
  List<Color> get _currentGradientColors {
    switch (_currentStatus) {
      case HealthStatus.normal:
        return const [Color(0xFFFFD194), Color(0xFFF79A8B)]; // 暖黃 -> 粉橘 (平靜)
      case HealthStatus.warning:
        return const [Color.fromARGB(255, 255, 215, 53), Color.fromARGB(255, 255, 152, 92)]; // 黃 -> 橘 (稍微緊繃)
      case HealthStatus.sleep:
        return const [Color.fromARGB(255, 255, 241, 209), Color.fromARGB(255, 255, 207, 219)]; // 淺黃 -> 淺粉橘 (睡眠中)
      case HealthStatus.alert:
        return const [Color.fromARGB(255, 255, 215, 53), Color.fromARGB(255, 103, 92, 255)]; // 黃 -> 紫藍 (警告)
    }
  }

  // 模擬接收硬體數據的方法 (測試用)
  void _simulateDeviceData() {
    setState(() {
      // 每次點擊，在 70, 95, 120 之間循環切換，模擬不同狀態
      if (_currentHeartRate == 72) {
        _currentHeartRate = 95;
      } else if (_currentHeartRate == 95) {
        _currentHeartRate = 120;
      } 
      else if (_currentHeartRate == 120) { _currentHeartRate = 50; }
      else {
        _currentHeartRate = 72;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final gradientColors = _currentGradientColors; // 取得當前該顯示的顏色

    return Stack(
      children: [
        // 頂部漸層波浪 (顏色會隨狀態改變)
        ClipPath(
          clipper: QuizWaveClipper(),
          // 加入 AnimatedContainer 讓顏色切換時有柔和的漸變動畫
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800), 
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                // 波浪需要一點透明度，所以我們加上 .withAlpha(100) (大約 40% 透明度)
                colors: gradientColors.map((c) => c.withAlpha(100)).toList(),
              ),
            ),
          ),
        ),

        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                // 愛心分數 (加入點擊事件來模擬數據變化)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: _simulateDeviceData, // 🌟 秘密測試按鈕：點擊這裡切換數據！
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          // 狀態越異常，背景色會稍微變深一點點提示
                          color: _currentStatus == HealthStatus.normal 
                              ? const Color(0xFFFBE4E4) 
                              : gradientColors.last.withAlpha(50), 
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _currentStatus == HealthStatus.alert ? Icons.favorite : Icons.favorite_border, 
                              color: const Color(0xFF5D4037), 
                              size: 20
                            ),
                            const SizedBox(width: 8),
                            // 顯示即時心率
                            Text(
                              "$_currentHeartRate", 
                              style: const TextStyle(color: Color(0xFF5D4037), fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 120),
                Text(
                  loc.homePromptText,
                  style: const TextStyle(fontSize: 18, color: Color(0xFF5D4037), fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 250,
                  child: Image.asset('assets/bottlewithmarbles.png', fit: BoxFit.contain), 
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // 🌟 點擊後，由下往上滑出心情挑選頁面
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MoodSelectionScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0F8),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFFB0C4DE), width: 1.5),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                    ),
                    child: Text(
                      loc.homePickMoodBtn,
                      style: const TextStyle(fontSize: 16, color: Color(0xFF5A7A94), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // ECHO 漸層圓形按鈕 (顏色會隨狀態改變)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 800), // 顏色平滑過渡時間
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: gradientColors, // 🌟 使用動態計算出來的漸層色 (實心)
                    ),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
                    border: Border.all(color: const Color(0xFF5D4037), width: 1),
                  ),
                  child: const Center(
                    child: Text(
                      "ECHO",
                      style: TextStyle(fontSize: 18, color: Color(0xFF5D4037), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ],
    );
  }
}