import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class TableEntryScreen extends StatelessWidget {
  const TableEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? CafeColors.darkBg : CafeColors.lightBg;
    final tx1 = isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary;
    final txm = isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [bg, isDark ? const Color(0xFF1A1512) : CafeColors.cream],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: CafeColors.primary,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: CafeColors.primary.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8)),
                      ],
                    ),
                    child: const Icon(Icons.coffee_rounded, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 20),
                  Text('کافه‌سرویس', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: tx1)),
                  const SizedBox(height: 8),
                  Text('اسکن QR کد میز یا شماره میز رو وارد کن', style: TextStyle(fontSize: 14, color: txm)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark ? CafeColors.darkSurface : CafeColors.lightSurface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider),
                      boxShadow: [
                        BoxShadow(color: (isDark ? Colors.black : CafeColors.espresso).withValues(alpha: 0.08), blurRadius: 20, offset: const Offset(0, 10)),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: tx1, height: 1.2),
                          decoration: InputDecoration(
                            hintText: '?',
                            hintStyle: TextStyle(fontSize: 48, fontWeight: FontWeight.w300, color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onSubmitted: (value) {
                            final tableId = int.tryParse(value) ?? 1;
                            Navigator.pushReplacementNamed(context, '/menu', arguments: tableId);
                          },
                        ),
                        const SizedBox(height: 8),
                        Text('شماره میز', style: TextStyle(fontSize: 14, color: txm)),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushReplacementNamed(context, '/menu', arguments: 5),
                            child: const Text('مشاهده منو'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text('یا QR Code میز رو اسکن کن', style: TextStyle(fontSize: 12, color: txm)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/admin/dashboard'),
                    child: Text('ورود به پنل مدیریت', style: TextStyle(fontSize: 12, color: txm)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}