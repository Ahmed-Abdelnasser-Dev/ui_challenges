import 'package:flutter/material.dart';
import 'package:three_ui_challenges/base_app.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: BaseApp(),
        ),
      ),
    );
  }
}
