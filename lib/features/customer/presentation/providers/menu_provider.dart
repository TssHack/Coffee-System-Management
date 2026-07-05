import 'package:flutter/material.dart';
import '../../../../shared/data/services/api_service.dart';
import '../../../../core/constants/api_constants.dart';
import '../../data/models/product_model.dart';
import '../../data/models/category_model.dart';

class MenuProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<CategoryModel> _categories = [];
  bool _isLoading = false;
  String? _error;

  List<ProductModel> get products => _products;
  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchMenu() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.get(ApiConstants.menu);
      
      if (response['success'] == true) {
        final data = response['data'];
        _categories = (data['categories'] as List)
            .map((json) => CategoryModel.fromJson(json))
            .toList();
        _products = (data['products'] as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        _error = response['message'] ?? 'خطا در دریافت منو';
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}