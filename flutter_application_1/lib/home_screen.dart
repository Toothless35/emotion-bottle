import 'bottle_inside_screen.dart';
import 'mood_selection_screen.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'quiz_pager_screen.dart'; // 🌟 引入波浪剪裁器

// 🌟 引入其他三個分頁檔案
import 'data_screen.dart';
import 'shop_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  // 🌟 1. 宣告這頁需要接收這四個變數
  final String name;
  final String username;
  final String password;
  final String email;

  // 🌟 2. 修改建構子接收資料
  const HomeScreen({
    super.key,
    required this.name,
    required this.username,
    required this.password,
    required this.email,
  });

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
      // 🌟 把遙控器傳給首頁，設定成「點擊時，把分頁切換到 index 1 (數據頁)」
    HomeContent(
      onJumpToData: () {
        setState(() {
          _currentIndex = 1; // 如果你的數據頁在第二個，index 就是 1
        });
      },
    ),
      const DataScreen(),  // 數據頁
      const ShopScreen(), // 商城頁
      // ... 前面可能是你的 Home, Data 頁面
      // 👇 確保第 4 個真的是 ProfileScreen！
      ProfileScreen(             
        name: widget.name,
        username: widget.username,
        password: widget.password,
        email: widget.email,
      ),
    ]; // 這是你第 33 行的結尾

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
              padding: const EdgeInsets.only(top: 10, bottom: 10), 
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
  // 🌟 1. 宣告接收這個遙控器
  final VoidCallback onJumpToData; 

  const HomeContent({
    super.key, 
    required this.onJumpToData, // 🌟 2. 規定外面呼叫時一定要給遙控器
  });

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

    // 🌟 準備呼叫字典裡的通知文字
    final loc = AppLocalizations.of(context)!;

    // 🌟 判斷狀態並推播對應的通知
    if (_currentHeartRate == 95) {
      _showAppNotification(loc.msgHrWarning, isAlert: false);
    } else if (_currentHeartRate == 120) {
      _showAppNotification(loc.msgHrAlert, isAlert: true);
    }
  }
  // 🌟 2. 建立一個專屬的浮動通知小工具 (SnackBar)
  void _showAppNotification(String message, {required bool isAlert}) {
    // 先清除畫面上舊的通知，避免狂點時通知卡住疊在一起
    ScaffoldMessenger.of(context).clearSnackBars(); 
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            // 根據嚴重程度顯示不同的 Icon
            Icon(
              isAlert ? Icons.warning_amber_rounded : Icons.info_outline, 
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message, 
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating, // 讓通知浮動在畫面上
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // 圓角設計
        margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20), // 距離底部和兩側的空間
        backgroundColor: isAlert ? Colors.redAccent.shade700 : Colors.orange.shade700, // 警示用紅色，提醒用橘色
        duration: const Duration(seconds: 4), // 顯示 4 秒後自動消失
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final gradientColors = _currentGradientColors; // 取得當前該顯示的顏色

    return GestureDetector(
      // 🌟 確保點在空白處也能穿透抓到
      behavior: HitTestBehavior.translucent, 
      onTap: () {
        // 🌟 點擊畫面的任何空白處，都會變換心率！
        _simulateDeviceData(); 
      },
      child: Stack(
        children: [
          // ================= 1. 底層：漸層波浪背景 =================
          ClipPath(
            clipper: QuizWaveClipper(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors.map((c) => c.withAlpha(100)).toList(),
                ), 
              ), 
            ), 
          ), 

          // ================= 2. 上層：主要內容區塊 =================
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // 👇 你的愛心分數從這裡開始往下接，不要動到下面的程式碼囉！
                const SizedBox(height: 10),
                // 愛心分數 (加入點擊事件來模擬數據變化)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        //_simulateDeviceData(); // 保留你原本的測試功能
                        widget.onJumpToData(); // 🌟 加上這行：按下遙控器，呼叫外面的主畫面切換分頁！
                      }, // 🌟 秘密測試按鈕：點擊這裡切換數據！
                      // 🌟 刪除 _simulateDeviceData(); 
                      // 現在它是一顆純粹的傳送門，只負責跳轉！
                 
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
                              // 🌟 把這裡的文字從寫死的 '72' 改成抓變數！
                              '$_currentHeartRate', 
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                // 🌟 把原本裝瓶子的 SizedBox，用 GestureDetector 包起來！
                GestureDetector(
                  onTap: () {
                    // 跳轉到剛剛寫好的瓶內世界！
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const BottleInsideScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 250,
                    child: Image.asset('assets/bottlewithmarbles.png', fit: BoxFit.contain),
                  ),
                ), // 結束這個新增的 GestureDetector
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
      ], // 這是關閉 Stack 的 children [ ... ] 陣列
            ), // 🌟 補上這個！用來關閉 Stack()
          ); // 🌟 這個用來關閉最外層的 return GestureDetector()
        } // 這個是關閉 build(BuildContext context) 函數
}