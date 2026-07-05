import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/product_model.dart';
import '../../data/models/category_model.dart';
import '../providers/cart_provider.dart';
import '../../../../shared/data/services/api_service.dart';
import '../../../../core/constants/api_constants.dart';
import '../providers/menu_provider.dart';

class MenuScreen extends StatefulWidget {
  final int tableId;
  const MenuScreen({super.key, required this.tableId});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  String _selectedCategory = 'all';
  final ScrollController _scrollController = ScrollController();

  final List<CategoryModel> _categories = const [
    CategoryModel(id: 'all', name: 'همه', icon: 'border_all'),
    CategoryModel(id: '1', name: 'نوشیدنی گرم', icon: 'local_cafe'),
    CategoryModel(id: '2', name: 'نوشیدنی سرد', icon: 'local_drink'),
    CategoryModel(id: '3', name: 'دسر', icon: 'cake'),
    CategoryModel(id: '4', name: 'میان‌وعده', icon: 'fastfood'),
  ];

  final List<ProductModel> _products = const [
    ProductModel(id: 1, name: 'اسپرسو', nameEn: 'Espresso', description: 'یک شات اسپرسوی خالص با عطر بی‌نظیر', price: 35000, imageUrl: 'https://picsum.photos/seed/esp01/400/400', categoryId: '1', isSuggested: true),
    ProductModel(id: 2, name: 'کاپوچینو', nameEn: 'Cappuccino', description: 'اسپرسو با شیر بخار داده و کف ابریشمی', price: 55000, imageUrl: 'https://picsum.photos/seed/cap02/400/400', categoryId: '1', isSuggested: true),
    ProductModel(id: 3, name: 'لاته', nameEn: 'Latte', description: 'اسپرسو با شیر فراوان و فوم نازک', price: 60000, imageUrl: 'https://picsum.photos/seed/lat03/400/400', categoryId: '1'),
    ProductModel(id: 4, name: 'موکا', nameEn: 'Mocha', description: 'اسپرسو با شکلات بلژیکی و شیر', price: 70000, imageUrl: 'https://picsum.photos/seed/moc04/400/400', categoryId: '1', isNew: true),
    ProductModel(id: 5, name: 'چای ماسالا', nameEn: 'Masala Chai', description: 'چای سیاه با ادویه‌های هندی معطر', price: 45000, imageUrl: 'https://picsum.photos/seed/mas05/400/400', categoryId: '1', isNew: true),
    ProductModel(id: 6, name: 'آیس لاته', nameEn: 'Iced Latte', description: 'لاته سرد با یخ خشک و شیر تازه', price: 65000, imageUrl: 'https://picsum.photos/seed/icl07/400/400', categoryId: '2', isSuggested: true),
    ProductModel(id: 7, name: 'لیموناد نعناع', nameEn: 'Mint Lemonade', description: 'لیموناد تازه با برگ نعناع', price: 50000, imageUrl: 'https://picsum.photos/seed/lem08/400/400', categoryId: '2'),
    ProductModel(id: 8, name: 'فراپه کارامل', nameEn: 'Caramel Frappe', description: 'فراپه یخی با خامه فرم‌گرفته', price: 80000, imageUrl: 'https://picsum.photos/seed/fra09/400/400', categoryId: '2', isNew: true, isSuggested: true),
    ProductModel(id: 9, name: 'اسموتی توت‌فرنگی', nameEn: 'Strawberry Smoothie', description: 'توت‌فرنگی با ماست یونانی و عسل', price: 75000, imageUrl: 'https://picsum.photos/seed/smo10/400/400', categoryId: '2', isNew: true),
    ProductModel(id: 10, name: 'تیرامیسو', nameEn: 'Tiramisu', description: 'دسر ایتالیایی با ماسکارپونه و اسپرسو', price: 75000, imageUrl: 'https://picsum.photos/seed/tir13/400/400', categoryId: '3', isSuggested: true),
    ProductModel(id: 11, name: 'چیزکیک', nameEn: 'Cheesecake', description: 'چیزکیک نیویورکی با سس بلوبری', price: 60000, imageUrl: 'https://picsum.photos/seed/che14/400/400', categoryId: '3'),
    ProductModel(id: 12, name: 'کروسان', nameEn: 'Croissant', description: 'کروسان لایه‌لایه با کره فرانسوی', price: 40000, imageUrl: 'https://picsum.photos/seed/cro15/400/400', categoryId: '4'),
  ];

  List<ProductModel> get _filteredProducts {
    if (_selectedCategory == 'all') return _products;
    return _products.where((p) => p.categoryId == _selectedCategory).toList();
  }

  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().setTableId(widget.tableId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuProvider>().fetchMenu();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  IconData _getCatIcon(String icon) {
    switch (icon) {
      case 'local_cafe': return Icons.local_cafe_rounded;
      case 'local_drink': return Icons.local_drink_rounded;
      case 'cake': return Icons.cake_rounded;
      case 'fastfood': return Icons.fastfood_rounded;
      default: return Icons.grid_view_rounded;
    }
  }

  void _showAddToast(ProductModel product) {
    context.read<CartProvider>().addItem(product);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            SizedBox(width: 10),
          ] + [
            Text('${product.name} به سبد اضافه شد', style: const TextStyle(fontFamily: 'Vazirmatn', fontWeight: FontWeight.w600)),
          ],
        ),
        backgroundColor: CafeColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.only(bottom: 90, left: 16, right: 16),
      ),
    );
  }

  void _callBarista() async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // ارسال به سرور
    try {
      await ApiService.post(ApiConstants.baristaCalls, {'table_id': widget.tableId});
    } catch (e) {
      // حتی اگر خطا داد، دیالوگ رو نشون بده (شبیه‌سازی)
    }

    if (!mounted) return;
    
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: isDark ? CafeColors.darkSurface : CafeColors.lightSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: CafeColors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications_active_rounded, size: 32, color: CafeColors.primary),
              ),
              const SizedBox(height: 20),
              const Text('باریستا صدا زده شد!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, fontFamily: 'Vazirmatn')),
              const SizedBox(height: 8),
              Text('به زودی یکی از باریستاها به میز ${widget.tableId} می‌آید', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted, fontFamily: 'Vazirmatn')),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('متوجه شدم'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cart = context.watch<CartProvider>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: 140,
              floating: true,
              pinned: true,
              backgroundColor: isDark ? CafeColors.darkBg : CafeColors.lightBg,
              surfaceTintColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(bottom: 16, right: 20, left: 20),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: CafeColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.table_restaurant_rounded, size: 18, color: CafeColors.primary),
                          const SizedBox(width: 6),
                          Text('میز ${widget.tableId}', style: const TextStyle(fontWeight: FontWeight.w700, color: CafeColors.primary, fontSize: 14)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/cart'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: cart.itemCount > 0 ? CafeColors.primary : (isDark ? CafeColors.darkSurface : CafeColors.lightSurface),
                          borderRadius: BorderRadius.circular(10),
                          border: cart.itemCount > 0 ? null : Border.all(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.shopping_bag_outlined, size: 20, color: cart.itemCount > 0 ? Colors.white : (isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary)),
                            if (cart.itemCount > 0) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
                                child: Text('${cart.itemCount}', textAlign: TextAlign.center, style: const TextStyle(color: CafeColors.primary, fontSize: 11, fontWeight: FontWeight.w800)),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                background: Padding(
                  padding: const EdgeInsets.only(top: 60, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('منوی کافه', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary, height: 1.3)),
                      const SizedBox(height: 4),
                      Text('دلخواهت رو انتخاب کن', style: TextStyle(fontSize: 14, color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted)),
                    ],
                  ),
                ),
              ),
            ),

            // دسته‌بندی‌ها
            SliverToBoxAdapter(
              child: Container(
                height: 52,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final isSelected = _selectedCategory == cat.id;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? CafeColors.primary : (isDark ? CafeColors.darkSurface : CafeColors.lightSurface),
                        borderRadius: BorderRadius.circular(14),
                        border: isSelected ? null : Border.all(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider),
                        boxShadow: isSelected ? [BoxShadow(color: CafeColors.primary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))] : null,
                      ),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat.id),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(_getCatIcon(cat.icon), size: 18, color: isSelected ? Colors.white : (isDark ? CafeColors.darkTextSecondary : CafeColors.lightTextSecondary)),
                            const SizedBox(width: 8),
                            Text(cat.name, style: TextStyle(fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, fontSize: 13, color: isSelected ? Colors.white : (isDark ? CafeColors.darkTextSecondary : CafeColors.lightTextSecondary))),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // گرید محصولات
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
              sliver: _filteredProducts.isEmpty
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: Column(
                            children: [
                              Icon(Icons.coffee_outlined, size: 64, color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted),
                              const SizedBox(height: 16),
                              Text('محصولی یافت نشد', style: TextStyle(color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted)),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 400),
                            columnCount: 2,
                            child: ScaleAnimation(
                              curve: Curves.easeOutCubic,
                              child: FadeInAnimation(
                                child: _ProductCard(
                                  product: _filteredProducts[index],
                                  isDark: isDark,
                                  onTap: () => _showAddToast(_filteredProducts[index]),
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: _filteredProducts.length,
                      ),
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _callBarista,
          backgroundColor: const Color(0xFF4A2C1A),
          icon: const Icon(Icons.notifications_active_rounded, color: CafeColors.primary, size: 20),
          label: const Text('صدا زدن باریستا', style: TextStyle(color: CafeColors.cream, fontWeight: FontWeight.w700, fontSize: 13)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 6,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final ProductModel product;
  final bool isDark;
  final VoidCallback onTap;

  const _ProductCard({required this.product, required this.isDark, required this.onTap});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final p = widget.product;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? CafeColors.darkSurface : CafeColors.lightSurface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider),
            boxShadow: [
              BoxShadow(color: (isDark ? Colors.black : CafeColors.espresso).withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
                      child: CachedNetworkImage(
                        imageUrl: p.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (_, __) => Container(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider, child: const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: CafeColors.primary)))),
                        errorWidget: (_, __, ___) => Container(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider, child: Icon(Icons.coffee, size: 40, color: CafeColors.primary.withValues(alpha: 0.4))),
                      ),
                    ),
                    if (p.isNew || p.isSuggested)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Row(
                          children: [
                            if (p.isNew)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: CafeColors.warning, borderRadius: BorderRadius.circular(8)),
                                child: const Text('جدید', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                              ),
                            if (p.isNew && p.isSuggested) const SizedBox(width: 4),
                            if (p.isSuggested)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: CafeColors.success, borderRadius: BorderRadius.circular(8)),
                                child: const Text('پیشنهادی', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                              ),
                          ],
                        ),
                      ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: CafeColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: CafeColors.primary.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 3))],
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary)),
                      const SizedBox(height: 2),
                      Text(p.nameEn, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted, fontStyle: FontStyle.italic)),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(p.formattedPrice, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: CafeColors.primary)),
                          Icon(Icons.add_shopping_cart_rounded, size: 18, color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}