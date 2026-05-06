import 'dart:typed_data'; // 🌟 負責處理跨平台的圖片資料格式
import 'package:image_picker/image_picker.dart'; // 🌟 剛剛安裝的選照片套件
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // 🌟 為了使用漂亮的 CupertinoSwitch
import 'l10n/app_localizations.dart'; // 記得改成你的字典路徑
// import 'quiz_intro_screen.dart'; // 匯入你的問卷頁面
import 'login_screen.dart';      // 匯入你的登入頁面
import 'quiz_intro_screen.dart';
import 'register_screen.dart';   // 匯入你的註冊頁面

class ProfileScreen extends StatefulWidget {
  // 🌟 新增這四個變數來接收註冊資料
  final String name;
  final String username;
  final String password;
  final String email;

  // 🌟 修改建構子，讓它接受這些參數 (設定預設值防呆)
  const ProfileScreen({
    super.key,
    this.name = '休 · 傑克曼', 
    this.username = '彼得潘',
    this.password = '12345678',
    this.email = 'keyboard@gmail.com',
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // --- 狀態變數 ---
  bool _hasAvatar = false;
  Uint8List? _avatarBytes; // 🌟 新增：用來儲存真正選到的照片資料 (跨平台完美支援)
  final ImagePicker _picker = ImagePicker(); // 🌟 準備好我們的「照片挑選器」

  // ... (保留你原本的其他開關跟 TextEditingController 變數) ...

  // 🌟 真正呼叫系統相簿的上傳函數
  Future<void> _pickAvatar() async {
    // 1. 喚起系統的選擇檔案視窗 (Gallery)
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    
    // 2. 如果使用者有選照片 (沒有按取消)
    if (image != null) {
      // 3. 把圖片轉成 Bytes 讀取出來 (這個寫法讓網頁版和電腦版都能無痛顯示)
      final bytes = await image.readAsBytes();
      
      setState(() {
        _avatarBytes = bytes;
        _hasAvatar = true;
      });
    }
  } // 記錄是否已上傳頭像
  bool _isPrefExpanded = false; // 偏好面板是否展開
  bool _isProfileExpanded = false; // 個人資料面板是否展開

  // 藍芽裝置與系統開關狀態
  bool _lightEnabled = true;
  bool _soundEnabled = true;
  bool _notifEnabled = true;

  // 輸入框控制器 (自動帶入預設值)
  // 輸入框控制器 (宣告為 late，稍後在 initState 初始化)
  late TextEditingController _nameCtrl;
  late TextEditingController _usernameCtrl;
  late TextEditingController _pwdCtrl;
  late TextEditingController _emailCtrl;

  @override
  void initState() {
    super.initState();
    // 🌟 頁面載入時，把外部傳進來的 widget.xxx 資料塞進輸入框
    _nameCtrl = TextEditingController(text: widget.name);
    _usernameCtrl = TextEditingController(text: widget.username);
    _pwdCtrl = TextEditingController(text: widget.password);
    _emailCtrl = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    // 養成好習慣，頁面關閉時釋放控制器記憶體
    _nameCtrl.dispose();
    _usernameCtrl.dispose();
    _pwdCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

// ... (上面是你的變數宣告 _nameCtrl 等等) ...

  // 🌟 從這裡開始貼：彈出「刪除帳號」確認框
  void _showDeleteAccountDialog(AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFFFF9EE), // 溫暖米黃底色
        title: Text(loc.deleteConfirmTitle, style: const TextStyle(color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
        content: Text(loc.deleteConfirmMsg, style: const TextStyle(color: Color(0xFF8B6E60))),
        actions: [
          // 取消按鈕
          TextButton(
            onPressed: () => Navigator.pop(ctx), 
            child: Text(loc.dialogCancel, style: const TextStyle(color: Colors.grey)),
          ),
          // 確認刪除按鈕 (紅色警告)
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); 
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => const RegisterScreen()), 
                (route) => false,
              );
            },
            child: Text(loc.deleteConfirmBtn, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // 🌟 繼續貼：彈出「登出」確認框
  void _showLogoutDialog(AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFFFF9EE),
        title: Text(loc.logoutConfirmTitle, style: const TextStyle(color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
        content: Text(loc.logoutConfirmMsg, style: const TextStyle(color: Color(0xFF8B6E60))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), 
            child: Text(loc.dialogCancel, style: const TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => const LoginScreen()), 
                (route) => false,
              );
            },
            child: Text(loc.logoutConfirmBtn, style: const TextStyle(color: Color(0xFFA0C4E2), fontWeight: FontWeight.bold)), // 淺藍色登出字體
          ),
        ],
      ),
    );
  }

  // 建立可收合的區塊面板 (黃底 + 粉紅底)
  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFEABDBA), width: 1.5), // 粉紅邊框
      ),
      child: Column(
        children: [
          // 上半部黃色標題列
          InkWell(
            onTap: onToggle,
            borderRadius: isExpanded
                ? const BorderRadius.vertical(top: Radius.circular(13))
                : BorderRadius.circular(13),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3DB), // 黃底
                borderRadius: isExpanded
                    ? const BorderRadius.vertical(top: Radius.circular(13))
                    : BorderRadius.circular(13),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, color: Color(0xFF5D4037))),
                  Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: const Color(0xFF5D4037)),
                ],
              ),
            ),
          ),
          // 下半部粉紅色內容區 (展開時顯示)
          if (isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFF4DFDD), // 淺粉色底
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(13)),
              ),
              child: child,
            ),
        ],
      ),
    );
  }

  // 建立開關列 (包含字體與開關)
  Widget _buildSwitchRow(String label, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037))),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            // 🌟 把它們換成新的名字：
            activeTrackColor: const Color(0xFFA0C4E2), // 開啟時的淺藍色
            inactiveTrackColor: Colors.grey[600],      // 關閉時的深灰色
          ),
        ],
      ),
    );
  }

  // 建立專屬輸入框
  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF5D4037))),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: Color(0xFF5D4037)),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFFF9EE), // 淺黃底色
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFEABDBA)), // 預設粉紅框
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFEABDBA), width: 2), // 點擊加粗
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EE),
      body: SafeArea(
        child: SingleChildScrollView( // 讓畫面可以滑動，防止鍵盤擋住
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= 【頂部：頭像與基本資訊】 =================
              SizedBox(
                height: 120,
                child: Stack(
                  children: [
                    // 左上方大頭貼
                    Positioned(
                      left: 0, top: 0,
                      child: GestureDetector(
                        onTap: _pickAvatar, // 點擊大頭貼也可上傳// 🌟 檢查這裡！確保有把函數綁定上來
                        child: Container(
                          width: 80, height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFE5E5E5), // 灰底
                            border: Border.all(color: const Color(0xFFA0C4E2), width: 3), // 藍框
                            // 🌟 替換這裡：如果有選照片，就用 MemoryImage 顯示真實照片！
                            image: _avatarBytes != null
                                ? DecorationImage(
                                    image: MemoryImage(_avatarBytes!), 
                                    fit: BoxFit.cover,
                                  ) 
                                : null,
                          ),
                          // 沒圖片時顯示相機圖案
                          child: !_hasAvatar ? const Icon(Icons.camera_alt_outlined, color: Color(0xFFA0C4E2), size: 30) : null,
                        ),
                      ),
                    ),
                    // 使用者名稱與動物 icon
                    Positioned(
                      left: 100, top: 25,
                      child: Row(
                        children: [
                          Text(_usernameCtrl.text, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF5D4037))),
                          const SizedBox(width: 8),
                          // 動物頭像 (這裡暫用 Icon 替代，你可以換成 Image.asset)
                          const Icon(Icons.pets, color: Color(0xFF5D4037), size: 28), 
                        ],
                      ),
                    ),
                    // 更換頭像藍字
                    Positioned(
                      left: 10, top: 90,
                      child: InkWell(
                        onTap: _pickAvatar,// 🌟 檢查這裡！確保有綁定上來
                        child: Text(loc.profileChangeAvatar, style: const TextStyle(color: Color(0xFFA0C4E2), fontSize: 13)),
                      ),
                    ),
                    // 心靈探索藍字
                    Positioned(
                      right: 0, top: 90,
                      child: InkWell(
                        onTap: () {
                          // 點擊後跳轉回問卷前導頁，並把現有的資料帶過去
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizIntroScreen(
                                name: widget.name,
                                username: widget.username,
                                password: widget.password,
                                email: widget.email,
                              ),
                            ),
                          );
                        },
                        child: Text(loc.profileExploreMind, style: const TextStyle(color: Color(0xFFA0C4E2), fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // ================= 【區塊 1：偏好設定】 =================
              _buildExpandableSection(
                title: loc.profilePreferences,
                isExpanded: _isPrefExpanded,
                onToggle: () => setState(() => _isPrefExpanded = !_isPrefExpanded),
                child: Column(
                  children: [
                    _buildSwitchRow(loc.profileDeviceLight, _lightEnabled, (val) => setState(() => _lightEnabled = val)),
                    _buildSwitchRow(loc.profileDeviceSound, _soundEnabled, (val) => setState(() => _soundEnabled = val)),
                    _buildSwitchRow(loc.profileSysNotif, _notifEnabled, (val) => setState(() => _notifEnabled = val)),
                  ],
                ),
              ),

              // ================= 【區塊 2：個人資料】 =================
              _buildExpandableSection(
                title: loc.profilePersonalInfo,
                isExpanded: _isProfileExpanded,
                onToggle: () => setState(() => _isProfileExpanded = !_isProfileExpanded),
                child: Column(
                  children: [
                    _buildTextField(loc.profileName, _nameCtrl),
                    _buildTextField(loc.profileUsername, _usernameCtrl),
                    // 密碼特別加上 obscureText: true 變成星號
                    _buildTextField(loc.profilePassword, _pwdCtrl, obscureText: true), 
                    _buildTextField(loc.profileEmail, _emailCtrl),
                    const SizedBox(height: 10),
                    // 刪除帳號按鈕
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF4DFDD), // 內部還是粉紅底
                          foregroundColor: Colors.red[800], // 紅色警告字體
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Color(0xFFEABDBA)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        ),
                        // 🌟 把這裡的 onTap 改成 onPressed：
                        onPressed: () => _showDeleteAccountDialog(loc),
                          // 點擊後回到註冊頁面 (清除之前所有的導航歷史)
                          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const RegisterScreen()), (route) => false);
                        child: Text(loc.profileDeleteAccount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),

              // ================= 【底部：登出與條款連結】 =================
              // ================= 【底部：登出與條款連結】 =================
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end, // 讓左右兩邊的底部對齊
                children: [
                  // 🌟 左邊區塊：條款與政策 (用 Expanded 佔據左邊剩餘空間)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // 文字靠左對齊
                      children: [
                        InkWell(
                          onTap: () { /* TODO: 顯示使用條款 */ },
                          child: Text(loc.profileTerms, style: const TextStyle(color: Color(0xFFA0C4E2), fontSize: 13)),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () { /* TODO: 顯示隱私政策 */ },
                          child: const Text('隱私政策', style: TextStyle(color: Color(0xFFA0C4E2), fontSize: 13)), // 記得換成你的 loc 變數
                        ),
                      ],
                    ),
                  ),

                  // 🌟 中間區塊：登出按鈕
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFF9EE),
                      foregroundColor: const Color(0xFF5D4037),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(color: Color(0xFFEABDBA), width: 1.5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    onPressed: () => _showLogoutDialog(loc),
                    child: Text(loc.profileLogout, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),

                  // 🌟 右邊區塊：放一個空的 Expanded，它的作用是把中間的登出按鈕完美「擠」到正中間！
                  const Expanded(child: SizedBox()), 
                ],
              ),
              const SizedBox(height: 40), // 底部留白避免被導航欄遮住
            ],
          ),
        ),
      ),
    );
  }
}