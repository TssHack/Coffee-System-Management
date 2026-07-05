import 'package:flutter/material.dart';
class BaristasScreen extends StatelessWidget {
  const BaristasScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(appBar: AppBar(title: const Text('باریستاها'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => Navigator.pop(context))), body: const Center(child: Text('مدیریت باریستاها - به زودی'))));
  }
}