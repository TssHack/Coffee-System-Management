import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _error;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _error = null);

    try {
      await context.read<AuthProvider>().login(_idCtrl.text.trim(), _passCtrl.text.trim());
      if (!mounted) return;

      final auth = context.read<AuthProvider>();
      if (auth.isAdmin) {
        Navigator.pushReplacementNamed(context, '/admin/dashboard');
      } else {
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  void dispose() {
    _idCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final auth = context.watch<AuthProvider>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [isDark ? CafeColors.darkBg : CafeColors.lightBg, isDark ? const Color(0xFF1A1512) : CafeColors.cream],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 90, height: 90,
                        decoration: BoxDecoration(color: CafeColors.primary, borderRadius: BorderRadius.circular(26), boxShadow: [BoxShadow(color: CafeColors.primary.withValues(alpha: 0.3), blurRadius: 24, offset: const Offset(0, 8))]),
                        child: const Icon(Icons.coffee_rounded, color: Colors.white, size: 44),
                      ),
                      const SizedBox(height: 20),
                      Text('کافه‌سرویس', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary)),
                      const SizedBox(height: 8),
                      Text('برای ادامه وارد شوید', style: TextStyle(fontSize: 14, color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted)),
                      const SizedBox(height: 40),

                      if (_error != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: CafeColors.danger.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline_rounded, color: CafeColors.danger, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(_error!, style: const TextStyle(color: CafeColors.danger, fontSize: 13)),
                              ),
                            ],
                          ),
                        ),

                      TextFormField(
                        controller: _idCtrl,
                        textDirection: TextDirection.ltr,
                        decoration: const InputDecoration(hintText: 'نام کاربری یا شماره موبایل', prefixIcon: Icon(Icons.person_outline_rounded)),
                        validator: (v) => v == null || v.isEmpty ? 'این فیلد الزامی است' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passCtrl,
                        obscureText: true,
                        textDirection: TextDirection.ltr,
                        decoration: const InputDecoration(hintText: 'رمز عبور', prefixIcon: Icon(Icons.lock_outline_rounded)),
                        validator: (v) => v == null || v.isEmpty ? 'این فیلد الزامی است' : null,
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: auth.isLoading ? null : _login,
                          child: auth.isLoading
                              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : const Text('ورود', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                        child: Text('ورود به عنوان مهمان', style: TextStyle(color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
