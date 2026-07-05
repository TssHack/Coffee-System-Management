import 'package:flutter/material.dart';
class DiscountsScreen extends StatelessWidget {
  const DiscountsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(appBar: AppBar(title: const Text('تخفیفات'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => Navigator.pop(context))), body: const Center(child: Text('مدیریت تخفیفات - به زودی'))));
  }
}