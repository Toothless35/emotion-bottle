import 'package:flutter/material.dart';
// 🌟 記得確認這裡的路徑是否符合你專案中的自動生成路徑
import 'l10n/app_localizations.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _selectedTabIndex = 0;
  // 🌟 1. 真正的購物車清單存放區
  List<CartItem> myCart = [];

  // 🌟 2. 把原本的數字變數，改成「自動計算 myCart 裡面總數」的智慧函數
  int get _cartTotalQuantity {
    int total = 0;
    for (var item in myCart) {
      total += item.totalQty;
    }
    return total;
  }

  // 🌟 單品加入購物車邏輯 (新增 imagePath 參數)
  void _addSingleToCart(String title, int lPrice, int sPrice, int lQty, int sQty, String imagePath) {
    final loc = AppLocalizations.of(context)!; 
    setState(() {
      int index = myCart.indexWhere((item) => item.title == title);
      if (index != -1) {
        myCart[index].lQty += lQty;
        myCart[index].sQty += sQty;
      } else {
        myCart.add(CartItem(
          title: title, lPrice: lPrice, sPrice: sPrice, lQty: lQty, sQty: sQty, isSelected: true,
          imagePaths: [imagePath], // 🌟 存入照片
        ));
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loc.cartAddedSingleMsg), duration: const Duration(seconds: 1)));
  }

  // 🌟 組合包加入購物車邏輯 (新增照片參數)
  void _addComboToCart(String comboName, int price, String largeAnimal, String smallAnimal, String largeImg, String smallImg, {String? moduleImg}) {
    final loc = AppLocalizations.of(context)!;
    setState(() {
      String cartTitle = loc.cartComboItemTitle(comboName, largeAnimal, smallAnimal);
      List<String> imgs = [largeImg, smallImg];
      if (moduleImg != null) imgs.add(moduleImg); // 🌟 如果有內建模組，就把第三張照片也塞進去
      
      myCart.add(CartItem(
        title: cartTitle, lPrice: price, sPrice: 0, lQty: 1, sQty: 0, isSelected: true,
        imagePaths: imgs, // 🌟 存入拼圖清單
      ));
    });
    
    // 🌟 3. 換成字典裡的組合包提示文字
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(loc.cartAddedComboMsg), 
      duration: const Duration(seconds: 1)
    ));
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EE),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 80),// 🌟 把原本的 20 改成 40，讓標籤整體往下移
            _buildCustomTabBar(context),
            const SizedBox(height: 20),
            Expanded(
              child: _selectedTabIndex == 0 ? _buildMainTab(context) : _buildMoreTab(context),
            ),
          ],
        ),
      ),
      // 🌟 關鍵在這裡！用 Padding 把它往上推，才不會被底部導航列蓋住
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 370.0), 
        child: _buildCartFAB(context), 
        ),// 記得傳入 context
    );
  }

  Widget _buildCustomTabBar(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF9EAE8),
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          _buildTabButton(loc.shopTabMain, 0),
          _buildTabButton(loc.shopTabMore, 1),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEBC8C8) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: const Color(0xFF5D4037),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainTab(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      children: [
        _buildSectionTitle(loc.shopSectionSingle),
        SingleProductCard(
          title: loc.shopItemQuokka,
          imagePaths: ['assets/quokka_large.png', 'assets/quokka_small.png'],
          onAddToCart: (lQty, sQty, img) => _addSingleToCart(loc.shopItemQuokka, 580, 180, lQty, sQty, img),
        ), // 🌟 補上右括號了！

        SingleProductCard(
          title: loc.shopItemPenguin,
          imagePaths: ['assets/penguin_large.png', 'assets/penguin_small.png'],
          onAddToCart: (lQty, sQty, img) => _addSingleToCart(loc.shopItemPenguin, 580, 180, lQty, sQty, img),
        ), // 🌟 補上右括號了！

        SingleProductCard(
          title: loc.shopItemRabbit,
          imagePaths: ['assets/rabbit_large.png', 'assets/rabbit_small.png'],
          // 🌟 換成新的 _addSingleToCart，並傳入正確的名字與金額
          onAddToCart: (lQty, sQty, img) => _addSingleToCart(loc.shopItemRabbit, 580, 180, lQty, sQty, img),
        ),

        SingleProductCard(
          title: loc.shopItemHedgehog,
          imagePaths: ['assets/hedgehog_large.png', 'assets/hedgehog_small.png'],
          // 🌟 換成新的 _addSingleToCart，並傳入正確的名字與金額
          onAddToCart: (lQty, sQty, img) => _addSingleToCart(loc.shopItemHedgehog, 580, 180, lQty, sQty, img),
        ),
        
        const SizedBox(height: 30),
        _buildSectionTitle(loc.shopSectionCombo1),
        ComboProductCard(// 🌟 對接組合包函數，傳入標題和價格 649
          onAddToCart: (large, small, largeImg, smallImg) => 
            _addComboToCart(loc.shopSectionCombo1, 649, large, small, largeImg, smallImg),
            ), // 🌟 救命恩人 1 號：補上這個括號跟逗號！
        
        const SizedBox(height: 30),
        _buildSectionTitle(loc.shopSectionCombo2), // 基礎組合 (NT$999)
        ComboProductCard(
          fixedItemTitle: loc.shopItemBuiltInModule,
          fixedItemImagePath: 'assets/module.png',
          // 🌟 對接組合包函數，傳入標題和價格 999
          onAddToCart: (large, small, largeImg, smallImg) => 
            _addComboToCart(loc.shopSectionCombo2, 999, large, small, largeImg, smallImg, moduleImg: 'assets/module.png'),
            ), // 🌟 救命恩人 2 號：補上這個括號跟逗號！
        
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildMoreTab(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      children: [
        _buildSectionTitle(loc.shopSectionSingle),
        // --- 仙人掌 ---
        SingleProductCard(
          title: loc.shopItemCactus,
          imagePaths: ['assets/catcus.png'], // 只有一張圖
          lPrice: 680, sPrice: 230,
          onAddToCart: (lQty, sQty, img) => _addSingleToCart(loc.shopItemCactus, 680, 230, lQty, sQty, img),
        ),
        
        // --- 餅乾 ---
        SingleProductCard(
          title: loc.shopItemCookie,
          imagePaths: ['assets/round.png'],
          lPrice: 480, sPrice: 130,
          onAddToCart: (lQty, sQty, img) => _addSingleToCart(loc.shopItemCookie, 480, 130, lQty, sQty, img),
        ),

        // --- 荷包蛋 ---
        SingleProductCard(
          title: loc.shopItemEgg,
          imagePaths: ['assets/friedegg.png'],
          // 沒有特別標示價格，預設為 580/180
          onAddToCart: (lQty, sQty, img) => _addSingleToCart(loc.shopItemEgg, 580, 180, lQty, sQty, img),
        ),

        // --- 雲朵 ---
        SingleProductCard(
          title: loc.shopItemCloud,
          imagePaths: ['assets/cloud_large.png', 'assets/cloud_small.png'],
          onAddToCart: (lQty, sQty, img) => _addSingleToCart(loc.shopItemCloud, 580, 180, lQty, sQty, img),
        ),

        const SizedBox(height: 30),
        _buildSectionTitle(loc.shopSectionCollab), // 聯名款標題

        // --- 布丁狗 ---
        SingleProductCard(
          title: loc.shopItemPompompurin,
          imagePaths: ['assets/puddingdog.png'],
          lPrice: 780, sPrice: 350,
          onAddToCart: (lQty, sQty, img) => _addSingleToCart(loc.shopItemPompompurin, 780, 350, lQty, sQty, img),
        ),

        // --- 史迪奇 ---
        SingleProductCard(
          title: loc.shopItemStitch,
          imagePaths: ['assets/stitch.png'],
          lPrice: 780, sPrice: 350,
          onAddToCart: (lQty, sQty, img) => _addSingleToCart(loc.shopItemStitch, 780, 350, lQty, sQty, img),
        ),

        // --- 皮卡丘 ---
        SingleProductCard(
          title: loc.shopItemPikachu,
          imagePaths: ['assets/pika.png'],
          lPrice: 780, sPrice: 350,
          onAddToCart: (lQty, sQty, img) => _addSingleToCart(loc.shopItemPikachu, 780, 350, lQty, sQty, img),
        ),

        // --- 維尼 ---
        SingleProductCard(
          title: loc.shopItemPooh,
          imagePaths: ['assets/pooh.png'],
          lPrice: 780, sPrice: 350,
          onAddToCart: (lQty, sQty, img) => _addSingleToCart(loc.shopItemPooh, 780, 350, lQty, sQty, img),
        ),
        
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
      ),
    );
  }

  // 🌟 記得括號裡面要加上 BuildContext context
  Widget _buildCartFAB(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 🌟 點擊跳轉到購物車頁面
        Navigator.push(
          context,
          // 🌟 把外面的 myCart 傳遞給裡面的購物車
          MaterialPageRoute(builder: (context) => CartScreen(cartItems: myCart)),
        ).then((_) {
          // 🌟 關鍵：當使用者從購物車按返回鍵回到商城時，重新整理畫面 (更新紅點數字)
          setState(() {});
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255), // 你的白色背景
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: const Icon(Icons.shopping_cart_outlined, size: 30, color: Color(0xFF5A7A94)),
          ),
          // 左上角紅色的數量徽章
          if (_cartTotalQuantity > 0)
            Positioned(
              top: -5,
              left: -5,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                child: Text(
                  '$_cartTotalQuantity',
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ==========================================
// 獨立元件：單選商品卡片
// ==========================================
class SingleProductCard extends StatefulWidget {
  final String title;
  final List<String> imagePaths; // 🌟 1. 這裡變成 List (清單) 了！可以傳入多張圖片
  final int lPrice;
  final int sPrice;
  // 🌟 把 Function(int) 改成下面這樣，讓它把大跟小的數量都傳出來
  final Function(int lQty, int sQty, String imgPath) onAddToCart;

  const SingleProductCard({
    super.key, 
    required this.title, 
    required this.imagePaths, // 🌟 記得這裡也要改
    this.lPrice = 580, 
    this.sPrice = 180,
    required this.onAddToCart,
  });

  @override
  State<SingleProductCard> createState() => _SingleProductCardState();
}

class _SingleProductCardState extends State<SingleProductCard> {
  int _largeQty = 0;
  int _smallQty = 0;
  int _currentImageIndex = 0; // 🌟 2. 新增一個變數，記錄現在看到的是第幾張照片

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🌟 3. 升級版：帶有左右切換箭頭的圖片預留框
          Container(
            width: 100, height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 【底層圖片】：根據目前的 index 顯示對應的圖片
                if (widget.imagePaths.isNotEmpty)
                  Image.asset(widget.imagePaths[_currentImageIndex], fit: BoxFit.cover),

                // 【上層按鈕】：左右切換箭頭 (如果只有1張圖就不顯示箭頭)
                if (widget.imagePaths.length > 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 左邊箭頭
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            // 往左切換，如果到底了就回到最後一張
                            _currentImageIndex = (_currentImageIndex - 1 + widget.imagePaths.length) % widget.imagePaths.length;
                          });
                        },
                        child: Container(
                          color: Colors.transparent, // 隱形背景擴大點擊範圍
                          padding: const EdgeInsets.symmetric(vertical: 8), 
                          child: const Icon(Icons.arrow_left, color: Color(0xFF5D4037), size: 26),
                        ),
                      ),
                      // 右邊箭頭
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            // 往右切換，如果到底了就回到第一張
                            _currentImageIndex = (_currentImageIndex + 1) % widget.imagePaths.length;
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Icon(Icons.arrow_right, color: Color(0xFF5D4037), size: 26),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5D4037))),
                const SizedBox(height: 10),
                _buildSizeRow(loc.shopSizeLarge, widget.lPrice, _largeQty, (val) => setState(() => _largeQty = val)),
                const SizedBox(height: 5),
                _buildSizeRow(loc.shopSizeSmall, widget.sPrice, _smallQty, (val) => setState(() => _smallQty = val)),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      int total = _largeQty + _smallQty;
                      if (total > 0) {
                        // 🌟 改呼叫這行！把大跟小的數量傳遞到外面
                        widget.onAddToCart(_largeQty, _smallQty, widget.imagePaths[0]);
                        setState(() { _largeQty = 0; _smallQty = 0; });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(loc.shopAddToCartBtn, style: const TextStyle(fontSize: 14, color: Color(0xFF8B6E60), fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 👇 這裡保留原本的 _buildSizeRow 和 _qtyBtn
  Widget _buildSizeRow(String size, int price, int qty, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$size   NT\$ $price', style: const TextStyle(fontSize: 14, color: Color(0xFF5D4037))),
        Row(
          children: [
            _qtyBtn('-', () => onChanged(qty > 0 ? qty - 1 : 0)),
            Container(
              width: 30, alignment: Alignment.center,
              child: Text('$qty', style: const TextStyle(fontSize: 14, color: Color(0xFF5D4037))),
            ),
            _qtyBtn('+', () => onChanged(qty + 1)),
          ],
        )
      ],
    );
  }

  Widget _qtyBtn(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(color: const Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(4)),
        child: Text(text, style: const TextStyle(color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// ==========================================
// 獨立元件：組合商品卡片 (包含本體與狀態)
// ==========================================
class ComboProductCard extends StatefulWidget {
  // 🌟 把 VoidCallback 改成下面這樣，讓它可以把兩隻動物的名字傳出去！
  final Function(String largeItem, String smallItem, String largeImg, String smallImg) onAddToCart;
  final String? fixedItemTitle;
  final String? fixedItemImagePath;

  const ComboProductCard({
    super.key, 
    required this.onAddToCart,
    this.fixedItemTitle,
    this.fixedItemImagePath,
  });

  @override
  State<ComboProductCard> createState() => _ComboProductCardState();
}

class _ComboProductCardState extends State<ComboProductCard> {
  String? _selectedLarge;
  String? _selectedSmall;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final List<String> options = [
      loc.shopItemQuokka,
      loc.shopItemPenguin,
      loc.shopItemRabbit,
      loc.shopItemHedgehog,
    ];

    // 🌟 1. 拆出第一組：給「大尺寸」專用的圖片對照表！
    final Map<String, String> largeOptionImages = {
      loc.shopItemQuokka: 'assets/quokka_large.png', // 換成大隻袋鼠的檔名
      loc.shopItemPenguin: 'assets/penguin_large.png', // 大隻企鵝
      loc.shopItemRabbit: 'assets/rabbit_large.png', // 大隻兔子
      loc.shopItemHedgehog: 'assets/hedgehog_large.png', // 大隻刺蝟
    };

    // 🌟 2. 拆出第二組：給「小尺寸」專用的圖片對照表！
    final Map<String, String> smallOptionImages = {
      loc.shopItemQuokka: 'assets/quokka_small.png', // 換成小隻袋鼠的檔名
      loc.shopItemPenguin: 'assets/penguin_small.png', // 小隻企鵝
      loc.shopItemRabbit: 'assets/rabbit_small.png', // 小隻兔子
      loc.shopItemHedgehog: 'assets/hedgehog_small.png', // 小隻刺蝟
    };

    return Column(
      children: [
        // 🌟 3. 上面的框框：傳入 largeOptionImages
        _buildComboRow(loc.shopSizeLarge, _selectedLarge, (val) => setState(() => _selectedLarge = val), options, loc.shopDropdownHint, largeOptionImages),
        
        const SizedBox(height: 15),
        
        // 🌟 4. 下面的框框：傳入 smallOptionImages
        _buildComboRow(loc.shopSizeSmall, _selectedSmall, (val) => setState(() => _selectedSmall = val), options, loc.shopDropdownHint, smallOptionImages),
        
        // (如果有固定裝置的話，保持原樣)
        if (widget.fixedItemTitle != null) ...[
          const SizedBox(height: 15),
          _buildFixedItemRow(widget.fixedItemTitle!, widget.fixedItemImagePath ?? ''),
        ],

        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              if (_selectedLarge == null || _selectedSmall == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(loc.shopSelectSizeWarning),
                    backgroundColor: Colors.redAccent,
                    duration: const Duration(seconds: 1),
                  ),
                );
                return;
              }
              // 🌟 加上變數，把使用者選的動物名字傳送給外面！
             widget.onAddToCart(_selectedLarge!, _selectedSmall!, largeOptionImages[_selectedLarge]!, smallOptionImages[_selectedSmall]!);
              
              setState(() {
                _selectedLarge = null;
                _selectedSmall = null;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(loc.shopAddToCartBtn, style: const TextStyle(fontSize: 14, color: Color(0xFF8B6E60), fontWeight: FontWeight.bold)),
            ),
          ),
        )
      ],
    );
  }

  // 🌟 專門畫「固定不變裝置」的框框 (沒有箭頭、沒有下拉選單)
  Widget _buildFixedItemRow(String title, String imagePath) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120, height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          // 👇 以後把裝置圖片放進專案了，就把前面的 // 刪掉！
          // child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5D4037))),
            ],
          ),
        )
      ],
    );
  }

  // 👇 這邊保持你原本的 _buildComboRow 程式碼 (有箭頭切換的那段)
  Widget _buildComboRow(String sizeLabel, String? selectedValue, Function(String?) onChanged, List<String> options, String hintText, Map<String, String> optionImages) {
    void changeOption(int step) {
      if (options.isEmpty) return;
      int currentIndex = selectedValue == null ? 0 : options.indexOf(selectedValue);
      int nextIndex = (currentIndex + step) % options.length;
      if (nextIndex < 0) nextIndex = options.length - 1;
      onChanged(options[nextIndex]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120, height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (selectedValue != null && optionImages.containsKey(selectedValue))
                Image.asset(optionImages[selectedValue]!, fit: BoxFit.cover),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => changeOption(-1),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.arrow_left, color: Color(0xFF5D4037), size: 30),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeOption(1),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.arrow_right, color: Color(0xFF5D4037), size: 30),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sizeLabel, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5D4037))),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: const Color(0xFFE8E8E8), borderRadius: BorderRadius.circular(5)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedValue,
                    hint: Text(hintText, style: const TextStyle(fontSize: 14, color: Colors.grey)), 
                    icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF5D4037)),
                    items: options.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(fontSize: 14, color: Color(0xFF5D4037))),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

// ==========================================
// 獨立頁面：購物車內容頁 (Cart Screen)
// ==========================================
// ==========================================
// 資料模型：購物車商品
// ==========================================
class CartItem {
  String title;
  int lPrice;
  int sPrice;
  int lQty;
  int sQty;
  bool isSelected;
  List<String> imagePaths; // 🌟 專門裝照片的清單

  CartItem({
    required this.title,
    required this.lPrice,
    required this.sPrice,
    this.lQty = 0,
    this.sQty = 0,
    this.isSelected = false,
    this.imagePaths = const [], // 🌟 預設為空清單
  });

  // 自動計算這個商品的單項小計
  int get subtotal => (lPrice * lQty) + (sPrice * sQty);
  // 這個商品總共有幾個
  int get totalQty => lQty + sQty;
}

// ==========================================
// 獨立頁面：購物車內容頁 (Cart Screen)
// ==========================================
class CartScreen extends StatefulWidget {
  // 🌟 這裡負責接收外面傳來的購物車清單
  final List<CartItem> cartItems; 

  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
  int get selectedTotalPrice {
    int total = 0;
    for (var item in widget.cartItems) { // 🌟 全部改讀取 widget.cartItems
      if (item.isSelected) total += item.subtotal;
    }
    return total;
  }

  int get selectedItemCount {
    return widget.cartItems.where((item) => item.isSelected).length;
  }

  bool get isAllSelected {
    if (widget.cartItems.isEmpty) return false;
    return widget.cartItems.every((item) => item.isSelected);
  }

  void toggleAll(bool? value) {
    setState(() {
      for (var item in widget.cartItems) {
        item.isSelected = value ?? false;
      }
    });
  }

  // 🌟 自動產生購物車照片拼圖
  Widget _buildCartImages(List<String> paths) {
    if (paths.isEmpty) return const SizedBox();
    if (paths.length == 1) return Image.asset(paths[0], fit: BoxFit.cover);
    
    // 如果有 2 張圖 (一般組合包)
    if (paths.length == 2) {
      return Row(
        children: [
          Expanded(child: Image.asset(paths[0], fit: BoxFit.cover)),
          Container(width: 2, color: Colors.white), // 中間加上白色分隔線更精緻
          Expanded(child: Image.asset(paths[1], fit: BoxFit.cover)),
        ],
      );
    }
    
    // 如果有 3 張圖 (包含內建模組的基礎組合)
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: Image.asset(paths[0], fit: BoxFit.cover)),
              Container(width: 2, color: Colors.white),
              Expanded(child: Image.asset(paths[1], fit: BoxFit.cover)),
            ],
          ),
        ),
        Container(height: 2, color: Colors.white),
        Expanded(
          child: Container(
            color: const Color(0xFFF5F5F5), // 給模組一個淡淡的底色
            width: double.infinity,
            child: Image.asset(paths[2], fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, color: Color(0xFF5D4037), size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          final item = widget.cartItems[index];
          return _buildCartItemCard(item, index, loc);
        },
      ),
      bottomNavigationBar: _buildBottomCheckoutBar(loc),
    );
  }

  Widget _buildCartItemCard(CartItem item, int index, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: item.isSelected,
                activeColor: const Color(0xFF5D4037),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                side: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                onChanged: (val) => setState(() => item.isSelected = val ?? false),
              ),
            ),
          ),
          // 商品圖片框
          Container(
            width: 100, height: 110,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.white, // 改成白底
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))],
            ),
            clipBehavior: Clip.hardEdge, // 🌟 啟動裁切魔法
            child: _buildCartImages(item.imagePaths), // 🌟 呼叫剛剛寫好的拼圖函數
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5D4037))),
                const SizedBox(height: 10),
                _buildQtyRow(loc.shopSizeLarge, item.lPrice, item.lQty, (delta) => _updateQty(index, true, delta)),
                const SizedBox(height: 5),
                _buildQtyRow(loc.shopSizeSmall, item.sPrice, item.sQty, (delta) => _updateQty(index, false, delta)),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('NT\$ ${item.subtotal}', style: const TextStyle(fontSize: 14, color: Color(0xFF8B6E60), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQtyRow(String size, int price, int qty, Function(int) onDelta) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$size    NT\$ $price', style: const TextStyle(fontSize: 14, color: Color(0xFF5D4037))),
        Row(
          children: [
            _qtyBtn('-', () => onDelta(-1)),
            Container(
              width: 30, alignment: Alignment.center,
              child: Text('$qty', style: const TextStyle(fontSize: 14, color: Color(0xFF5D4037))),
            ),
            _qtyBtn('+', () => onDelta(1)),
          ],
        )
      ],
    );
  }

  Widget _qtyBtn(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9), 
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(1, 1))],
        ),
        child: Text(text, style: const TextStyle(color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _updateQty(int index, bool isLarge, int delta) {
    setState(() {
      if (isLarge) {
        widget.cartItems[index].lQty += delta;
        if (widget.cartItems[index].lQty < 0) widget.cartItems[index].lQty = 0;
      } else {
        widget.cartItems[index].sQty += delta;
        if (widget.cartItems[index].sQty < 0) widget.cartItems[index].sQty = 0;
      }
    });
  }

  Widget _buildBottomCheckoutBar(AppLocalizations loc) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: const Color(0xFFFFF9EE),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: isAllSelected,
                activeColor: const Color(0xFF5D4037),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                side: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                onChanged: toggleAll,
              ),
            ),
            Text(loc.cartSelectAll, style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
            
            const Spacer(),
            
            Text('\$$selectedTotalPrice', style: const TextStyle(fontSize: 18, color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
            const SizedBox(width: 15),
            
            // 🌟 將原本的 Container 包上 GestureDetector 加上點擊事件
            GestureDetector(
              onTap: () {
                // 1. 找出所有被打勾的商品
                final selectedItems = widget.cartItems.where((item) => item.isSelected).toList();
                if (selectedItems.isEmpty) return; // 如果沒勾選任何東西就不動作
                
                // 2. 帶著這些商品跳轉到結帳頁面
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen(items: selectedItems)),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEABDBA),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                ),
                child: Text(
                  '${loc.cartCheckout} ($selectedItemCount)', 
                  style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 獨立頁面：結帳頁面 (Checkout Screen)
// ==========================================
class CheckoutScreen extends StatefulWidget {
  final List<CartItem> items; // 接收從購物車傳來的「已選商品」
  const CheckoutScreen({super.key, required this.items});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _remarks; // 儲存使用者的備註
  
  // 儲存目前選中的物流資訊
  Map<String, dynamic>? _selectedShipping; 

  int get itemsTotal {
    return widget.items.fold(0, (sum, item) => sum + item.subtotal);
  }

  int get finalTotal {
    int shippingFee = _selectedShipping != null ? _selectedShipping!['price'] : 0;
    return itemsTotal + shippingFee;
  }

  // 📝 彈出輸入備註的對話框
  void _editRemarks(AppLocalizations loc) {
    TextEditingController ctrl = TextEditingController(text: _remarks);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFFFF9EE),
        title: Text(loc.checkoutRemarks, style: const TextStyle(color: Color(0xFF5D4037))),
        content: TextField(
          controller: ctrl,
          decoration: InputDecoration(
            hintText: loc.checkoutRemarksHint,
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF5D4037))),
          ),
          cursorColor: const Color(0xFF5D4037),
        ),
        actions: [
          // 🌟 把 onTap 換成 onPressed
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(loc.dialogCancel, style: const TextStyle(color: Colors.grey))),
          TextButton(
            // 🌟 把 onTap 換成 onPressed
            onPressed: () {
              setState(() => _remarks = ctrl.text.isEmpty ? null : ctrl.text);
              Navigator.pop(ctx);
            }, 
            child: Text(loc.shippingConfirm, style: const TextStyle(color: Color(0xFF5D4037), fontWeight: FontWeight.bold))
          ),
        ],
      ),
    );
  }

  // 🚚 跳轉到物流選擇頁面，並等待回傳結果
  void _selectShipping() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShippingScreen(currentSelection: _selectedShipping)),
    );
    if (result != null) {
      setState(() {
        _selectedShipping = result; // 更新選中的物流與地址
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, color: Color(0xFF5D4037), size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          // 1. 顯示購買清單 (只讀模式)
          ...widget.items.map((item) => _buildCheckoutItemCard(item)),
          const SizedBox(height: 20),
          
          // 2. 備註欄位
          _buildInfoRow(loc.checkoutRemarks, _remarks ?? loc.checkoutRemarksHint, onTap: () => _editRemarks(loc)),
          const SizedBox(height: 20),
          
          // 3. 寄送方式
          _buildInfoRow(loc.checkoutShippingMethod, loc.checkoutViewAll, isAction: true, onTap: _selectShipping),
          if (_selectedShipping != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: const Color(0xFFF4DFDD), borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_selectedShipping!['methodName'], style: const TextStyle(color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(_selectedShipping!['address'], style: const TextStyle(color: Color(0xFF5D4037), fontSize: 13, height: 1.5)),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          
          // 4. 商品總計與付款方式
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(loc.checkoutItemCount(widget.items.length), style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037))),
              Text('\$$itemsTotal', style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037))),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(loc.checkoutPaymentMethod, loc.checkoutViewAll, isAction: true, onTap: () {}),
          const SizedBox(height: 40),
        ],
      ),
      bottomNavigationBar: _buildBottomCheckoutBar(loc),
    );
  }

  // 結帳頁面的商品卡片 (沒有加減按鈕，只有數量顯示)
  Widget _buildCheckoutItemCard(CartItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80, height: 90,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.hardEdge,
            child: item.imagePaths.isNotEmpty ? Image.asset(item.imagePaths[0], fit: BoxFit.cover) : const SizedBox(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF5D4037))),
                const SizedBox(height: 8),
                if (item.lQty > 0) Text('大        NT\$ ${item.lPrice} x ${item.lQty}', style: const TextStyle(fontSize: 14, color: Color(0xFF5D4037))),
                if (item.sQty > 0) Text('小        NT\$ ${item.sPrice} x ${item.sQty}', style: const TextStyle(fontSize: 14, color: Color(0xFF5D4037))),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('NT\$ ${item.subtotal}', style: const TextStyle(fontSize: 14, color: Color(0xFF8B6E60), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 資訊橫列 (標題 + 內容/按鈕)
  Widget _buildInfoRow(String title, String content, {bool isAction = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
            Text(content, style: TextStyle(fontSize: 14, color: isAction ? Colors.grey : const Color(0xFF5D4037))),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomCheckoutBar(AppLocalizations loc) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: const Color(0xFFFFF9EE),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(loc.checkoutTerms, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$$finalTotal', style: const TextStyle(fontSize: 20, color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEABDBA),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                  ),
                  child: Text(loc.checkoutBtn, style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 獨立頁面：寄送方式選擇頁面 (Shipping Screen)
// ==========================================
class ShippingScreen extends StatefulWidget {
  final Map<String, dynamic>? currentSelection;
  const ShippingScreen({super.key, this.currentSelection});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  // 模擬物流資料庫
  final List<Map<String, dynamic>> shippingMethods = [
    {
      'id': '711', 'name': '7-ELEVEN', 'price': 60, 'date': '預計配達時間 5月7日',
      'addresses': ['八田與一\n(+886) 904 492 026\n104 台北市基隆路四段43號 第一宿舍 5003-4']
    },
    {
      'id': 'kerry', 'name': '嘉里快遞', 'price': 65, 'date': '預計配達時間 5月8日',
      'addresses': [
        '八田與一\n(+886) 904 492 026\n104 台北市基隆路四段43號 第一宿舍 5003-4',
        '阿凡達\n(+886) 904 492 054\n100 宇宙市星星路四段43號 第一倉庫 5003-4'
      ]
    },
  ];

  String? _expandedId; // 記錄目前展開的是哪一家物流
  String? _selectedAddress; // 記錄目前選擇的地址

  @override
  void initState() {
    super.initState();
    // 進入頁面時，如果有預設選中的資料，就把它展開並選中
    if (widget.currentSelection != null) {
      _expandedId = widget.currentSelection!['methodId'];
      _selectedAddress = widget.currentSelection!['address'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, color: Color(0xFF5D4037), size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(loc.shippingTitle, style: const TextStyle(color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: shippingMethods.length,
        itemBuilder: (context, index) {
          final method = shippingMethods[index];
          final isExpanded = _expandedId == method['id'];

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: isExpanded ? const Color(0xFFF4DFDD) : Colors.transparent, // 展開時變成粉紅色背景
              borderRadius: BorderRadius.circular(10),
              border: isExpanded ? Border.all(color: const Color(0xFFEABDBA), width: 2) : null,
            ),
            child: Column(
              children: [
                // 物流標題列
                ListTile(
                  title: Text(method['name'], style: const TextStyle(color: Color(0xFF5D4037), fontSize: 16)),
                  subtitle: Text(method['date'], style: const TextStyle(color: Color(0xFF8B6E60), fontSize: 12)),
                  trailing: isExpanded 
                    ? const Icon(Icons.check, color: Colors.redAccent) 
                    : Text('\$${method['price']}', style: const TextStyle(color: Color(0xFF5D4037), fontSize: 16)),
                  onTap: () {
                    setState(() {
                      if (_expandedId == method['id']) {
                        _expandedId = null; // 點擊已展開的會縮起來
                      } else {
                        _expandedId = method['id'];
                        _selectedAddress = method['addresses'][0]; // 預設選中該物流的第一個地址
                      }
                    });
                  },
                ),
                // 展開後的地址選項
                if (isExpanded) ...[
                  const Divider(color: Color(0xFFEABDBA), height: 1),
                  ...List.generate(method['addresses'].length, (addrIndex) {
                    final addr = method['addresses'][addrIndex];
                    return RadioListTile<String>(
                      value: addr,
                      groupValue: _selectedAddress,
                      activeColor: const Color(0xFF5D4037),
                      title: Text(addr, style: const TextStyle(color: Color(0xFF5D4037), fontSize: 13, height: 1.5)),
                      onChanged: (val) => setState(() => _selectedAddress = val),
                    );
                  }),
                  // 新增地址按鈕
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 15, top: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                           // 這裡可以串接「新增地址」的頁面或邏輯
                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('開發中：準備跳轉新增地址頁面')));
                        },
                        child: Text(loc.shippingAddAddress, style: const TextStyle(color: Color(0xFF8B6E60))),
                      ),
                    ),
                  )
                ]
              ],
            ),
          );
        },
      ),
      // 底部確認按鈕
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: InkWell(
            onTap: () {
              if (_expandedId == null || _selectedAddress == null) {
                Navigator.pop(context); return;
              }
              // 找到選中的物流資訊
              final method = shippingMethods.firstWhere((m) => m['id'] == _expandedId);
              
              // 打包成 Map 傳回結帳頁面
              Navigator.pop(context, {
                'methodId': method['id'],
                'methodName': method['name'],
                'price': method['price'],
                'address': _selectedAddress,
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(color: const Color(0xFFEABDBA), borderRadius: BorderRadius.circular(30)),
              child: Text(loc.shippingConfirm, style: const TextStyle(fontSize: 18, color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }
}