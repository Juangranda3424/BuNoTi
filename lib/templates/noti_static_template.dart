import 'package:flutter/material.dart';

import '../organisms/container_noti_static.dart';

class NotiStaticTemplate extends StatefulWidget {

  final TextEditingController titleCtrl;
  final TextEditingController messageCtrl;
  final TextEditingController timeCtrl;
  final VoidCallback registerPressed;
  final VoidCallback demoPressed;
  final VoidCallback deletePressed;
  final int? selectedRepeat;
  final Function(int) onPressed;


  const NotiStaticTemplate({super.key, required this.registerPressed, required this.demoPressed, required this.deletePressed, required this.titleCtrl, required this.messageCtrl, required this.timeCtrl, required this.selectedRepeat, required this.onPressed});

  @override
  State<NotiStaticTemplate> createState() => _NotiStaticTemplateState();
}

class _NotiStaticTemplateState extends State<NotiStaticTemplate> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ContainerNotiStatic(
        titleCtrl: widget.titleCtrl,
        messageCtrl: widget.messageCtrl,
        timeCtrl: widget.timeCtrl,
        registerPressed: widget.registerPressed,
        demoPressed: widget.demoPressed,
        deletePressed: widget.deletePressed,
        selectedRepeat: widget.selectedRepeat,
        onPressed: widget.onPressed,
      )
    );
  }
}
