import 'package:flutter/material.dart';
import '../templates/noti_detail_template.dart';

class NotiDetailScreen extends StatefulWidget {
  const NotiDetailScreen({super.key});

  @override
  State<NotiDetailScreen> createState() => _NotiDetailScreenState();
}

class _NotiDetailScreenState extends State<NotiDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return NotiDetailTemplate();
  }
}
