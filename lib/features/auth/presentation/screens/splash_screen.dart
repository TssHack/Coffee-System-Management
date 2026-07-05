import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../../../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _scale = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _fade = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeIn));
    _ctrl.forward();
    _navigate();
  }

  Future<void> _navigate() async {
    final auth = context.read<AuthProvider>();
    // صبر کن تا از حافظه بخونه
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    if (auth.isAdmin) {
      Navigator.pushReplacementNamed(context, '/admin/dashboard');
    } else if (auth.isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: CafeColors.primary,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(color: CafeColors.primary.withValues(alpha: 0.35), blurRadius: 30, offset: const Offset(0, 12)),
                    ],
                  ),
                  child: const Icon(Icons.coffee_rounded, color: Colors.white, size: 48),
                ),
                const SizedBox(height: 24),
                Text('کافه‌سرویس', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Theme.of(context).brightness == Brightness.dark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}