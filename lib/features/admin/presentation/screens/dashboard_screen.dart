import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedNav = 0;

  final List<_NavItem> _navItems = const [
    _NavItem(icon: Icons.dashboard_rounded, label: 'داشبورد'),
    _NavItem(icon: Icons.coffee_rounded, label: 'محصولات'),
    _NavItem(icon: Icons.receipt_long_rounded, label: 'سفارشات'),
    _NavItem(icon: Icons.people_rounded, label: 'کاربران'),
    _NavItem(icon: Icons.badge_rounded, label: 'باریستاها'),
    _NavItem(icon: Icons.percent_rounded, label: 'تخفیفات'),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: isDark ? CafeColors.darkBg : CafeColors.lightBg,
        body: Row(
          children: [
            // ---- ساید‌بار ----
            if (MediaQuery.of(context).size.width > 768)
              _buildSidebar(isDark),
            // ---- محتوای اصلی ----
            Expanded(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // هدر
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'داشبورد مدیریت',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'خلاصه وضعیت کافه در نگاه اول',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted,
                                ),
                              ),
                            ],
                          ),
                          // تغییر تم
                           Container(
                            decoration: BoxDecoration(
                              color: isDark ? CafeColors.darkSurface : CafeColors.lightSurface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider),
                            ),
                            child: IconButton(
                              icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
                              onPressed: () {
                                themeProvider.toggleTheme();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // ---- کارت‌های آماری ----
                      Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              title: 'سفارشات امروز',
                              value: '۴۷',
                              icon: Icons.receipt_long_rounded,
                              color: CafeColors.primary,
                              change: '+۱۲٪',
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _StatCard(
                              title: 'درآمد امروز',
                              value: '۲,۸۵۰,۰۰۰',
                              icon: Icons.payments_rounded,
                              color: CafeColors.success,
                              change: '+۸٪',
                              isDark: isDark,
                              suffix: 'تومان',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _StatCard(
                              title: 'میزهای فعال',
                              value: '۸',
                              icon: Icons.table_restaurant_rounded,
                              color: CafeColors.warning,
                              change: 'از ۱۲ میز',
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _StatCard(
                              title: 'اعضای جدید',
                              value: '۵',
                              icon: Icons.person_add_rounded,
                              color: CafeColors.info,
                              change: 'این هفته',
                              isDark: isDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // ---- نمودارها ----
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // نمودار درآمد
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: isDark ? CafeColors.darkSurface : CafeColors.lightSurface,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'درآمد هفتگی',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    height: 220,
                                    child: LineChart(
                                      _buildRevenueChart(isDark),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // نمودار دسته‌بندی
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: isDark ? CafeColors.darkSurface : CafeColors.lightSurface,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'سهم دسته‌بندی‌ها',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 180,
                                    child: PieChart(
                                      _buildCategoryChart(isDark),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildLegend(isDark),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // ---- آخرین سفارشات ----
                      Container(
                        decoration: BoxDecoration(
                          color: isDark ? CafeColors.darkSurface : CafeColors.lightSurface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'آخرین سفارشات',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('مشاهده همه'),
                                  ),
                                ],
                              ),
                            ),
                            _buildOrderRow(isDark, '#۱۰۴۷', 'میز ۳', 'کاپوچینو × ۲، لاته × ۱', '۱۶۵,۰۰۰', 'در حال آماده‌سازی', CafeColors.warning),
                            Divider(height: 1, color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider, indent: 20, endIndent: 20),
                            _buildOrderRow(isDark, '#۱۰۴۶', 'میز ۷', 'اسپرسو × ۱', '۳۵,۰۰۰', 'تکمیل شده', CafeColors.success),
                            Divider(height: 1, color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider, indent: 20, endIndent: 20),
                            _buildOrderRow(isDark, '#۱۰۴۵', 'میز ۱', 'موکا × ۱، کیک × ۱', '۱۲۵,۰۰۰', 'ثبت شده', CafeColors.info),
                            Divider(height: 1, color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider, indent: 20, endIndent: 20),
                            _buildOrderRow(isDark, '#۱۰۴۴', 'میز ۵', 'آیس لاته × ۳', '۱۹۵,۰۰۰', 'لغو شده', CafeColors.danger),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar(bool isDark) {
    return Container(
      width: 240,
      color: isDark ? CafeColors.darkSurface : CafeColors.lightSurface,
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // لوگو
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 42, height: 42,
                    decoration: BoxDecoration(
                      color: CafeColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.coffee_rounded, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('کافه‌سرویس', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      Text('پنل مدیریت', style: TextStyle(fontSize: 11, color: CafeColors.primary)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // آیتم‌های منو
            ...List.generate(_navItems.length, (index) {
              final item = _navItems[index];
              final isActive = _selectedNav == index;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  tileColor: isActive ? CafeColors.primary.withValues(alpha: 0.12) : Colors.transparent,
                  leading: Icon(
                    item.icon,
                    size: 22,
                    color: isActive ? CafeColors.primary : (isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted),
                  ),
                  title: Text(
                    item.label,
                    style: TextStyle(
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 14,
                      color: isActive ? CafeColors.primary : (isDark ? CafeColors.darkTextSecondary : CafeColors.lightTextSecondary),
                    ),
                  ),
                  onTap: () {
                    setState(() => _selectedNav = index);
                    switch (index) {
                      case 1: Navigator.pushNamed(context, '/admin/products'); break;
                      case 2: Navigator.pushNamed(context, '/admin/orders'); break;
                      case 3: Navigator.pushNamed(context, '/admin/users'); break;
                      case 4: Navigator.pushNamed(context, '/admin/baristas'); break;
                      case 5: Navigator.pushNamed(context, '/admin/discounts'); break;
                    }
                  },
                ),
              );
            }),
            const Spacer(),
            // خروج
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                leading: const Icon(Icons.logout_rounded, size: 22, color: CafeColors.danger),
                title: const Text('خروج', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: CafeColors.danger)),
                onTap: () async {
                  await context.read<AuthProvider>().logout();
                  if (mounted) Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  LineChartData _buildRevenueChart(bool isDark) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1000000,
        getDrawingHorizontalLine: (value) => FlLine(
          color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider,
          strokeWidth: 1,
          dashArray: [5, 5],
        ),
      ),
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              const days = ['شنبه', 'یک', 'دو', 'سه', 'چهار', 'پنج', 'جمعه'];
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  days[value.toInt() % 7],
                  style: TextStyle(fontSize: 11, color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            getTitlesWidget: (value, meta) {
              return Text(
                '${(value / 1000000).toStringAsFixed(1)}M',
                style: TextStyle(fontSize: 10, color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          curveSmoothness: 0.4,
          spots: const [
            FlSpot(0, 1800000),
            FlSpot(1, 2200000),
            FlSpot(2, 1500000),
            FlSpot(3, 2800000),
            FlSpot(4, 3200000),
            FlSpot(5, 2500000),
            FlSpot(6, 2850000),
          ],
          color: CafeColors.primary,
          barWidth: 3,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CafeColors.primary.withValues(alpha: 0.25),
                CafeColors.primary.withValues(alpha: 0.02),
              ],
            ),
          ),
        ),
      ],
    );
  }

  PieChartData _buildCategoryChart(bool isDark) {
    return PieChartData(
      sectionsSpace: 3,
      centerSpaceRadius: 50,
      sections: [
        PieChartSectionData(
          value: 42,
          title: '',
          color: CafeColors.primary,
          radius: 20,
        ),
        PieChartSectionData(
          value: 28,
          title: '',
          color: CafeColors.success,
          radius: 20,
        ),
        PieChartSectionData(
          value: 18,
          title: '',
          color: CafeColors.warning,
          radius: 20,
        ),
        PieChartSectionData(
          value: 12,
          title: '',
          color: CafeColors.info,
          radius: 20,
        ),
      ],
    );
  }

  Widget _buildLegend(bool isDark) {
    final items = [
      ('نوشیدنی گرم', CafeColors.primary),
      ('نوشیدنی سرد', CafeColors.success),
      ('دسر', CafeColors.warning),
      ('میان‌وعده', CafeColors.info),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 6,
      children: items.map((e) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 10, height: 10, decoration: BoxDecoration(color: e.$2, shape: BoxShape.circle)),
            const SizedBox(width: 4),
            Text(e.$1, style: TextStyle(fontSize: 11, color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted)),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildOrderRow(bool isDark, String id, String table, String items, String price, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Text(id, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary)),
          const SizedBox(width: 16),
          SizedBox(
            width: 60,
            child: Text(table, style: TextStyle(fontSize: 13, color: isDark ? CafeColors.darkTextSecondary : CafeColors.lightTextSecondary)),
          ),
          Expanded(
            child: Text(items, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: isDark ? CafeColors.darkTextSecondary : CafeColors.lightTextSecondary)),
          ),
          SizedBox(
            width: 90,
            child: Text(price, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(status, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor)),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title, value, change, suffix;
  final IconData icon;
  final Color color;
  final bool isDark;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.change,
    required this.isDark,
    this.suffix = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? CafeColors.darkSurface : CafeColors.lightSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? CafeColors.darkDivider : CafeColors.lightDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              Text(
                change,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CafeColors.success),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value + (suffix.isNotEmpty ? ' $suffix' : ''),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: isDark ? CafeColors.darkTextPrimary : CafeColors.lightTextPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? CafeColors.darkTextMuted : CafeColors.lightTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}