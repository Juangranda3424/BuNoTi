import 'package:flutter/material.dart';
import '../molecules/navbar.dart';
import '../molecules/tollbar.dart';
import 'noti_detail_screen.dart';
import 'noti_static_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    NotiStaticScreen(),
    NotiDetailScreen(),
  ];

  final List<String> _titles = const [
    'NoTi+',
    'NoTis',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Tollbar(
        titlePage: _titles[_currentIndex],
        showBackButton: false,
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
