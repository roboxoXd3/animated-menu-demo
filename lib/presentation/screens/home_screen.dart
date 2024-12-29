import 'package:flutter/material.dart';
import '../widgets/animated_menu/animated_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Animated Menu Demo'),
      ),
      body: const Center(child: AnimatedMenu()),
      backgroundColor: Color(0xFFF3E5F5),
    );
  }
}
