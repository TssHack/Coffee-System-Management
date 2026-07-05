import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/data/services/api_service.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../customer/data/models/product_model.dart';
import '../../../customer/data/models/category_model.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> _products = [];
  List<CategoryModel> _categories = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() { _isLoading = true; _error = null; });
    try {
      final res = await ApiService.get(ApiConstants.menu);
      if (res['success']) {
        _categories = (res['data']['categories'] as List).map((j) => CategoryModel.fromJson(j)).toList();
        _products = (res['data']['products'] as List).map((j) => ProductModel.fromJson(j)).toList();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showDialog({ProductModel? product}) {
    final isEdit = product != null;
    final nameCtrl = TextEditingController(text: product?.name ?? '');
    final nameEnCtrl = TextEditingController(text: product?.nameEn ?? '');
    final descCtrl = TextEditingController(text: product?.description ?? '');
    final priceCtrl = TextEditingController(text: product?.price.toString() ?? '');
    final imgUrlCtrl = TextEditingController(text: product?.imageUrl ?? '');
    String catId = product?.categoryId ?? (_categories.isNotEmpty ? _categories.first.id : '');
    bool isNew = product?.isNew ?? false;
    bool isSug = product?.isSuggested ?? false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) => Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: Theme.of(ctx).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(isEdit ? 'ویرایش محصول' : 'محصول جدید'),
            content: SingleChildScrollView(
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'نام محصول *')),
                    const SizedBox(height: 12),
                    TextField(controller: nameEnCtrl, textDirection: TextDirection.ltr, decoration: const InputDecoration(labelText: 'نام انگلیسی')),
                    const SizedBox(height: 12),
                    TextField(controller: descCtrl, maxLines: 2, decoration: const InputDecoration(labelText: 'توضیحات')),
                    const SizedBox(height: 12),
                    TextField(controller: priceCtrl, keyboardType: TextInputType.number, textDirection: TextDirection.ltr, decoration: const InputDecoration(labelText: 'قیمت (تومان) *')),
                    const SizedBox(height: 12),
                    TextField(controller: imgUrlCtrl, textDirection: TextDirection.ltr, decoration: const InputDecoration(labelText: 'آدرس تصویر')),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _categories.any((c) => c.id == catId) ? catId : null,
                      items: _categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                      onChanged: (v) { if (v != null) setDlg(() => catId = v); },
                      decoration: const InputDecoration(labelText: 'دسته‌بندی *'),
                    ),
                    SwitchListTile(title: const Text('جدید'), value: isNew, onChanged: (v) => setDlg(() => isNew = v), contentPadding: EdgeInsets.zero),
                    SwitchListTile(title: const Text('پیشنهادی'), value: isSug, onChanged: (v) => setDlg(() => isSug = v), contentPadding: EdgeInsets.zero),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('انصراف')),
              ElevatedButton(
                onPressed: () async {
                  final price = int.tryParse(priceCtrl.text);
                  if (nameCtrl.text.isEmpty || catId.isEmpty || price == null) {
                    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('فیلدهای ستاره‌دار الزامی هستند'), backgroundColor: CafeColors.danger));
                    return;
                  }
                  try {
                    final body = {
                      'name': nameCtrl.text, 'name_en': nameEnCtrl.text, 'description': descCtrl.text,
                      'price': price, 'image_url': imgUrlCtrl.text, 'category_id': catId,
                      'is_new': isNew, 'is_suggested': isSug,
                    };
                    if (isEdit) {
                      await ApiService.put('${ApiConstants.adminProducts}/${product.id}', body);
                    } else {
                      await ApiService.post(ApiConstants.adminProducts, body);
                    }
                    if (ctx.mounted) {
                      Navigator.pop(ctx);
                      _fetchData();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isEdit ? 'ویرایش شد' : 'اضافه شد'), backgroundColor: CafeColors.success));
                    }
                  } catch (e) {
                    if (ctx.mounted) ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: CafeColors.danger));
                  }
                },
                child: Text(isEdit ? 'ذخیره' : 'افزودن'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteProduct(int id) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('حذف محصول'),
        content: const Text('آیا اطمینان دارید؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('خیر')),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: CafeColors.danger), onPressed: () => Navigator.pop(ctx, true), child: const Text('بله')),
        ],
      ),
    );
    if (ok == true) {
      try {
        await ApiService.delete('${ApiConstants.adminProducts}/$id');
        _fetchData();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: CafeColors.danger));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('مدیریت محصولات'),
          leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => Navigator.pop(context)),
          actions: [Padding(padding: const EdgeInsets.only(left: 12), child: ElevatedButton.icon(onPressed: () => _showDialog(), icon: const Icon(Icons.add_rounded, size: 18), label: const Text('افزودن')))],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator(color: CafeColors.primary))
            : _products.isEmpty
                ? Center(child: Text('محصولی وجود ندارد', style: TextStyle(color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted)))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _products.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) {
                      final p = _products[i];
                      final cat = _categories.where((c) => c.id == p.categoryId).firstOrNull?.name ?? '-';
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: isDark ? CafeColors.darkSurface : CafeColors.lightSurface, borderRadius: BorderRadius.circular(14), border: Border.all(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider)),
                        child: Row(
                          children: [
                            ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(p.imageUrl, width: 56, height: 56, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 56, height: 56, color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider, child: const Icon(Icons.coffee, size: 24)))),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(p.name, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary)),
                                const SizedBox(height: 4),
                                Row(children: [
                                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: CafeColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)), child: Text(cat, style: const TextStyle(fontSize: 11, color: CafeColors.primary))),
                                  if (p.isNew) ...[const SizedBox(width: 6), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: CafeColors.warning.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)), child: const Text('جدید', style: TextStyle(fontSize: 11, color: CafeColors.warning)))],
                                  if (p.isSuggested) ...[const SizedBox(width: 6), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: CafeColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)), child: const Text('پیشنهادی', style: TextStyle(fontSize: 11, color: CafeColors.success)))],
                                ]),
                                const SizedBox(height: 4),
                                Text(p.formattedPrice, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: CafeColors.primary)),
                              ]),
                            ),
                            IconButton(icon: const Icon(Icons.edit_rounded, color: CafeColors.info), onPressed: () => _showDialog(product: p)),
                            IconButton(icon: const Icon(Icons.delete_rounded, color: CafeColors.danger), onPressed: () => _deleteProduct(p.id)),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}