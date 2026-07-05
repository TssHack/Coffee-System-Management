import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('پروفایل')),
        body: const Center(child: Text('پروفایل و باشگاه مشتریان - به زودی')),
      ),
    );
  }
}