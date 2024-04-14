import 'package:flutter/material.dart';
import 'package:viz_app/pages/navigation_page.dart';

void main() => runApp(const VizApp());

class VizApp extends StatelessWidget {
  const VizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationPage(),
    );
  }
}
