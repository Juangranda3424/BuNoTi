import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../atoms/text_alert.dart';
import '../providers/app_state_notification.dart';
import '../services/notification_service.dart';
import '../templates/noti_static_template.dart';

class NotiStaticScreen extends StatefulWidget {

  const NotiStaticScreen({super.key});

  @override
  State<NotiStaticScreen> createState() => _NotiStaticScreenState();
}

class _NotiStaticScreenState extends State<NotiStaticScreen> {

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController messageCtrl = TextEditingController();
  final TextEditingController timeCtrl = TextEditingController();
  int? selectedRepeat;
  String notificationType = 'Una Vez';


  void onPressed(int value){
    setState(() {
      selectedRepeat = value;
    });
  }


  void registerPressed() async {

    bool response = false;

    if(titleCtrl.text.isEmpty || messageCtrl.text.isEmpty || timeCtrl.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextAlert(text: 'Verifique que esten llenos todos los campos.')
        ),
      );
      return;
    }

    switch (selectedRepeat) {
      case 0:
        notificationType = 'Diario';
        break;
      case 1:
        notificationType = 'Semanal';
        break;
      default:
        notificationType = 'Una Vez';
    }

    switch(selectedRepeat){
      case 0:
        response = await scheduleDailyNotification(
          generateNotificationId(),
          titleCtrl.text,
          messageCtrl.text,
          parseDateTime(timeCtrl.text),
          notificationType
        );
        break;
      case 1:
        response = await scheduleWeeklyNotification(
          generateNotificationId(),
          titleCtrl.text,
          messageCtrl.text,
          parseDateTime(timeCtrl.text),
          notificationType
        );
        break;
      default:
        response = await scheduleNotification(
          titleCtrl.text,
          messageCtrl.text,
          parseDateTime(timeCtrl.text),
          notificationType
        );
        break;
    }

    if(response){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: TextAlert(text: 'Notificación programada con éxito.'),
        ),
      );
      context.read<AppStateNotification>().loadNotifications();
      deletePressed();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextAlert(text: 'Seleccione una fecha y hora posteriores a la actual, verifique que esten llenos todos los datos correctamente.')
        ),
      );
    }
  }

  void demoPressed() async {
    showSimpleNotification(titleCtrl.text, messageCtrl.text);
  }

  void deletePressed() {
    titleCtrl.clear();
    messageCtrl.clear();
    timeCtrl.clear();
    setState(() {
      selectedRepeat = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotiStaticTemplate(
      registerPressed: registerPressed,
      demoPressed: demoPressed,
      deletePressed: deletePressed,
      titleCtrl: titleCtrl,
      messageCtrl: messageCtrl,
      timeCtrl: timeCtrl,
      selectedRepeat: selectedRepeat,
      onPressed: onPressed,
    );
  }
}
