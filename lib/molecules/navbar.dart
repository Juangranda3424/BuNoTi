import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color.fromRGBO(8, 153, 253, 1.0),
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.notification_add),
          label: "NoTI+",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: "NoTis",
        ),
      ],
    );
  }
}
