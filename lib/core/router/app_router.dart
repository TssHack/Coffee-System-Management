import 'package:flutter/material.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/customer/presentation/screens/table_entry_screen.dart';
import '../../features/customer/presentation/screens/menu_screen.dart';
import '../../features/customer/presentation/screens/cart_screen.dart';
import '../../features/customer/presentation/screens/order_history_screen.dart';
import '../../features/customer/presentation/screens/profile_screen.dart';
import '../../features/admin/presentation/screens/dashboard_screen.dart';
import '../../features/admin/presentation/screens/products_screen.dart';
import '../../features/admin/presentation/screens/orders_screen.dart';
import '../../features/admin/presentation/screens/users_screen.dart';
import '../../features/admin/presentation/screens/baristas_screen.dart';
import '../../features/admin/presentation/screens/discounts_screen.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String tableEntry = '/';
  static const String menu = '/menu';
  static const String cart = '/cart';
  static const String orderHistory = '/order-history';
  static const String profile = '/profile';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminProducts = '/admin/products';
  static const String adminOrders = '/admin/orders';
  static const String adminUsers = '/admin/users';
  static const String adminBaristas = '/admin/baristas';
  static const String adminDiscounts = '/admin/discounts';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case splash: return _fadeRoute(const SplashScreen());
      case login: return _fadeRoute(const LoginScreen());
      case tableEntry: return _fadeRoute(const TableEntryScreen());
      case menu: return _fadeRoute(MenuScreen(tableId: args as int? ?? 1));
      case cart: return _fadeRoute(const CartScreen());
      case orderHistory: return _fadeRoute(const OrderHistoryScreen());
      case profile: return _fadeRoute(const ProfileScreen());
      case adminDashboard: return _fadeRoute(const DashboardScreen());
      case adminProducts: return _fadeRoute(const ProductsScreen());
      case adminOrders: return _fadeRoute(const OrdersScreen());
      case adminUsers: return _fadeRoute(const UsersScreen());
      case adminBaristas: return _fadeRoute(const BaristasScreen());
      case adminDiscounts: return _fadeRoute(const DiscountsScreen());
      default: return _fadeRoute(const Scaffold(body: Center(child: Text('صفحه مورد نظر یافت نشد'))));
    }
  }

  static PageRouteBuilder _fadeRoute(Widget child) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic), child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}