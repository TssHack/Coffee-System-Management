import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/data/services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  String? _role;
  String? _name;
  bool _isLoading = false;

  String? get token => _token;
  String? get role => _role;
  String? get name => _name;
  bool get isLoading => _isLoading;
  bool get isAdmin => _role == 'admin';
  bool get isLoggedIn => _token != null;

  AuthProvider() {
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _role = prefs.getString('role');
    _name = prefs.getString('name');
    if (_token != null) {
      ApiService.setToken(_token);
    }
    notifyListeners();
  }

  Future<void> login(String identifier, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.post('/api/auth/login', {
        'identifier': identifier,
        'password': password,
      });

      if (response['success']) {
        final data = response['data'];
        _token = data['token'];
        _role = data['role'];
        _name = data['name'];

        ApiService.setToken(_token);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        await prefs.setString('role', _role!);
        await prefs.setString('name', _name!);
      } else {
        throw Exception(response['message'] ?? 'خطا در ورود');
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _token = null;
    _role = null;
    _name = null;
    ApiService.setToken(null);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
    await prefs.remove('name');

    notifyListeners();
  }
}