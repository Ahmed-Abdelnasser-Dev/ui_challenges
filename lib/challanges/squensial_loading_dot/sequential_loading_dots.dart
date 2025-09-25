import 'package:flutter/material.dart';

class SequentialLoadingDots extends StatefulWidget {
  const SequentialLoadingDots({super.key});

  @override
  State<SequentialLoadingDots> createState() => _SequentialLoadingDotsState();
}

class _SequentialLoadingDotsState extends State<SequentialLoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _dotAnimations;
  late List<Animation<double>> _opacityAnimations;
  static const int duration = 1000; 

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: duration),
    )..repeat();

    
    _dotAnimations = List.generate(3, (index) {
      final start = (index * 0.3).clamp(0.0, 1.0);
      final end = (start + 0.5).clamp(0.0, 1.0);
      return Tween(begin: 0.7, end: 2.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeInOut),
        ),
      );
    });

     _opacityAnimations = List.generate(3, (index) {
      final start = index * 0.2;
      final end = (start + 0.6).clamp(0.0, 1.0);
      return Tween(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeInOut),
        ),
      );
    });
  }

  

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sequential Loading Dots"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return FadeTransition(
              opacity: _opacityAnimations[index],
              child: ScaleTransition(
                scale: _dotAnimations[index],
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
