import 'package:flutter/material.dart';

import '../organisms/container_noti_detail.dart';

class NotiDetailTemplate extends StatefulWidget {
  const NotiDetailTemplate({super.key});

  @override
  State<NotiDetailTemplate> createState() => _NotiDetailTemplateState();
}

class _NotiDetailTemplateState extends State<NotiDetailTemplate> {
  @override
  Widget build(BuildContext context) {
    return ContainerNotiDetail();
  }
}

