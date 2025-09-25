import 'package:flutter/material.dart';

class SquensialLoadingDots extends StatelessWidget {
  const SquensialLoadingDots({super.key});

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
    );
  }
}