import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cart = context.watch<CartProvider>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('سبد سفارش'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: cart.items.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined, size: 64, color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted),
                    const SizedBox(height: 16),
                    Text('سبد خرید خالی است', style: TextStyle(color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted)),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: cart.items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isDark ? CafeColors.darkSurface : CafeColors.lightSurface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(item.product.imageUrl, width: 60, height: 60, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider, child: const Icon(Icons.coffee))),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.product.name, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary)),
                                    const SizedBox(height: 4),
                                    Text(item.product.formattedPrice, style: const TextStyle(fontSize: 12, color: CafeColors.primary, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => cart.updateQuantity(item.product.id, item.quantity - 1),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.remove_rounded, size: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Text('${item.quantity}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary)),
                                  ),
                                  GestureDetector(
                                    onTap: () => cart.updateQuantity(item.product.id, item.quantity + 1),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: const BoxDecoration(color: CafeColors.primary, shape: BoxShape.circle),
                                      child: const Icon(Icons.add_rounded, size: 16, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // یادداشت به باریستا
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark ? CafeColors.darkSurface : CafeColors.lightSurface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider),
                    ),
                    child: TextField(
                      onChanged: (v) => cart.setBaristaNote(v),
                      maxLines: 2,
                      style: TextStyle(fontSize: 13, color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary),
                      decoration: const InputDecoration(
                        hintText: 'یادداشت به باریستا (اختیاری)...',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // جمع کل + دکمه ثبت
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: CafeColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('مبلغ کل', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.8))),
                            const SizedBox(height: 4),
                            Text(cart.totalPrice.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},') + ' تومان', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: CafeColors.primary,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: () async {
                            final success = await cart.submitOrder();
                            if (success && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('سفارش با موفقیت ثبت شد!'), backgroundColor: CafeColors.success),
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('ثبت سفارش', style: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}