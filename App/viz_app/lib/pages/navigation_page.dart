import 'package:flutter/material.dart';
import 'package:viz_app/pages/prediction_page.dart';
import 'package:viz_app/pages/model_info.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPage();
}

class _NavigationPage extends State<NavigationPage> {
  int selectedIndex = 0;

// bottom naviagtion pages selected index works based on the index of the array.
  List pages = [ModelInformation(), PredictionPage()];

  @visibleForTesting
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 10,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'Predication',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Color.fromRGBO(105, 122, 248, 1),
        onTap: onItemTapped,
      ),
    );
  }
}
