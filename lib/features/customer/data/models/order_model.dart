import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _items = [];
  String _baristaNote = '';
  int _tableId = 1;

  List<CartItemModel> get items => List.unmodifiable(_items);
  String get baristaNote => _baristaNote;
  int get tableId => _tableId;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  int get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

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
    try {
      // TODO: فراخوانی API
      await Future.delayed(const Duration(seconds: 1));
      clearCart();
      return true;
    } catch (e) {
      return false;
    }
  }
}