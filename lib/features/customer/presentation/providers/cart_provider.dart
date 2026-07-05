import 'package:flutter/material.dart';
import '../../../../shared/data/services/api_service.dart';
import '../../../../core/constants/api_constants.dart';
import '../../data/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _items = [];
  String _baristaNote = '';
  int _tableId = 1;
  bool _isSubmitting = false;

  List<CartItemModel> get items => List.unmodifiable(_items);
  String get baristaNote => _baristaNote;
  int get tableId => _tableId;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  int get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);
  bool get isSubmitting => _isSubmitting;

  void setTableId(int id) {
    _tableId = id;
    notifyListeners();
  }

  void setBaristaNote(String note) {
    _baristaNote = note;
    notifyListeners();
  }

  void addItem(ProductModel product) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItemModel(product: product));
    }
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.removeWhere((i) => i.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }
    final index = _items.indexWhere((i) => i.product.id == productId);
    if (index >= 0) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    _baristaNote = '';
    notifyListeners();
  }

  Future<bool> submitOrder() async {
    if (_items.isEmpty) return false;

    _isSubmitting = true;
    notifyListeners();

    try {
      final requestBody = {
        'table_id': _tableId,
        'barista_note': _baristaNote,
        'items': _items.map((item) => {
          'product_id': item.product.id,
          'quantity': item.quantity,
          'note': item.note,
        }).toList(),
      };

      final response = await ApiService.post(ApiConstants.orders, requestBody);

      if (response['success'] == true) {
        clearCart();
        return true;
      } else {
        throw Exception(response['message'] ?? 'خطا در ثبت سفارش');
      }
    } catch (e) {
      rethrow; // خطا رو به UI می‌فرستیم تا به کاربر نشون بدیم
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}