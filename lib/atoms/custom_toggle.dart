import 'package:flutter/material.dart';

class CustomToggle extends StatefulWidget {

  final int? selectedRepeat;
  final Function(int) onPressed;

  const CustomToggle({super.key, required this.selectedRepeat, required this.onPressed});

  @override
  State<CustomToggle> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [
        widget.selectedRepeat == 0,
        widget.selectedRepeat == 1,
      ],
      borderRadius: BorderRadius.circular(4),
      selectedColor: Colors.white,
      fillColor: const Color.fromRGBO(8, 153, 253, 1.0),
      color: Colors.grey,
      constraints: const BoxConstraints(
        minHeight: 50,
        minWidth: 120,
      ),
      onPressed: widget.onPressed,
      children: const [
        Text('Diario'),
        Text('Semanal'),
      ],
    );
  }
}
