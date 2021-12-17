import 'package:flutter/material.dart';
import 'package:frontend/account_page.dart';
import 'package:frontend/favorites_page.dart';
import 'package:frontend/search_page.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({Key? key}) : super(key: key);

  //Wie genau funktioniert das mit createState
  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  int _selectedIndex = 0;
  final _pages = const [
    SearchPage(),
    Favorites(),
    Account(),
    Account(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  //bulid Methode wird immer aufgerufen wenn der Zustand sich ändert
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        //callback Methode, wenn der User auf ein Item tippt
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Suche',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoriten',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Reservierung',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
