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
  int _cartTotalQuantity = 0;

  void _addToCart(int quantity) {
    if (quantity > 0) {
      setState(() {
        _cartTotalQuantity += quantity;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // 🌟 使用字典中帶有變數的提示訊息
          content: Text(AppLocalizations.of(context)!.shopAddedToCartMsg(quantity)),
          duration: const Duration(seconds: 1),
          backgroundColor: const Color(0xFF5D4037),
        ),
      );
    }
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
          imagePath: 'assets/quokka.png', // 🌟 給它袋鼠的圖片
          onAddToCart: _addToCart),
        SingleProductCard(
          title: loc.shopItemPenguin, 
          imagePath: 'assets/penguin.png', // 🌟 給它企鵝的圖片
          onAddToCart: _addToCart),
        SingleProductCard(
          title: loc.shopItemRabbit, 
          imagePath: 'assets/rabbit.png',
          onAddToCart: _addToCart),
        SingleProductCard(
          title: loc.shopItemHedgehog, 
          imagePath: 'assets/hedgehog.png',
          onAddToCart: _addToCart),
        
        const SizedBox(height: 30),
        _buildSectionTitle(loc.shopSectionCombo1),
        ComboProductCard(onAddToCart: () => _addToCart(1)),
        
        const SizedBox(height: 30),
        _buildSectionTitle(loc.shopSectionCombo2), // 基礎組合 (NT$999)
        ComboProductCard(
          onAddToCart: () => _addToCart(1),
          // 🌟 將原本的 '內建模組' 改成 loc.shopItemBuiltInModule
          fixedItemTitle: loc.shopItemBuiltInModule,
          fixedItemImagePath: 'assets/module.png', // 換成你實際裝置的圖片名稱
        ),
        
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
        SingleProductCard(
          title: loc.shopItemCactus, 
          imagePath: 'assets/catcus.png',
          lPrice: 680, sPrice: 230, onAddToCart: _addToCart),
        SingleProductCard(
          title: loc.shopItemCookie, 
          imagePath: 'assets/round.png',
          lPrice: 480, sPrice: 130, onAddToCart: _addToCart),
        SingleProductCard(
          title: loc.shopItemEgg, 
        imagePath: 'assets/friedegg.png',
        onAddToCart: _addToCart),
        SingleProductCard(
          title: loc.shopItemCloud, 
          imagePath: 'assets/cloud.png',
          onAddToCart: _addToCart),
        
        const SizedBox(height: 30),
        _buildSectionTitle(loc.shopSectionCollab),
        SingleProductCard(
          title: loc.shopItemPompompurin, 
          imagePath: 'assets/puddingdog.png',
          lPrice: 780, sPrice: 350, onAddToCart: _addToCart),
        SingleProductCard(
          title: loc.shopItemStitch, 
          imagePath: 'assets/stitch.png',
          lPrice: 780, sPrice: 350, onAddToCart: _addToCart),
        SingleProductCard(
          title: loc.shopItemPikachu, 
          imagePath: 'assets/pika.png',
          lPrice: 780, sPrice: 350, onAddToCart: _addToCart),
        SingleProductCard(
          title: loc.shopItemPooh, 
          imagePath: 'assets/pooh.png',
          lPrice: 780, sPrice: 350, onAddToCart: _addToCart),
        
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
          MaterialPageRoute(builder: (context) => const CartScreen()),
        );
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
  final String imagePath; // 🌟 1. 新增這行：用來接收不同的圖片路徑
  final int lPrice;
  final int sPrice;
  final Function(int) onAddToCart;

  const SingleProductCard({
    super.key, 
    required this.title, 
    required this.imagePath, // 🌟 2. 這裡也要加上 required this.imagePath
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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 🌟 呼叫字典
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  color: Colors.white, // 🌟 1. 這裡改成白色了
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.hardEdge, // 🌟 2. 加上這個裁切魔法！
                
                // 👇 3. 以後要放圖片時，把這行的「//」刪掉，換成你的檔名就行了
               // 🌟 3. 把寫死的字串，改成讀取剛剛設定的變數！(注意不要加引號喔)
                child: Image.asset(widget.imagePath, fit: BoxFit.cover),
              ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5D4037))),
                const SizedBox(height: 10),
                // 🌟 使用字典裡的 "大"、"小"
                _buildSizeRow(loc.shopSizeLarge, widget.lPrice, _largeQty, (val) => setState(() => _largeQty = val)),
                const SizedBox(height: 5),
                _buildSizeRow(loc.shopSizeSmall, widget.sPrice, _smallQty, (val) => setState(() => _smallQty = val)),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      int total = _largeQty + _smallQty;
                      if (total > 0) {
                        widget.onAddToCart(total);
                        setState(() { _largeQty = 0; _smallQty = 0; });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      // 🌟 使用字典裡的 "加入購物車"
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
  final VoidCallback onAddToCart;
  // 🌟 新增兩個變數：用來接收「固定模組」的名稱跟圖片
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

    final Map<String, String> optionImages = {
      loc.shopItemQuokka: 'assets/quokka.png', 
      loc.shopItemPenguin: 'assets/penguin.png',
      loc.shopItemRabbit: 'assets/rabbit.png',
      loc.shopItemHedgehog: 'assets/hedgehog.png',
    };

    return Column(
      children: [
        _buildComboRow(loc.shopSizeLarge, _selectedLarge, (val) => setState(() => _selectedLarge = val), options, loc.shopDropdownHint, optionImages),
        const SizedBox(height: 15),
        _buildComboRow(loc.shopSizeSmall, _selectedSmall, (val) => setState(() => _selectedSmall = val), options, loc.shopDropdownHint, optionImages),
        
        // 🌟 如果你在呼叫時有給定 fixedItemTitle，就自動畫出這第三個固定選項！
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
              widget.onAddToCart();
              
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
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9EE), // 維持你溫暖的底色
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // 左上角的返回鍵 (點了會回到商城)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF5D4037)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '購物車', 
          style: TextStyle(color: Color(0xFF5D4037), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          '這裡是購物車裡面！\n(可以開始在這裡設計結帳畫面囉)', 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Color(0xFF5D4037), height: 1.5),
        ),
      ),
    );
  }
}