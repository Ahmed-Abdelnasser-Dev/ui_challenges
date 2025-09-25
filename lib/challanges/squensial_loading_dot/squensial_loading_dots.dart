import 'package:flutter/material.dart';

class SquensialLoadingDots extends StatefulWidget {
  const SquensialLoadingDots({super.key});

  @override
  State<SquensialLoadingDots> createState() => _SquensialLoadingDotsState();
}

class _SquensialLoadingDotsState extends State<SquensialLoadingDots> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sequential Loading Dots"),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
