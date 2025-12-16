import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../db/data_base_helper.dart';
import '../models/Notification.dart';
import '../providers/app_state_notification.dart';

class ContainerNotiDetail extends StatefulWidget {

  const ContainerNotiDetail({super.key});

  @override
  State<ContainerNotiDetail> createState() => _ContainerNotiDetailState();
}

class _ContainerNotiDetailState extends State<ContainerNotiDetail> {

  final List<IconData> notificationIcons = [
    Icons.notifications_active,   // notificación activa
    Icons.notifications,          // notificación normal
    Icons.alarm,                  // alarma
    Icons.alarm_on,               // alarma activada
    Icons.schedule,               // horario / tiempo
    Icons.access_time,            // reloj
    Icons.event,                  // evento
    Icons.calendar_today,         // calendario
    Icons.task_alt,               // tarea completable
    Icons.assignment,             // recordatorio / tarea
    Icons.warning_amber,          // aviso
    Icons.info_outline,           // información
  ];


  final List<Color> types = [
    const Color.fromRGBO(255, 165, 0, 0.1),
    const Color.fromRGBO(255, 0, 0, 0.1),
    const Color.fromRGBO(0, 128, 0, 0.1)
  ];

  final Random _random = Random();

  String formattedDateTime(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}/"
        "${dateTime.month.toString().padLeft(2, '0')}/"
        "${dateTime.year} "
        "${dateTime.hour.toString().padLeft(2, '0')}:"
        "${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    // Cargar las notificaciones cuando el widget se inicie
    context.read<AppStateNotification>().loadNotifications();
  }

  Future<List<NotificationModel>> getAllNotifications() async {
    final List<Map<String, dynamic>> maps = await DataBaseHelper.instance.getNotificaction();
    return List.generate(maps.length, (i) {
      return NotificationModel.fromMap(maps[i]);
    });
  }

  @override
  Widget build(BuildContext context) {

    return
      SafeArea(
        child: Column(
          children: [
            // Lista de notificaciones
            Expanded(
              child: Consumer<AppStateNotification>(
                builder: (context, appState, child) {
                  final notifications = appState.notifications;
                  if (notifications.isEmpty) {
                    return const Center(child: Text('No hay notificaciones'));
                  }
                  return ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return _buildItem(notifications[index]);
                    },
                  );
                },
              ),
            ),
            // Leyenda de colores
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _colorLegend(types[0], 'Diario'),
                    _colorLegend(types[1], 'Semanal'),
                    _colorLegend(types[2], 'Una Vez'),
                  ],
                ),
              ),
            ),
          ],
        )
      );

  }

// Función auxiliar para mostrar un cuadrito de color con etiqueta
  Widget _colorLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color.withOpacity(0.6),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }


  Widget _buildItem(NotificationModel notification) {
    final icon = notificationIcons[_random.nextInt(notificationIcons.length)];
    final formattedTime = formattedDateTime(notification.time);

    Color typeColor;

    if(notification.type == 'Diario'){
      typeColor = types[0];
    }else if(notification.type == 'Semanal'){
      typeColor = types[1];
    }else{
      typeColor = types[2];
    }

    return Card(
      color: typeColor.withOpacity(0.5),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(
          notification.title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: notification.body,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
              const TextSpan(text: '\n\n'),
              TextSpan(
                text: formattedTime,
                style: const TextStyle(
                  color: Colors.white70, // otro color
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.white),
          onPressed: () {
            context
                .read<AppStateNotification>()
                .deleteNotification(notification.id);
          },
        ),
      ),
    );
  }
}

