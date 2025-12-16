import 'package:flutter/material.dart';

import '../atoms/custom_text.dart';

class Tollbar extends StatelessWidget implements PreferredSizeWidget {
  final String titlePage;
  final bool showBackButton;
  const Tollbar({
    super.key,
    required this.titlePage,
    this.showBackButton = true
    });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: showBackButton,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: titlePage, fontSize: 20),
            const CustomText(text: 'BuNoTi', fontSize: 20, color: Color.fromRGBO(8,153,253, 1.0),),
          ],
        ),

      );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}