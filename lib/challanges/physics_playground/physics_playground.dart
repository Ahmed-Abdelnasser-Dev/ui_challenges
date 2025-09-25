import 'package:flutter/material.dart';

class PhysicsPlayground extends StatelessWidget {
  const PhysicsPlayground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Physics Playground"),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
    );
  }
}