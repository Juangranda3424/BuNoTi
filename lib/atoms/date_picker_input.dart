import 'package:flutter/material.dart';

class DatePickerInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const DatePickerInput({
    super.key,
    required this.label,
    required this.controller,
  });

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime now = DateTime.now();

    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2200),
    );

    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    final DateTime finalDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    controller.text =
    "${finalDateTime.day.toString().padLeft(2, '0')}/"
        "${finalDateTime.month.toString().padLeft(2, '0')}/"
        "${finalDateTime.year} "
        "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: label,
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDateTime(context),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
